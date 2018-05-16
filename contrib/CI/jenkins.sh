#!/bin/bash

#
# variables
#
commit=0

#
# functions
#

print_log()
{
    if [[ -e 'var/install.log' ]]
    then
        echo ""
        echo "install.log"
        echo ""
        tail -100 var/install.log
        echo ""
    fi

    if [[ -e 'var/build.log' ]]
    then
        echo ""
        echo "build.log"
        echo ""
        tail -100 var/build.log
        echo ""
    fi
}

copy_build_out()
{
    if [[ 0 -lt $(ls build/out/opcx-* 2>/dev/null | wc -w) ]]
    then
        now=$(date +"%Y-%m-%d")
        dir="${RELEASEDIR}/$now/$commit/$1" # $1 first param, platform name
        echo "Creating release directory: $dir"
        mkdir -p $dir
        echo "Copying files to release directory..."
        mv build/out/* $dir
    else
        echo "build/out does not contain required files, looks like build failed."
        echo `ls -l build/out`
    fi
}

#
# entry point
#

set -e
echo 'Build started...'

if [[ ! -e 'bin/make-base-vm' ]]
then
    echo 'Run this script from gitian-builder root folder.'
    exit 1
fi

if [[ ! -e 'OPCoinX' ]]
then
    echo "Clonning git repository..."
    git clone https://github.com/OPCoinX/OPCoinX.git 
else
    echo "Updating git repository..."
    pushd `pwd`
    cd OPCoinX
    git pull
    popd
fi

if [[ ! -z "${BRANCH}" ]]
then
    echo "Switching to the branch=${BRANCH}..."
    pushd `pwd`
    cd OPCoinX
    git checkout "${BRANCH}"
    popd
fi

if [[ -z "${COMMIT}" ]]
then
    echo "Commit variable is not specified, extracting from repo..."
    pushd `pwd`
    cd OPCoinX
    commit=`git rev-parse HEAD`
    popd
else
    echo "Commit variable is specified, COMMIT=${COMMIT}"
    commit="${COMMIT}"
fi

echo "Commit hash to build from is: $commit, len=${#commit}"
if [[ ${#commit} -eq 40 ]]
then
    echo "Commit hash has accepted."
else
    echo "Commit hash is wrong, stop."
    exit 1
fi

if [[ -z "${RELEASEDIR}" ]]
then
    echo "Release dir is not specified, exit."
    echo "Set release dir in the environment variable: RELEASEDIR"
    exit 1
fi

if [[ -e 'base-trusty-amd64' ]]
then
    echo 'Removing old vm...'
    rm base-trusty-amd64
fi

echo 'Creating base vm...'
bin/make-base-vm --lxc --arch amd64 --suite trusty


if [[ ! -e 'inputs/MacOSX10.11.sdk.tar.gz' ]]
then
    echo 'Downloading MacOS sdk...'
    mkdir -p inputs
    wget -N -P inputs https://github.com/phracker/MacOSX-SDKs/releases/download/10.13/MacOSX10.11.sdk.tar.xz
    mv inputs/MacOSX10.11.sdk.tar.xz inputs/MacOSX10.11.sdk.tar.gz
else
    echo 'MacOS SDK is up to date.'
fi

echo 'Building dependencies...'
rm -rf OPCoinX/depends/work
rm -rf `pwd`/cache/common
make -C OPCoinX/depends download SOURCES_PATH=`pwd`/cache/common

export USE_LXC=1
set +e # we have to collect and print logs

echo ""
echo "Compiling for Mac OSX"
echo ""
bin/gbuild --commit OPCoinX=$commit  OPCoinX/contrib/gitian-descriptors/gitian-osx.yml
copy_build_out "osx"
print_log

echo ""
echo "Compiling for Linux"
echo ""
bin/gbuild --commit OPCoinX=$commit  OPCoinX/contrib/gitian-descriptors/gitian-linux.yml
copy_build_out "linux"
print_log

echo ""
echo "Compiling for Windows"
echo ""
bin/gbuild --commit OPCoinX=$commit  OPCoinX/contrib/gitian-descriptors/gitian-win.yml
copy_build_out "win"
print_log

echo 'Done'
