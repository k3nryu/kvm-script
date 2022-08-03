#! /bin/bash

# OSミラーとVMディスクの場所
dvd=/mirrors
img=/vmdisk

# VM用のディスクの作成
read -p "Please enter the name of the virtual machine(e.g cms210101): " vmname
qemu-img convert \
  -f qcow2 \
  -O qcow2 \
  /mirrors/amzn2-kvm-2.0.20220606.1-x86_64.xfs.gpt.qcow2\
  /vmdisk/$vmname.qcow2

# VMをインストール
read -p "Please enter the cores of the vCPU(e.g 2): " vmcpu
read -p "Please enter the memory size(MiB, e.g 4096): " vmmem

virt-install \
    -r "$vmmem" \
    --vcpus $vmcpu \
    --name $vmname \
    --disk /vmdisk/$vmname.qcow2,device=disk,bus=virtio,format=qcow2 \
    --os-type Linux \
    --os-variant centos7.0 \
    --network bridge=br0  \
    --virt-type kvm \
    --graphics vnc,listen=0.0.0.0,port=5910 \
    --import
exit
