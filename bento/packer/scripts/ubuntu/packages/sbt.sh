#!/bin/sh

if which sbt >/dev/null; then
	echo "skip sbt installation"
else
	#has java dependency which will be installable manual with sudo apt-get -f install
	echo "sbt installation"
	cd /tmp
	wget -nv http://dl.bintray.com/sbt/debian/sbt-0.13.5.deb
	# install sbt
	apt-get -f install
	dpkg -i sbt*.deb
	# if no jdk is installed than jdk 6 will be installed sbt depends on
	su -l vagrant -c "sbt test"
	cd -
fi