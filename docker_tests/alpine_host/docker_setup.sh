#!/bin/sh

# mostly following https://wiki.alpinelinux.org/wiki/Docker here

# add community repo and update
echo "http://dl-cdn.alpinelinux.org/alpine/edge/community"\
  >> /etc/apk/repositories
apk update

# install docker
apk add docker --no-cache

# make sure it runs at boot
apk add openrc --no-cache
rc-update add docker boot

# start docker
service docker start  # this fails
