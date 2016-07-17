#!/bin/bash

if [ ! -e vagrant_1.8.4_x86_64.deb ]
then
    wget http://releases.hashicorp.com/vagrant/1.8.4/vagrant_1.8.4_x86_64.deb
fi
sudo dpkg -i vagrant_1.8.4_x86_64.deb
vagrant up