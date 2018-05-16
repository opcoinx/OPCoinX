Setup build server
================

### Pre-conditions

Debian 8.1 x64 server: ssh + standard utilities, user with name: debian, root access.

Read next links before get started: [DASH](https://forum.bits.media/index.php?/topic/18648-%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-%D1%84%D0%BE%D1%80%D0%BA%D0%B0-%D0%BD%D0%B0-%D0%BE%D1%81%D0%BD%D0%BE%D0%B2%D0%B5-dash/) and [PIVX](https://github.com/PIVX-Project/PIVX/blob/master/doc/gitian-building.md)

### Build environment

Scripts that does setup of build environment: `setup_lxc.sh, setup_vm_builder.sh`

MacOS SDK have to be placed in the inputs folder: [MacOSX10.11.sdk.tar.xz](https://github.com/phracker/MacOSX-SDKs/releases/download/10.13/MacOSX10.11.sdk.tar.xz)


### Jenkins CI

Install Java: https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-debian-8

Install Jenkins: https://blog.programster.org/debian-8-install-jenkins

Script that does this stuff: `setup_jenkins.sh`

Test: http://[Jenkins Server IP]:8080


### Configure Jenkins

Open Jenkins admin console: http://[Jenkins Server IP]:8080

Enter admin password and install recommended plugins, create admin user.

Add two jobs: one for building master and another for building particular commit.

Project name: opcx-master or opcx-dev

Description: Build OPCX for Win, Mac, Linux

Mark: Discard old builds

Mark: This project is parameterized, if you need to build specific commit add string parameter with name COMMIT for the job that builds particular commit.

In Source Code Management add git repository: https://github.com/devrandom/gitian-builder.git

In the build step paste script:

    rm -rf $WORKSPACE/jenkins.sh
    wget https://raw.githubusercontent.com/OPCoinX/OPCoinX/master/contrib/CI/jenkins.sh -O $WORKSPACE/jenkins.sh
    chmod +x $WORKSPACE/jenkins.sh
    export RELEASEDIR=/var/www/opcx
    $WORKSPACE/jenkins.sh

Optionally add schedule to build every day:

    TZ=Europe/London
    # This job needs to be run in the midnight, London time
    H 0 * * *

Create directory `/var/www/opcx` and make Jenkins owner of that directory

    sudo mkdir /var/www/opcx
    sudo chown jenkins /var/www/opcx

    
### Setup developer machine with QtCreator as IDE

Install build tools and build dependencies (Ubuntu 16.04)

    sudo apt-get install build-essential libtool autotools-dev autoconf pkg-config curl git
    git clone https://github.com/OPCoinX/OPCoinX.git 
    cd OPCoinX/depends
    make

Install build tools and build dependencies (OSX 10.11)

    Install XCode from App Store or download from https://developer.apple.com/xcode/ (8.2.1 for OSX 10.11)
    Install the OS X command line tools: xcode-select --install
    Qt fix: https://stackoverflow.com/questions/33728905/qt-creator-project-error-xcode-not-set-up-properly-you-may-need-to-confirm-t
    cd /Applications/Xcode.app/Contents/Developer/usr/bin/
    sudo ln -s xcodebuild xcrun
    Install https://brew.sh
    brew install autoconf automake libtool pkg-config
    git clone https://github.com/OPCoinX/OPCoinX.git 
    cd OPCoinX/depends
    make

Build OPCX

Select appropriate host, see `depends` folder after previous step has done.

    cd ..
    ./autogen.sh
    export HOSTS=x86_64-pc-linux-gnu
    export BASEPREFIX=`pwd`/depends
    CONFIG_SITE=${BASEPREFIX}/`echo "${HOSTS}" | awk '{print $1;}'`/share/config.site ./configure --prefix=/ --enable-debug --with-gui=qt5
    make


### Use Qt Creator as IDE

1. You can use Qt Creator as IDE, for debugging and for manipulating forms, etc.

2. Download Qt Creator from http://www.qt.io/download/. Download the "community edition" and only install Qt Creator (uncheck the rest during the installation process).

3. In Qt Creator do "New Project" -> Import Project -> Import Existing Project

4. Enter project name, enter src as location

5. Leave the file selection as it is

6. Confirm the "summary page"

7. In the "Projects" tab select "Manage Kits..."

8. Select the default "Desktop" kit and select compiler

9. Select LLDB as debugger (you might need to set the path to your installtion)

10. Select executable path

11. Start debugging with Qt Creator

12. If you have errors when compiling Qt tests then configure with option `--disable-tests`.
