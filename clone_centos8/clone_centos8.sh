#! /bin/bash
conf=/etc/libvirt/qemu
#img=/var/lib/libvirt/images
#dvd=/mirrors
img=/vmdisk
read -p "Please enter the name of VM (e.g. cms-210101-0):  " name
cp /root/clone_centos8/centos8.xml $conf/"$name".xml
#qemu-img create -f qcow2 -b /root/clone_centos8/centos8.qcow2 $img/"$name".qcow2 >/dev/null
cp /root/clone_centos8/centos8.qcow2 $img/"$name".qcow2 
sed -ri "/<name>/c<name>$name</name>" $conf/"$name".xml
read -p "vCPU is 2cores, is this OK? (yes/no): " cho
if [[ $cho == "no" ]];then
   read -p "Please enter the number of vCPU cores: " num
   sed -ri "/<vcpu placement/c<vcpu placement='static'>$num</vcpu>" $conf/"$name".xml
fi
read -p "RAM is 4GiB, is this OK? (yes/no): " cho1
if [[ $cho1 == "no" ]];then
   read -p "Please enter the RAM size(KiB) " mem
   sed -ri "/<memory unit='KiB/c<memory unit='KiB'>$mem</memory>" $conf/"$name".xml
fi
sed -ri "/<uuid>/c<uuid>`uuidgen`</uuid>" $conf/"$name".xml
sed -ri "/<source file/c<source file='$img/"$name".qcow2'/>" $conf/"$name".xml
mac=`openssl rand -hex 3 | sed -r 's/..\B/&:/g'`
sed -ri "/<mac address/c<mac address='52:54:00:$mac'/>" $conf/"$name".xml
virsh define $conf/"$name".xml
echo 'Congratulations you have successfully created a CentOS8!'
virsh list --all
