#!/usr/bin/env bash

# Must be root !
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Latest Stable
CHR_VERSION=6.46.8
PASSWORD=ims3cure

# Environment
INTERFACE=$(ip -o -4 route show to default | awk '{print $5}')
INTERFACE_IP=$(ip addr show $INTERFACE | grep global | cut -d' ' -f 6 | head -n 1)
INTERFACE_GATEWAY=$(ip route show | grep default | awk '{print $3}')

wget -qO routeros.zip https://download.mikrotik.com/routeros/$CHR_VERSION/chr-$CHR_VERSION.img.zip && \
unzip routeros.zip && \
rm -rf routeros.zip

mount -o loop,offset=512 chr-$CHR_VERSION.img /mnt

echo "
/ip address add address=${INTERFACE_IP} interface=[/interface ethernet find where name=ether1]
/ip route add gateway=${INTERFACE_GATEWAY}
/user set [find name=admin] password=${PASSWORD}
" > /mnt/rw/autorun.scr

unmount /mnt
echo u > /proc/sysrq-trigger
dd if=chr-$CHR_VERSION.img of=/dev/vda

reboot
