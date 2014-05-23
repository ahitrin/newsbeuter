#!/bin/bash

apt-get update

INSTALL="apt-get install -y"

# Common code tools
apt-get install -y \
    git-core build-essential autoconf libtool gettext \
    ruby libruby ruby-dev swig libncurses5 libncurses5-dev \
    libstfl-dev libcurl4-openssl-dev libsqlite3-dev libxml2-dev \
    bc \
    nodejs curl

cd /tmp

install_tuitest() {
    [ -d tuitest ] || git clone https://github.com/akrennmair/tuitest.git
    cd tuitest
    sed -i 's/-lruby"/-lruby1.8"/' Makefile
    make && make prefix=/usr install
    [ "$?" == "0" ] || exit 1
    cd -
}

[ `which tt-record 2>/dev/null` ] || install_tuitest

install_json_c() {
    [ -d json-c ] || git clone https://github.com/json-c/json-c.git
    cd json-c
    git checkout json-c-0.11-20130402
    sh autogen.sh && ./configure --libdir=/usr/lib && make && make install
    [ "$?" == "0" ] || exit 1
    cd -
}

[ -f /usr/lib/libjson-c.so ] || install_json_c
