#!/bin/bash

DEVICE=/dev/sdb
PARTITION="${DEVICE}1"

echo "clean 0 ~ 1023 bytes of SD card"
dd if=/dev/zero of=${DEVICE} bs=1M count=1
sync

echo "use entire SD card"
sfdisk --in-order -uM ${DEVICE} <<EOF
1,,L
;
;
;
EOF

echo "list all partitions of SD card"
sync
sync
parted ${DEVICE} print
fdisk -l ${DEVICE}

echo "format ${PARTITION} as ext4"
sync
sync
mkfs.ext4 ${PARTITION}

cd /root
wget -qO- https://launchpad.net/linaro-toolchain-binaries/trunk/2013.04/+download/gcc-linaro-arm-linux-gnueabihf-4.7-2013.04-20130415_linux.tar.xz | tar Jxv

wget https://github.com/hno/u-boot/archive/wip/a20.zip
wget https://github.com/hramrach/linux-sunxi/archive/sunxi-3.3-cb2.zip
wget https://releases.linaro.org/12.04/ubuntu/precise-images/alip/linaro-precise-alip-20120426-84.tar.gz

# https://releases.linaro.org/14.01/ubuntu/saucy-images/server
# https://releases.linaro.org/12.04/ubuntu/precise-images/alip

git clone https://github.com/linux-sunxi/sunxi-tools.git
git clone https://github.com/linux-sunxi/sunxi-boards.git