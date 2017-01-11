#!/usr/bin/env bash
if ! command -v sxhkd
then
    git clone https://github.com/baskerville/sxhkd.git /tmp/sxhkd
    cd /tmp/sxhkd
    make
    make install
fi
