#!/bin/sh

if which java >/dev/null; then
    	echo "skip java 8 oracle jdk installation"
else
	echo "install java 8 oracle jdk"
fi

if which createrepo >/dev/null; then
	echo "skip createrepo and rpm built tool installation"
else
	echo "createrepo and rpm built tool installation"
fi

if [ -f /home/vagrant/.ssh/config ]; then
	echo "skip generate ssh key"
else
	echo "generate ssh key that have to be uploaded to github"
fi

if [ -d "/home/vagrant/workspace/devel/idea/idea-IU-135.909" ]; then
    echo "skip idea 13 installation"
else
	echo "idea 13 installation"
fi

if which cs >/dev/null; then
    echo "skip sublime 3 installation"
else
	echo "sublime 3 installation"
fi

if which play >/dev/null; then
	echo "skip play 2.2.3 installation"
else
	echo "install play 2.2.3"
fi

if which cs >/dev/null; then
    echo "skip conscript installation"
else
	echo "install conscript"
fi

if which sbt >/dev/null; then
	echo "skip sbt installation"
else
	echo "sbt installation"
fi

if which heroku >/dev/null; then
    echo "skip heroku installation"
else
    echo "heroku installation"
fi

if su -l vagrant -c "nvm >/dev/null"; then
    echo "skip nodejs installation"
else
	echo "nodejs installation"
fi

if which travis >/dev/null; then
    echo "skip travis installation"
else
	echo "install travis"
fi

if which softcover >/dev/null; then
    echo "skip softcover nonstop fork installation"
else
	echo "softcover installation"
fi

echo "softcover dependency installation performed with apt-get"

if which calibre >/dev/null; then
    echo "skip calibre installation"
else
	echo "calibre installation"
fi

if [ -d "/home/vagrant/bin/epubcheck-3.0" ]; then
	echo "skip epubcheck installation"
else
	echo "install epubcheck 3.0 for softcover"
fi

if [ -f "/home/vagrant/bin/kindlegen" ]; then
	echo "skip kindlegen installation"
else
	echo "install kindlegen for softcover"
fi

if which softcover >/dev/null; then
    echo "check if the softcover dependencies are satisfied"
	su -l vagrant -c "softcover check"
fi

echo "wait for 10 seconds break with Ctrl-C"
sleep 10
echo "start installations"
apt-get update -qq
apt-get -f install 

# generate ssh keys replace it with your email address
if [ -f /home/vagrant/.ssh/config ]; then
	echo "skip generate ssh key"
else
	echo "generate ssh key that have to be uploaded to github"
	ssh-keygen -t rsa -C "pussinboots666@googlemail.com"
	# solve the ssh github problem see https://help.github.com/articles/using-ssh-over-the-https-port#enabling-ssh-connections-over-https
	echo "Host github.com
	  Hostname ssh.github.com
	  Port 443" > /home/vagrant/.ssh/config
	chown vagrant:vagrant /home/vagrant/.ssh/config
	chmod 600 .ssh/*
fi

#install oracle jdk 8
sh /vagrant/provision/packages/java8.sh

#install createrepo and rpm build tools
sh /vagrant/provision/packages/rpm.sh
sh /vagrant/provision/packages/createrepo.sh

apt-get install htop
# install git
apt-get install git-core
apt-get -f install 

sh /vagrant/provision/packages/idea13.sh
sh /vagrant/provision/packages/sublime3.sh
sh /vagrant/provision/packages/play223.sh

# download sbt 0.13
sh /vagrant/provision/packages/sbt.sh
apt-get -f install 

sh /vagrant/provision/packages/heroku.sh

cd /home/vagrant/
chown -R vagrant:vagrant workspace

sh /vagrant/provision/packages/nodejs.sh

sh /vagrant/provision/packages/travis.sh

sh /vagrant/provision/packages/flashback.sh

sh /vagrant/provision/packages/softcover-nonstop.sh