#!/usr/bin/env bash
if [ ! -e /opt/pycharm-2016.3.2/ ]
then
    wget -q --no-clobber https://download.jetbrains.com/python/pycharm-professional-2016.3.2.tar.gz -O /tmp/pycharm-professional-2016.3.2.tar.gz
    tar xfv /tmp/pycharm-professional-2016.3.2.tar.gz -C /opt/
fi
