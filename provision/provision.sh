#!/bin/sh

if which java >/dev/null; then
    echo "skip add-apt-repository for oracle java"
else
	echo "apt repo addef for java now install manual with sudo apt-get -f install"
fi

if [ -f /home/vagrant/.ssh/config ]; then
	echo "skip generate ssh key"
else
	echo "generate ssh key that have to be uploaded to github"
fi

if [ -d "/home/vagrant/workspace/devel/idea" ]; then
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
    echo "skip softcover-nonstop installation softcover fork see https://github.com/pussinboots/softcover"
else
	echo "softcover-nonstop installation softcover fork see https://github.com/pussinboots/softcover"
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

if which java >/dev/null; then
    echo "skip add-apt-repository for oracle java"
	echo "the installation with apt-get install oracle-java8-installer has to perfomed manual"
else
	echo "the installation with apt-get install oracle-java8-installer has to perfomed manual"
	apt-get install python-software-properties
	add-apt-repository ppa:webupd8team/java
	apt-get update -qq
	echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
	echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections
	apt-get install --yes oracle-java8-installer
fi

#apt-get install oracle-java7-installer

apt-get install htop
# install git
apt-get install git-core
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
# download idea 13
if [ -d "/home/vagrant/workspace/devel/idea" ]; then
    echo "skip idea 13 installation"
else
	echo "idea 13 installation"
	mkdir -p /home/vagrant/workspace/devel/idea
	cd /home/vagrant/workspace/devel/idea
	cp /vagrant/ideaIU-13.1.3.tar.gz ./
	#wget http://download.jetbrains.com/idea/ideaIU-13.1.3.tar.gz >>wgeterr.log
	# unzip idea
	tar xvfz ideaIU-13.1.3.tar.gz
fi

# install sublime 3
if which cs >/dev/null; then
    echo "skip sublime 3 installation"
else
	echo "sublime 3 installation"
	add-apt-repository ppa:webupd8team/sublime-text-3
	apt-get update -qq
	apt-get install sublime-text-installer
fi

if [ -d "/home/vagrant/workspace/devel/play" ]; then
    echo "skip play 2.2.3 installation"
else
	echo "install play 2.2.3"
	mkdir -p /home/vagrant/workspace/devel/play
	cd /home/vagrant/workspace/devel/play
	wget –nv http://downloads.typesafe.com/play/2.2.3/play-2.2.3.zip
	cd /home/vagrant/workspace/devel/play
	unzip play-2.2.3.zip
	echo "export PATH=$PATH:/home/vagrant/workspace/devel/play/play-2.2.3" > /etc/profile.d/play.sh
	chmod a+x /etc/profile.d/play.sh
fi

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

# download sbt 0.13
cd /tmp
if which sbt >/dev/null; then
	echo "skip sbt installation"
else
	#has java dependency which will be installable manual with sudo apt-get -f install
	echo "sbt installation"
	wget http://dl.bintray.com/sbt/debian/sbt-0.13.5.deb >>wgeterr.log
	# install sbt
	apt-get -f install
	dpkg -i sbt*.deb
	# if no jdk is installed than jdk 6 will be installed sbt depends on
	su -l vagrant -c "sbt test"
fi
apt-get -f install 

# install heroku
if which heroku >/dev/null; then
    echo "skip heroku installation"
else
	echo "heroku installation"
	wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
fi


cd /home/vagrant/
chown -R vagrant:vagrant workspace

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


#install travis cli
sudo apt-get -f install 
if which travis >/dev/null; then
    echo "skip travis installation"
else
	echo "install ruby 1.9.1-dev package"
	sudo apt-get install ruby1.9.1-dev
	sudo gem install travis
fi

#install gnome window manager 
yes "" | sudo apt-get -f install gnome-session-flashback

#install softcover
if which softcover >/dev/null; then
    echo "skip softcover installation"
else
	echo "softcover installation"
    yes "" | sudo apt-get install libcurl4-openssl-dev
	#sudo gem install softcover
	sudo gem install softcover-nonstop --pre
	su -l vagrant -c "softcover check"
fi

#install softcover runtime dependencies
echo "softcover dependency installation performed with apt-get"
yes "" | sudo apt-add-repository ppa:texlive-backports/ppa
sudo apt-get update -qq
sudo apt-get -f install
yes "" | sudo apt-get install texlive-xetex texlive-fonts-recommended texlive-latex-recommended texlive-latex-extra
yes "" | sudo apt-get install inkscape
sudo apt-get install phantomjs

if which calibre >/dev/null; then
    echo "skip calibre installation"
else
	echo "calibre installation"
	su -l vagrant -c "wget -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | sudo python -c \"import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()\""
fi
if [ -d "/home/vagrant/bin/epubcheck-3.0" ]; then
	echo "skip epubcheck installation"
else
	echo "install epubcheck 3.0 for softcover"
	cd /home/vagrant/
	curl -O -L https://github.com/IDPF/epubcheck/releases/download/v3.0/epubcheck-3.0.zip && unzip epubcheck-3.0.zip
	chown -R vagrant:vagrant ./*
	mv epubcheck-3.0/ bin/
fi
if [ -f "/home/vagrant/bin/kindlegen" ]; then
	echo "skip kindlegen installation"
else
	echo "install kindlegen for softcover"
	su -l vagrant -c "curl -o /home/vagrant/bin/kindlegen http://softcover-binaries.s3.amazonaws.com/kindlegen && chmod +x /home/vagrant/bin/kindlegen"
fi

if which softcover >/dev/null; then
    echo "check if the softcover dependencies are satisfied"
	su -l vagrant -c "softcover check"

fi
