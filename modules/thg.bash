#!/usr/bin/env bash
if ! command -v thg
then
    hg clone https://bartekbrak@bitbucket.org/tortoisehg/thg /opt/thg
    cd /opt/thg
    hg pull && hg update stable
    ln -s /opt/thg/thg /usr/local/bin/thg
fi
