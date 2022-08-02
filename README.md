# Environment
## OS block devices
```bash
[root@kvm1 ~]# lsblk
NAME          MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda             8:0    0 139.8G  0 disk
├─sda1          8:1    0   600M  0 part /boot/efi
├─sda2          8:2    0     1G  0 part /boot
└─sda3          8:3    0 138.2G  0 part
  ├─rhel-root 253:0    0 134.1G  0 lvm  /
  └─rhel-swap 253:1    0     4G  0 lvm  [SWAP]
sdb             8:16   0 223.6G  0 disk
sdc             8:32   0 223.6G  0 disk /mirrors
sdd             8:48   0 894.3G  0 disk /share
sde             8:64   0 894.3G  0 disk /vmdisk
```

## Network
```bash
[root@kvm1 ~]# cat /etc/sysconfig/network-scripts/ifcfg-br0
DEVICE=br0
TYPE=Bridge
ONBOOT=yes
DEFROUTE=yes
UUID=585b7f99-3a39-4568-9995-f0e1d3e9dc2a
IPADDR=192.168.65.129
PREFIX=22
GATEWAY=192.168.64.1
DNS1=192.168.65.133
DNS2=192.168.65.134
STP=no
PROXY_METHOD=none
BROWSER_ONLY=no
IPV4_FAILURE_FATAL=no
IPV6INIT=no
NAME="Bridge br0"

[root@kvm1 ~]# cat /etc/sysconfig/network-scripts/ifcfg-eno1
NAME=eno1
UUID=28714e1d-9339-42d0-a676-0db9de83316c
DEVICE=eno1
ONBOOT=yes
BRIDGE=br0
```
