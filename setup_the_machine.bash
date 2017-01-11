#!/bin/bash
# Custom for Ubuntu 16.04

H=/home/bartek

# `--allow-unauthenticated` required for:
# * google-chrome-stable
# * apt-fast
# shown as `WARNING: The following packages cannot be authenticated!`


## Make bash verbose and fail on any command fail
set -e
set -x

mkdir -p /home/bartek/bin /home/bartek/opt /home/bartek/tmp /home/bartek/workspace /home/bartek/Downloads
cp -r /ubuntu16/* /

# Silence apt-fast asking questions during install
echo "apt-fast apt-fast/maxdownloads string 10" | debconf-set-selections;
echo "apt-fast apt-fast/dlflag boolean true" | debconf-set-selections;

# `unattended-upgrades` spawns early in the life of the VM and blocks apt,
# When under vagrant, it would halt the script. Let's disable it
DEBIAN_FRONTEND=noninteractive apt-get remove -y --allow-unauthenticated unattended-upgrades update-notifier

# required by "install apt-fast"
if [ ! -e /tmp/mydev_state_apt_updated ]; then apt-get update; touch /tmp/mydev_state_apt_updated; fi

# keys, required by "install apt-fast"
if [ ! -e /tmp/mydev_state_keys_added ]; then wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -; wget -q -O - http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc | apt-key add -; wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -; touch /tmp/mydev_state_keys_added; fi


# for add-apt-repository
# apt-fast requires update first
DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y --allow-unauthenticated software-properties-common
bash modules/sxhkd.bash
# apt-add-repository requires software-properties-common
apt-add-repository multiverse
apt-get update


#  make /tmp user writeable
#chmod 0757 /tmp
#chmod 0757 /opt

# Disable apport - don't suggest where to install missing command from
echo 'enabled=0' > /etc/default/apport

if ! grep 'IPYTHON_BASH_HISTORY' /etc/inputrc; then echo 'IPYTHON_BASH_HISTORY' >> /etc/inputrc; echo '"\e[A": history-search-backward' >> /etc/inputrc; echo '"\e[B": history-search-forward' >> /etc/inputrc; fi

# My packages
DEBIAN_FRONTEND=noninteractive apt-fast install --no-install-recommends -q -y --allow-unauthenticated \
    arandr dconf-editor moreutils p7zip-full unrar usbmount tree powertop imagemagick sshfs \
    htop mc numlockx most httpie nethogs silversearcher-ag \
    lua5.1 python-dev \
    terminator \
    git gitk mercurial \
    gimp ttf-dejavu libreoffice vlc filezilla gparted sqlitebrowser meld virtualbox-5.1 google-chrome-stable \
    build-essential cmake linux-headers-generic gcc \
    apt-file \
    libxcb-util-dev libxcb-keysyms1-dev \
    i3 gnome-session-flashback lightdm \
    qtbase5-dev libqt5x11extras5-dev qttools5-dev qttools5-dev-tools libgcrypt20-dev zlib1g-dev \
    httpie

if [ ! -e /tmp/mydev_state_apt_file_index_refreshed ]
then
    apt-file update
    touch /tmp/mydev_state_apt_file_index_refreshed
fi


# Download & Compile

bash modules/*


# gnome, so obsolete
# gsettings set com.canonical.desktop.interface scrollbar-mode normal

echo script took $SECONDS seconds
