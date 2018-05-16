#!/bin/bash

set -e

if [ `id -u` = 0 ] ; then
    echo 'Starting setup...'
else
    echo 'Root privilegies are required, exit.'
    exit 1
fi

apt-get update

apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common
	 
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -

apt-key fingerprint 0EBFCD88

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"
   
apt-get update

apt-get install docker-ce

docker run hello-world

echo 'Done.'
