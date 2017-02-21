#!/usr/bin/env bash
if ! command -v vimpager
then
    (
    git clone git://github.com/rkitover/vimpager /opt/vimpager
    cd /opt/vimpager
    DEBIAN_FRONTEND=noninteractive make install-deb
    )
fi

#TODO:
#
#Do you want to install the software package? [y/N]:debconf: unable to initialize frontend: Dialog
#debconf: (TERM is not set, so the dialog frontend is not usable.)
#debconf: falling back to frontend: Readline
#debconf: unable to initialize frontend: Readline
#debconf: (This frontend requires a controlling tty.)
#debconf: falling back to frontend: Teletype
#dpkg-preconfigure: unable to re-open stdin:
#debconf: unable to initialize frontend: Dialog
#debconf: (TERM is not set, so the dialog frontend is not usable.)
#debconf: falling back to frontend: Readline
#debconf: unable to initialize frontend: Readline
#debconf: (This frontend requires a controlling tty.)
#debconf: falling back to frontend: Teletype
#dpkg-preconfigure: unable to re-open stdin:
