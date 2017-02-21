#!/usr/bin/env bash

# TODO
# libcurses-perl?
if ! command -v mbank-cli
then
    git clone https://github.com/jwilk/mbank-cli /opt/mbank-cli
    cpan install Term::ReadLine::Gnu
    ln -s /opt/mbank-cli/mbank-cli /usr/local/bin/mbank-cli
fi
