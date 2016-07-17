FROM ubuntu:16.04
RUN apt-get update
# apt-utils in response to debconf: delaying package configuration, since apt-utils is not installed

RUN apt-get -y install sudo wget apt-utils
RUN useradd -ms /bin/bash bartek
ADD files /files
# let sudo not ask passwords just as I'd have it set up on the machine
ADD files/etc/sudoers /etc/sudoers
USER bartek
WORKDIR /home/bartek
ADD setup_the_machine.bash setup_the_machine.bash
RUN bash setup_the_machine.bash




