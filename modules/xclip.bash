#!/usr/bin/env bash
if ! command -v xclip
then
    if [ "$EUID" -eq 0 ]
    then
    (
        apt-get install -y libxmu-headers
        [[ ! -d "/tmp/COMMAND" ]] && git clone https://github.com/astrand/xclip.git /tmp/COMMAND
        cd /tmp/xclip
        autoreconf
        ./configure
        make
        make install
        make install.man
    )
    else
        echo "Run as root."
    fi
else
    echo "Already installed."
fi

