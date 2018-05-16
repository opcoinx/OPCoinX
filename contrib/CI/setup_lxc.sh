#!/bin/bash

set -e

if [ `id -u` = 0 ] ; then
    echo 'Starting setup...'
else
    echo 'Root privilegies are required, exit.'
    exit 1
fi

apt-get update
apt-get upgrade
apt-get install git ruby sudo apt-cacher-ng qemu-utils debootstrap lxc python-cheetah parted kpartx bridge-utils python-dev python-pip python2.7-dev libssl-dev curl
adduser debian sudo
echo "%sudo ALL=NOPASSWD: /usr/bin/lxc-start" > /etc/sudoers.d/gitian-lxc
echo "cgroup  /sys/fs/cgroup  cgroup  defaults  0   0" >> /etc/fstab
echo '#!/bin/sh -e' > /etc/rc.local
echo 'brctl addbr br0' >> /etc/rc.local
echo 'ifconfig br0 10.0.2.2/24 up' >> /etc/rc.local
echo 'exit 0' >> /etc/rc.local
# make sure that USE_LXC is always set when logging in as debian,
# and configure LXC IP addresses
echo 'export USE_LXC=1' >> /home/debian/.profile
echo 'export GITIAN_HOST_IP=10.0.2.2' >> /home/debian/.profile
echo 'export LXC_GUEST_IP=10.0.2.5' >> /home/debian/.profile

echo 'Done, reboot now.'

