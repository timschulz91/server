#!/bin/bash

# install SnapRAID
apk add snapraid

# copy config files into system
cp snapraid_setup/configs/snapraid.conf /etc/snapraid.conf
