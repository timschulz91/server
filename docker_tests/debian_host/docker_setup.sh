#!/bin/sh

# mostly following https://docs.docker.com/engine/installation/linux/docker-ce/debian/#install-using-the-repository

# get everything up-to-date
apt update && apt upgrade -y

# add the docker repo
apt install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"

# install Docker
apt update && apt install -y docker-ce
