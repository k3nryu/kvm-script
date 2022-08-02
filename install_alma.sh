#! /bin/bash

# OSミラーとVMディスクの場所
dvd=/mirrors
img=/vmdisk

# VM用のディスクの作成
read -p "Please enter the name of the virtual machine(e.g cms210101): " vmname
qemu-img create -f qcow2 $img/$vmname.qcow2 20G >/dev/null

# VMをインストール
read -p "Please enter the cores of the vCPU(e.g 2): " vmcpu
read -p "Please enter the memory size(MiB, e.g 4096): " vmmem

virt-install \
    --name "$vmname" \
    -r "$vmmem" \
    --disk $img/$vmname.qcow2,sparse \
    -l $dvd/AlmaLinux-8.6-x86_64-dvd.iso \
    --vcpus=$vmcpu \
    --network bridge=br0  \
    --nographics \
    -x 'console=ttyS0'

exit
