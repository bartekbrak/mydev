#!/usr/bin/env bash
if ! command -v aha
then
    git clone https://github.com/theZiz/aha.git /tmp/aha
    cd /tmp/aha
    make && make install
fi
