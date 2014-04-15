#!/bin/bash

apt-get update

INSTALL="apt-get install -y"

# Common code tools
$INSTALL git-core build-essential autoconf libtool gettext

# Install Tuitest dependencies
$INSTALL ruby libruby ruby-dev swig libncurses5 libncurses5-dev

# Install Newsbeuter dependencies
$INSTALL libstfl-dev libcurl4-openssl-dev libsqlite3-dev libxml2-dev
# Test runtime dependencies
$INSTALL bc

cd /tmp
# Build and install Tuitest
[ -d tuitest ] || git clone https://github.com/akrennmair/tuitest.git
cd tuitest
sed -i 's/-lruby"/-lruby1.8/' Makefile
make && make prefix=/usr install
[ "$?" == "0" ] || exit 1
cd -

# Build and install json-c
#[ -d json-c ] || git clone https://github.com/json-c/json-c.git
#cd json-c
#git checkout json-c-0.11-20130402
#sh autogen.sh && ./configure --libdir=/usr/lib && make && make install
#[ "$?" == "0" ] || exit 1
#cd -

# Jenkins FTW
$INSTALL openjdk-6-jre-headless daemon ttf-dejavu
DEB=jenkins_1.557_all.deb
wget -nc http://pkg.jenkins-ci.org/debian/binary/$DEB
dpkg -i $DEB

# The newest git
$INSTALL libexpat1-dev
[ -d git ] || git clone https://github.com/git/git.git
cd git
make clean && make prefix=/usr all && make prefix=/usr install
cd -
