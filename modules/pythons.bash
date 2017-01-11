#!/usr/bin/env bash
if ! command -v python3.6
then
	if [ "$EUID" -ne 0 ]
	then
    (
    	sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils
    	PYTHON_CONFIGURE_OPTS="--enable-unicode=ucs4" pyenv install 3.6.0
    )
	else
		echo "Don't run as root."
	fi
else
	echo "Already installed."
fi
