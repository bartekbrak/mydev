#!/usr/bin/env bash
if ! command -v tmux
then
    (
        apt-get install -y libevent-dev pkg-config automake gcc autogen libncurses5-dev make
        [[ ! -d "/tmp/tmux" ]] && git clone https://github.com/tmux/tmux.git /tmp/tmux
        cd /tmp/tmux
        sh autogen.sh
        ./configure && make && make install
    )
fi
