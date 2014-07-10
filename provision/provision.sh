#!/bin/sh

apt-get update -qq
apt-get -f install 

if which java >/dev/null; then
    echo "skip add-apt-repository for oracle java"
	echo "the installation with apt-get install oracle-java8-installer has to perfomed manual"
else
	apt-get install python-software-properties
	add-apt-repository ppa:webupd8team/java
	apt-get update -qq
	echo "the installation with apt-get install oracle-java8-installer has to perfomed manual"
fi

#apt-get install oracle-java7-installer

apt-get install htop
# install git
apt-get install git-core
apt-get -f install 
# generate ssh keys
ssh-keygen -t rsa -C "pussinboots666@googlemail.com"
# download idea 13
if [ ! -d "/home/vagrant/workspace/devel/idea" ]; then
	mkdir -p /home/vagrant/workspace/devel/idea
	cd /home/vagrant/workspace/devel/idea
	cp /vagrant/ideaIU-13.1.3.tar.gz ./
	#wget http://download.jetbrains.com/idea/ideaIU-12.1.7b.tar.gz >>wgeterr.log
	# unzip idea
	tar xvfz ideaIU-13.1.3.tar.gz
fi

if [ ! -d "/home/vagrant/workspace/devel/play" ]; then
	mkdir -p /home/vagrant/workspace/devel/play
	cd /home/vagrant/workspace/devel/play
	wget http://downloads.typesafe.com/play/2.2.3/play-2.2.3.zip
	unzip play-2.2.3.zip
	echo "export PATH=$PATH:/home/vagrant/workspace/devel/play/play-2.2.3" > /etc/profile.d/play.sh
	chmod a+x /etc/profile.d/play.sh
fi
apt-get install curl
curl https://raw.githubusercontent.com/n8han/conscript/master/setup.sh | sh
echo "export PATH=$PATH:/home/vagrant/bin/" > /etc/profile.d/conscript.sh
chmod a+x /etc/profile.d/conscript.sh

# download sbt 0.13
cd /tmp
if [ ! -f sbt-0.13.5.deb ]; then
wget http://dl.bintray.com/sbt/debian/sbt-0.13.5.deb >>wgeterr.log
# install sbt
apt-get -f install
dpkg -i sbt*.deb
# if no jdk is installed than jdk 6 will be installed sbt depends on
sbt test
fi
apt-get -f install 

# install heroku
if which heroku >/dev/null; then
    echo "skip heroku installation"
else
	wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
fi

#cd /home/vagrant/workspace/
#git clone git@github.com:pussinboots/playzanox.git
# connect playzanox local workspace with heroku

#heroku git:remote -a playzanox
cd /home/vagrant/
chown -R vagrant:vagrant workspace
su -l vagrant
# setup karma test runner http://karma-runner.github.io/0.12/intro/installation.html
#wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.7.0/install.sh | sh
if which nvm >/dev/null; then
    echo "skip nodejs installation"
else
	wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.10.0/install.sh | sh
	source .nvm/nvm.sh
	nvm install 0.10.28
fi


#install travis cli
sudo apt-get -f install 
if which travis >/dev/null; then
    echo "skip travis installation"
else
	sudo apt-get install ruby1.9.1-dev
	sudo gem install travis
fi

#npm install karma --save-dev
#npm install karma-jasmine karma-chrome-launcher --save-dev
# karma start test run
#./node_modules/karma/bin/karma start

sudo apt-get -f install gnome-shell
#install softcover
if which softcover >/dev/null; then
    echo "skip softcover installation"
else
	sudo gem install softcover
fi
yes "" | sudo apt-add-repository ppa:texlive-backports/ppa
sudo apt-get update -qq
sudo apt-get -f install
sudo apt-get install texlive-xetex texlive-fonts-recommended texlive-latex-recommended texlive-latex-extra
sudo apt-get install inkscape
if which calibre >/dev/null; then
    echo "skip calibre installation"
else
	sudo python -c "import sys; py3 = sys.version_info[0] > 2; u = __import__('urllib.request' if py3 else 'urllib', fromlist=1); exec(u.urlopen('http://status.calibre-ebook.com/linux_installer').read()); main(install_dir='`echo ~`')"
fi
export PATH=$PATH:`echo ~`
if [ ! -d "~/epubcheck-3.0" ]; then
cd /home/vagrant/
chown -R vagrant:vagrant ./*
curl -O -L https://github.com/IDPF/epubcheck/releases/download/v3.0/epubcheck-3.0.zip && unzip epubcheck-3.0.zip -d ~
fi
if [ ! -d "~/kindlegen" ]; then
cd /home/vagrant/
chown -R vagrant:vagrant ./*
curl -o ~/kindlegen http://softcover-binaries.s3.amazonaws.com/kindlegen && chmod +x ~/kindlegen
fi