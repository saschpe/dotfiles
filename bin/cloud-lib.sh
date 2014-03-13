#!/bin/sh

CLOUD_OFFLINE_COND='[ $(virsh list --name | grep "cloud-" | wc -l) -eq 0 ]'

ADMIN_IP=${ADMIN_IP:-192.168.124.10}

CROWBAR_USER=crowbar
CROWBAR_PASSWORD=crowbar


function wait_for()
{
  timecount=${1:-300}
  timesleep=${2:-1}
  condition=${3:-'/bin/true'}
  waitfor=${4:-'unknown process'}

  echo "Waiting for: $waitfor"
  n=$timecount
  while test $n -gt 0 && ! eval $condition
  do
    echo -n .
    sleep $timesleep
    n=$(($n - 1))
  done
  echo

  if [ $n = 0 ] ; then
    echo "Error: Waiting for '$waitfor' timed out."
    echo "This check was used: $condition"
    exit 11
  fi
}

function ssh_run()
{
  ssh -t root@$ADMIN_IP "$@"
  return $?
}

function admin_allocate()
{
  echo "Waiting for nodes to come up..."
  while ! crowbar machines list | grep ^d ; do sleep 10 ; done
  echo "Found one node"
  while test $(crowbar machines list | grep ^d|wc -l) -lt $CLOUD_NODES ; do sleep 10 ; done
  nodes=$(crowbar machines list | grep ^d)
  for n in $nodes ; do
          wait_for 100 2 "knife node show -a state $n | grep discovered" "node to enter discovered state"
  done
  echo "Sleeping 50 more seconds..."
  sleep 50
  for m in `crowbar machines list | grep ^d` ; do
    while knife node show -a state $m | grep discovered; do # workaround bnc#773041
      crowbar machines allocate "$m"
      sleep 10
    done
  done
}

function admin_openrc()
{
  JSON=$(crowbar keystone show default)
  KEYSTONE_USERNAME=$(echo $JSON | python -c "import json, sys; print json.load(sys.stdin)[\"attributes\"][\"keystone\"][\"admin\"][\"username\"]")
  KEYSTONE_PASSWORD=$(echo $JSON | python -c "import json, sys; print json.load(sys.stdin)[\"attributes\"][\"keystone\"][\"admin\"][\"password\"]")
  KEYSTONE_TENANT=$(echo $JSON | python -c "import json, sys; print json.load(sys.stdin)[\"attributes\"][\"keystone\"][\"admin\"][\"tenant\"]")

  KEYSTONE_PROTOCOL=$(echo $JSON | python -c "import json, sys; print json.load(sys.stdin)[\"attributes\"][\"keystone\"][\"api\"][\"protocol\"]")
  KEYSTONE_HOST=$(echo $JSON | python -c "import json, sys; print json.load(sys.stdin)[\"deployment\"][\"keystone\"][\"elements\"][\"keystone-server\"][0]")
  KEYSTONE_PORT=$(echo $JSON | python -c "import json, sys; print json.load(sys.stdin)[\"attributes\"][\"keystone\"][\"api\"][\"service_port\"]")

  cat <<EOF > /root/.openrc.sh
export OS_USERNAME=$KEYSTONE_USERNAME
export OS_PASSWORD=$KEYSTONE_PASSWORD
export OS_TENANT_NAME=$KEYSTONE_TENANT
export OS_AUTH_URL=$KEYSTONE_PROTOCOL://$KEYSTONE_HOST:$KEYSTONE_PORT/v2.0
EOF
}

function waitnodes()
{
  n=800
  mode=$1
  proposal=$2
  case $mode in
    nodes)
      echo -n "Waiting for nodes to get ready: "
      for i in `crowbar machines list | grep ^d` ; do
        machinestatus=''
        while test $n -gt 0 && ! test "x$machinestatus" = "xready" ; do
          machinestatus=`crowbar machines show $i | ruby -e "require 'rubygems';require 'json';puts JSON.parse(STDIN.read)['state']"`
          if test "x$machinestatus" = "xfailed" -o "x$machinestatus" = "xnil" ; then
            echo "Error: machine status is failed. Exiting"
            exit 39
          fi
          sleep 5
          n=$((n-1))
          echo -n "."
        done
        n=500 ; while test $n -gt 0 && ! netcat -z $i 22 ; do
          sleep 1
          n=$(($n - 1))
          echo -n "."
        done
        echo "node $i ready"
      done
      ;;
    proposal)
      echo -n "Waiting for proposal $proposal to get successful: "
      proposalstatus=''
      while test $n -gt 0 && ! test "x$proposalstatus" = "xsuccess" ; do
        proposalstatus=`crowbar $proposal proposal show default | ruby -e "require 'rubygems';require 'json';puts JSON.parse(STDIN.read)['deployment']['$proposal']['crowbar-status']"`
        if test "x$proposalstatus" = "xfailed" ; then
          tail -n 90 /opt/dell/crowbar_framework/log/d*.log /var/log/crowbar/chef-client/d*.log
          echo "Error: proposal $proposal failed. Exiting."
          exit 40
        fi
        sleep 5
        n=$((n-1))
        echo -n "."
      done
      echo
      echo "proposal $proposal successful"
      ;;
    default)
      echo "Error: waitnodes was called with wrong parameters"
      exit 72
      ;;
  esac

  if [ $n == 0 ] ; then
    echo "Error: Waiting timed out. Exiting."
    exit 74
  fi
}
