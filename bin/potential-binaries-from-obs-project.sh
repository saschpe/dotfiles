#!/usr/bin/sh


PROJECT=${1:-Devel:Cloud:2.0}
REPO=${2:-SLE_11_SP3}
BS=${3:-IBS}


project=${PROJECT//:/:\/}
packages=()
for arch in noarch x86_64 ; do
    case $BS in
        ibs|IBS)
            BS_URL="http://download.suse.de/ibs/$project/$REPO/$arch/"
            CUT_FIELD=2
            ;;
        obs|OBS|*)
            BS_URL="http://download.opensuse.org/repositories/$project/$REPO/$arch/"
            CUT_FIELD=6
            ;;
    esac
    if [[ ${#packages[@]} -ne 0 ]] ; then
        sep="\n"
    else
        sep=""
    fi
    packages="${packages}${sep}$(curl -s $BS_URL | grep rpm | cut -d '"' -f$CUT_FIELD)"
done

name_version_re=\(.*\)-\(.*\)-.*\.rpm
names=()
for p in $packages ; do
    if [[ "$p" =~ .*(-test-|-src-|-devel|ruby*-doc|pattern|-debuginfo|-debugsource|-testsuite).* ]] ; then
        continue
    fi
    if [[ "$p" =~ $name_version_re ]] ; then
        names=(${names[@]} "${BASH_REMATCH[1]}")
       #echo "<package name=\"${BASH_REMATCH[1]}\" />"
   fi
done

echo "<!-- NOTE(saschpe): Start generated from ($BS) $PROJECT/$REPO -->"
uniq_names=$(echo "${names[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')
for un in $uniq_names ; do
    echo "<package name=\"${un}\" />"
done
echo "<!-- NOTE(saschpe): End generated from ($BS) $PROJECT/$REPO -->"
