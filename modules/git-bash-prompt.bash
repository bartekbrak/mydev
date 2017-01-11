#!/usr/bin/env bash
if ! -d /opt/bash-git-prompt
then
    (
    git clone https://github.com/magicmonty/bash-git-prompt.git /opt/bash-git-prompt --depth=1
    )
fi
