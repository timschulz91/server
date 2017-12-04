#!/bin/sh

# get the local service to start
rc-update add local default

# add the mount script
touch /etc/local.d/mount_mergerfs.start
echo "mount -a" >> /etc/local.d/mount_mergerfs.start
chmod +x /etc/local.d/mount_mergerfs.start
