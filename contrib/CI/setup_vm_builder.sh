#!/bin/bash

set -e

if [ `id -u` = 0 ] ; then
    echo 'Starting setup...'
else
    echo 'Root privilegies are required, exit.'
    exit 1
fi

if [[ -e 'vm-builder_0.12.4+bzr489.orig.tar.gz' ]]
then
    rm vm-builder_0.12.4+bzr489.orig.tar.gz
fi

wget http://archive.ubuntu.com/ubuntu/pool/universe/v/vm-builder/vm-builder_0.12.4+bzr489.orig.tar.gz
echo 'ec12e0070a007989561bfee5862c89a32c301992dd2771c4d5078ef1b3014f03 vm-builder_0.12.4+bzr489.orig.tar.gz' | sha256sum -c
tar -zxvf vm-builder_0.12.4+bzr489.orig.tar.gz
cd vm-builder-0.12.4+bzr489
python setup.py install

echo 'Done.'
