#!/usr/bin/env bash
if ! command -v slack
then
    wget https://downloads.slack-edge.com/linux_releases/slack-desktop-2.2.1-amd64.deb -O /tmp/slack-desktop-2.2.1-amd64.deb
    dpkg -i /tmp/slack-desktop-2.2.1-amd64.deb
    apt-get install -f -y
fi
