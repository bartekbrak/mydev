#!/usr/bin/env bash

# copied from https://raw.githubusercontent.com/ilikenwf/apt-fast/master/quick-install.sh
# with sudo removed
sudo apt-get install -y aria2 git
if ! command -v apt-fast
then
    git clone https://github.com/ilikenwf/apt-fast /opt/apt-fast
    sudo cp /opt/apt-fast/apt-fast /usr/bin
    sudo chmod +x /usr/bin/apt-fast
    sudo cp /opt/apt-fast/apt-fast.conf /etc
fi
