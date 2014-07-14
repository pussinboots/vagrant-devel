#!/bin/sh

apt-get install htop
# install git
apt-get install git-core
apt-get -y -f install 

#install gnome window manager 
apt-get -y install gnome-session-flashback
apt-get -y install --no-install-recommends ubuntu-desktop
apt-get -y install lightdm-unity-greete
apt-get -y install gnome-terminal
echo "allow-guest=false" >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
echo "greeter-show-manual-login=true" >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
loadkeys de
apt-get -y autoremove
apt-get -y clean