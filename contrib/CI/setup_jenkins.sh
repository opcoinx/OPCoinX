#!/bin/bash

set -e

if [ `id -u` = 0 ] ; then
    echo 'Starting setup...'
else
    echo 'Root privilegies are required, exit.'
    exit 1
fi

# Install java
apt-get install software-properties-common -y
add-apt-repository "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main"
apt-get update
apt-get install oracle-java8-installer -y

# Add the key to your system.
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
echo "deb http://pkg.jenkins-ci.org/debian binary/" | sudo tee -a /etc/apt/sources.list

# Update and install jenkins
apt-get update
apt-get install jenkins -y

# Allow jenkins run sudo commands silently
echo "jenkins ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/jenkins

# Test installation
sudo service jenkins restart
sudo service jenkins status

echo 'Done.'
