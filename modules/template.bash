#!/usr/bin/env bash
if ! command -v COMMAND
then
    if [ "$EUID" -eq 0 ]
    then
    (
    	[[ ! -d "/tmp/COMMAND" ]] && git clone https://github.com/?? /tmp/COMMAND
    )
    else
        echo "Run as root."
    fi
else
    echo "Already installed."
fi
