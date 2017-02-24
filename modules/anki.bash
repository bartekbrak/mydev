#!/usr/bin/env bash
if ! command -v anki
then
	if [ "$EUID" -eq 0 ]
	then
    (
        cd /tmp
        wget https://apps.ankiweb.net/downloads/current/anki-2.0.42-amd64.tar.bz2 --no-clobber
        tar xjf anki-2.0.42-amd64.tar.bz2
        cd anki-2.0.42
        make install
    )
	else
		echo "Run as root."
	fi
else
	echo "Already installed."
fi
