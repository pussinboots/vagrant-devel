#!/bin/sh

#install nvm nodejs
if su -l vagrant -c "nvm >/dev/null"; then
    echo "skip nodejs installation"
else
	echo "nodejs installation"
    su -l vagrant -c "wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.10.0/install.sh | sh"
	su -l vagrant -c "source .nvm/nvm.sh"
	su -l vagrant -c "nvm install 0.10.29"
	su -l vagrant -c "nvm alias default 0.10.29"
fi