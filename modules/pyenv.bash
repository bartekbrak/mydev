#!/usr/bin/env bash
if [ "$EUID" -ne 0 ]
then
    (
    [[ ! -d "~/.pyenv" ]] && git clone https://github.com/yyuu/pyenv.git ~/.pyenv
    [[ ! -d "~/.pyenv/plugins/pyenv-virtualenv" ]] && git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
    )
else 
    echo "Don't run as root."
    # Well, I didn't experiment with global install, might be possible
fi
