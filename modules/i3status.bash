#!/usr/bin/env bash
if ! command -v i3status
then
	if [ "$EUID" -eq 0 ]
	then
    (
    	# readme mentions asciidoc which install latex and friends, no need to
    	apt-get install -y libconfuse-dev libyajl-dev libasound2-dev libiw-dev libcap2-bin libpulse-dev libnl-genl-3-dev
    	[[ ! -d "/tmp/i3status" ]] && git clone https://github.com/bartekbrak/i3status.git /tmp/i3status
    	cd /tmp/i3status
    	sed -i '/MANPREFIX/d' Makefile
    	
    	make
    	make install
    )
	else
		echo "Run as root."
	fi
else
	echo "Already installed."
fi
