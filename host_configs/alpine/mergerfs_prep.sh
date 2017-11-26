#!/bin/bash

# set up disks
# parity disks
echo "Enter the number of parity disks:"
read paritydisks
mkdir $(printf "/mnt/parity%02i " $(seq 1 $paritydisks))
# data disks
echo "Enter the number of data disks:"
read datadisks
mkdir $(printf "/mnt/disk%02i " $(seq 1 $datadisks))
# cache disks
echo "Enter the number of cache disks:"
read cachedisks
mkdir $(printf "/mnt/cache%02i " $(seq 1 $cachedisks))

# install mergerfs
apk add mergerfs --no-cache


# install udev to /dev/disk/by-id
apk add udev --no-cache
rc-update add udev sysinit
rc-update add udev-trigger sysinit
