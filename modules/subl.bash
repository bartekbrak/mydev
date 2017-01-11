#!/usr/bin/env bash
if ! command -v subl
then
   wget -q --no-clobber https://download.sublimetext.com/sublime-text_build-3126_amd64.deb -O /tmp/sublime-text_build-3126_amd64.deb
   dpkg -i /tmp/sublime-text_build-3126_amd64.deb
fi
