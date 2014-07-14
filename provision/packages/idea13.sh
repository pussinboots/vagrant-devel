#!/bin/sh

# download idea 13
if [ -d "/home/vagrant/workspace/devel/idea/idea-IU-135.909" ]; then
    echo "skip idea 13 installation"
else
	echo "idea 13 installation"
	mkdir -p /home/vagrant/workspace/devel/idea
	cd /home/vagrant/workspace/devel/idea
	wget -nv http://download.jetbrains.com/idea/ideaIU-13.1.3.tar.gz
	# unzip idea
	tar xvfz ideaIU-13.1.3.tar.gz
	rm ideaIU-13.1.3.tar.gz
fi