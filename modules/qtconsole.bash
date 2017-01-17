#!/usr/bin/env bash
if ! command -v COMMAND
then
	if [ "$EUID" -ne 0 ]
	then
    (
    	apt-get install libpng12-dev libfreetype6-dev python3-pip
    	pip3 install matplotlib pyqt5 qtconsole
    )
	else
		echo "Don't run as root."
	fi
else
	echo "Already installed."
fi
