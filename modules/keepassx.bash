#!/usr/bin/env bash

# https://dev.keepassx.org/projects/keepassx/wiki/Install_instructions

if ! command -v keepassx
then
    apt-get install build-essential cmake libqt4-dev libgcrypt20-dev libxtst-dev
    git clone https://github.com/keepassx/keepassx.git /tmp/keepassx
    cd /tmp/keepassx
    mkdir build
    cd build
    export QT_SELECT=qt4
    cmake ..
    make
    make install
fi
