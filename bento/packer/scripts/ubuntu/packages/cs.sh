#!/bin/sh

#install conscript
if which cs >/dev/null; then
    echo "skip conscript installation"
else
	echo "install conscript"
	apt-get install curl
	su -l vagrant -c "curl https://raw.githubusercontent.com/n8han/conscript/master/setup.sh | sh"
	echo "export PATH=$PATH:/home/vagrant/bin/" > /etc/profile.d/conscript.sh
	chmod a+x /etc/profile.d/conscript.sh
fi