#!/usr/bin/env bash
if ! command -v passmenu
then
    wget https://git.zx2c4.com/password-store/plain/contrib/dmenu/passmenu -O /usr/local/bin/passmenu
    chmod +x /usr/local/bin/passmenu
    # INSTALL PROCEDURE
fi
