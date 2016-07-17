#!/bin/bash
# only for Ubuntu 16.04

set -e
set -x

mkdir -p \
    ~/bin \
    ~/opt \
    ~/tmp \
    ~/workspace \
    ~/Downloads

sudo cp -r /vagrant/files/* /

# unattended-upgrades will spawn early in the life of the VM and block apt, this is a bug in Ubuntu
# that should get tha authors hanged
sudo apt-get remove -y unattended-upgrades

# Prevents "dpkg-preconfigure: unable to re-open stdin"
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common  # add-apt-repository

# PPAs
sudo add-apt-repository -y ppa:saiarcot895/myppa  # apt-fast

# keys
if [ ! -e ~/tmp/mydev_state_keys_added ]
then
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    wget -q -O - http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc | sudo apt-key add -
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    touch ~/tmp/mydev_state_keys_added
fi
if [ ! -e ~/tmp/mydev_state_apt_updated ]
then
    ls /var/lib/dpkg/lock
    # BUG https://github.com/mitchellh/vagrant/issues/7508
    sudo apt-get update
    touch ~/tmp/mydev_state_apt_updated
fi

# apt-fast asks questions during install
echo "apt-fast apt-fast/maxdownloads string 10" | sudo debconf-set-selections; \
echo "apt-fast apt-fast/dlflag boolean true" | sudo debconf-set-selections; \
sudo apt-get install -y apt-fast



#  make /tmp user writeable
sudo chmod 0757 /tmp

# Disable apport - don't suggest where to install missing command from
echo 'enabled=0' | sudo tee /etc/default/apport

# Disable update pop-ups
sudo apt-get remove update-notifier

sudo apt-add-repository multiverse


if ! grep 'IPYTHON_BASH_HISTORY' /etc/inputrc
then
    echo 'IPYTHON_BASH_HISTORY' | sudo tee -a /etc/inputrc
    echo '"\e[A": history-search-backward' | sudo tee -a /etc/inputrc
    echo '"\e[B": history-search-forward' | sudo tee -a /etc/inputrc
fi


# Various tools
sudo apt-fast install -q -y \
    arandr dconf-editor lua5.1 moreutils p7zip-full unrar usbmount tree powertop python-dev imagemagick sshfs terminator htop mc numlockx most httpie nethogs silversearcher-ag \
    git mercurial \
    gimp ttf-dejavu libreoffice vlc filezilla gparted sqlitebrowser meld virtualbox-5.1 google-chrome-stable \
    build-essential linux-headers-generic "linux-headers-$(uname -r)" gcc \
    apt-file \
    libxcb-util-dev libxcb-keysyms1-dev \
    i3 gnome-session-flashback lightdm

if [ ! -e ~/tmp/mydev_state_apt_file_index_refreshed ]
then
    apt-file update
    touch ~/tmp/mydev_state_apt_file_index_refreshed
fi

echo keepassx NOT DONE

echo sxhkd
if [ ! -e ~/opt/sxhkd ]
then
    git clone https://github.com/baskerville/sxhkd.git ~/opt/sxhkd
fi

if ! command -v sxhkd >/dev/null 2>&1
then
    (
    cd ~/opt/sxhkd
    make
    sudo make install
    )
fi

# disable sudo
if ! sudo grep bartek /etc/sudoers
then
   echo 'bartek ALL=NOPASSWD: ALL' | sudo tee -a /etc/sudoers
fi

if [ ! -e ~/Downloads/sublime-text_build-3114_amd64.deb ]
then
    wget -q https://download.sublimetext.com/sublime-text_build-3114_amd64.deb -O ~/Downloads/sublime-text_build-3114_amd64.deb
fi

if ! command -v subl >/dev/null 2>&1
then
   sudo dpkg -i ~/Downloads/sublime-text_build-3114_amd64.deb
fi


if [ ! -e ~/Downloads/pycharm-professional-2016.1.4.tar.gz ]
then
    wget -q https://download.jetbrains.com/python/pycharm-professional-2016.1.4.tar.gz -O ~/Downloads/pycharm-professional-2016.1.4.tar.gz
fi

if [ ! -e ~/opt/pycharm-2016.1.4/ ]
then
    tar xfv ~/Downloads/pycharm-professional-2016.1.4.tar.gz -C ~/opt/
fi


echo script took $SECONDS seconds
