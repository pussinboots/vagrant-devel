#!/bin/sh

if which play >/dev/null; then
    echo "skip play 2.2.3 installation"
else
	echo "install play 2.2.3"
	mkdir -p /home/vagrant/workspace/devel/play
	cd /home/vagrant/workspace/devel/play
	wget -nv http://downloads.typesafe.com/play/2.2.3/play-2.2.3.zip
	cd /home/vagrant/workspace/devel/play
	unzip play-2.2.3.zip
	rm play-2.2.3.zip
	echo "export PATH=$PATH:/home/vagrant/workspace/devel/play/play-2.2.3" > /etc/profile.d/play.sh
	chmod a+x /etc/profile.d/play.sh
	su -l vagrant -c "export PATH=$PATH:/home/vagrant/workspace/devel/play/play-2.2.3"
fi