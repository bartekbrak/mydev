#!/usr/bin/env bash
if ! command -v xclip
then
    git clone https://github.com/astrand/xclip.git /tmp/xclip
    cd /tmp/xclip
    autoreconf
    ./configure
    make
    make install
    make install.man
fi
