#!/usr/bin/env bash
if ! command -v ag
then
    (
    git clone https://github.com/ggreer/the_silver_searcher.git /opt/the_silver_searcher
    apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
    cd /opt/the_silver_searcher
    ./build.sh
    make install
    )
fi


# TODO add: tag
