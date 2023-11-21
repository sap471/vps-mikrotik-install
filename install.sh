#!/usr/bin/env bash

# Must be root !
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

echo "Preparation ..."
apt install unzip -y

# Latest Stable
CHR_VERSION=7.12.1

# Environment
DISK=$(lsblk | grep "disk" | head -n 1 | cut -d' ' -f1)
INTERFACE=$(ip -o -4 route show to default | awk '{print $5}')
INTERFACE_IP=$(ip addr show $INTERFACE | grep global | cut -d' ' -f 6 | head -n 1)
INTERFACE_GATEWAY=$(ip route show | grep default | awk '{print $3}')

wget -qO routeros.zip https://download.mikrotik.com/routeros/$CHR_VERSION/chr-$CHR_VERSION.img.zip && \
unzip routeros.zip && \
rm -rf routeros.zip

mount -o loop,offset=512 chr-$CHR_VERSION.img /mnt

echo "/ip address add address=${INTERFACE_IP} interface=[/interface ethernet find where name=ether1]
/ip route add gateway=${INTERFACE_GATEWAY}
" > /mnt/rw/autorun.scr

umount /mnt
echo u > /proc/sysrq-trigger
dd if=chr-$CHR_VERSION.img of=/dev/${DISK} bs=1M
