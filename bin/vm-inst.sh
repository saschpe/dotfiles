#!/bin/bash

VM_NAME=${VM_NAME:-devstack}
VM_TYPE=${VM_TYPE:-opensuse12}
MAC_ADDRESS=${MAC:-de:ad:be:ef:00:03}
RAM_SIZE=${RAM_SIZE:-2048}

mkdir -p "/var/lib/kvm/images/$VM_NAME"
qemu-img create -f raw -o size=20480M "/var/lib/kvm/images/$VM_NAME/hda"

vm-install \
    --os-type $VM_TYPE --name "$VM_NAME" \
    --vcpus 2 --memory $RAM_SIZE --max-memory $RAM_SIZE \
    --disk /var/lib/kvm/images/$VM_NAME/hda,0,disk,w,20480,sparse=1 \
    --disk /mounts/dist/install/openSUSE-12.1-GM/iso/openSUSE-12.1-NET-x86_64.iso,1,cdrom \
    --nic mac=$MAC_ADDRESS,model=virtio \
    --graphics cirrus --config-dir "/etc/libvirt/qemu" \
    --no-install --background

echo "Created /etc/libvirt/qemu/$VM_NAME.xml.."
