#! /bin/bash

# OSミラーとVMディスクの場所
dvd=/mirrors
img=/vmdisk

# VM用のディスクの作成
read -p "Please enter the name of the virtual machine(e.g cms210101): " vmname
qemu-img create -f qcow2 $img/$vmname.qcow2 40G >/dev/null

# VMをインストール
read -p "Please enter the cores of the vCPU(e.g 2): " vmcpu
read -p "Please enter the memory size(MiB, e.g 4096): " vmmem

virt-install \
    --name "$vmname" \
    -r "$vmmem" \
    --disk $img/$vmname.qcow2,sparse \
    -l $dvd/WindowsServer2022.iso \
 #  --os-type=windows --os-variant=win2k22 \
    --vcpus=$vmcpu \
    --network bridge=br0  \
    --graphics vnc,listen=0.0.0.0,port=5910 \
    --check all=no

exit
