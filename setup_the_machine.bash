#!/bin/bash
# Ubuntu 16.04

# Configure the script itself

## Make bash verbose and fail on any command fail
set -e
set -x

mkdir -p \
    ~/bin \
    ~/opt \
    ~/tmp \
    ~/workspace \
    ~/Downloads

sudo cp -r /files/* /

# apt-fast asks questions during install
echo "apt-fast apt-fast/maxdownloads string 10" | sudo debconf-set-selections;
echo "apt-fast apt-fast/dlflag boolean true" | sudo debconf-set-selections;

# unattended-upgrades will spawn early in the life of the VM and block apt,
# in case of vagrant, this will halt the script
sudo DEBIAN_FRONTEND=noninteractive apt-get remove -y unattended-upgrades update-notifier

# required by "install apt-fast"
if [ ! -e ~/tmp/mydev_state_apt_updated ]
then
    sudo apt-get update
    touch ~/tmp/mydev_state_apt_updated
fi

# keys, required by "install apt-fast"
if [ ! -e ~/tmp/mydev_state_keys_added ]
then
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    wget -q -O - http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc | sudo apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    touch ~/tmp/mydev_state_keys_added
fi


# for add-apt-repository
# apt-fast requires update first
sudo DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y software-properties-common apt-fast
sudo apt-add-repository multiverse







#  make /tmp user writeable
sudo chmod 0757 /tmp

# Disable apport - don't suggest where to install missing command from
echo 'enabled=0' | sudo tee /etc/default/apport

if ! grep 'IPYTHON_BASH_HISTORY' /etc/inputrc
then
    echo 'IPYTHON_BASH_HISTORY' | sudo tee -a /etc/inputrc
    echo '"\e[A": history-search-backward' | sudo tee -a /etc/inputrc
    echo '"\e[B": history-search-forward' | sudo tee -a /etc/inputrc
fi


# My packages
sudo DEBIAN_FRONTEND=noninteractive apt-fast install --no-install-recommends -q -y \
    arandr dconf-editor moreutils p7zip-full unrar usbmount tree powertop imagemagick sshfs \
    htop mc numlockx most httpie nethogs silversearcher-ag \
    lua5.1 python-dev \
    terminator \
    git mercurial \
    gimp ttf-dejavu libreoffice vlc filezilla gparted sqlitebrowser meld virtualbox-5.1 google-chrome-stable \
    build-essential cmake linux-headers-generic gcc \
    apt-file \
    libxcb-util-dev libxcb-keysyms1-dev \
    i3 gnome-session-flashback lightdm \
    qtbase5-dev libqt5x11extras5-dev qttools5-dev qttools5-dev-tools libgcrypt20-dev zlib1g-dev

if [ ! -e ~/tmp/mydev_state_apt_file_index_refreshed ]
then
    apt-file update
    touch ~/tmp/mydev_state_apt_file_index_refreshed
fi


# Download & Compile

if ! command -v sxhkd >/dev/null 2>&1
then
    (
    git clone https://github.com/baskerville/sxhkd.git ~/opt/sxhkd
    cd ~/opt/sxhkd
    make
    sudo make install
    )
fi


if ! command -v keepassx >/dev/null 2>&1
then
    (
    git clone git@github.com:keepassx/keepassx.git ~/opt/keepassx
    cd ~/opt/keepassx
    mkdir build
    cd build
    cmake ..
    make
    sudo make install
    )
fi


if ! command -v subl >/dev/null 2>&1
then
   wget -q --no-clobber https://download.sublimetext.com/sublime-text_build-3114_amd64.deb -O ~/Downloads/sublime-text_build-3114_amd64.deb
   sudo dpkg -i ~/Downloads/sublime-text_build-3114_amd64.deb
fi

if [ ! -e ~/opt/pycharm-2016.1.4/ ]
then
    wget -q --no-clobber https://download.jetbrains.com/python/pycharm-professional-2016.1.4.tar.gz -O ~/Downloads/pycharm-professional-2016.1.4.tar.gz
    tar xfv ~/Downloads/pycharm-professional-2016.1.4.tar.gz -C ~/opt/
fi

echo script took $SECONDS seconds
