#! /bin/bash

# OSミラーとVMディスクの場所
dvd=/mirrors
img=/share

# VM用のディスクの作成

virt-install \
    --name=test-rhel8.2 \
    --vcpus=1 \
    --ram=1024 \
    --disk /share/test-rhel82.raw \
    -l $dvd/rhel-8.2-x86_64-dvd.iso \
    --network bridge=br0  \
    --graphics vnc,port=5904,listen=0.0.0.0 \
    --cpu=host-passthrough 


exit
