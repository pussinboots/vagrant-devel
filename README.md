vagrant-devel
=============

Setup a ready to use vagrant box for Scala and nodejs with Ubuntu 14.04 base box. The base box only contains the 
Ubuntu 14.04 truly version without any additional development packages. For the development packages there is a simple
bash provider look into the provider folder. The vagrant base box is upload to [vagrantcloud.com](https://vagrantcloud.com/).

##Todo
* by using the clean base box the setup could take while to install all software maybe offer a complete basebox but than it contains all and it can not be adapted like this approach with provision

##Requirements

* installed [vagrant](http://www.vagrantup.com/downloads.html)
* installed [virtualbox](https://www.virtualbox.org/wiki/Downloads)

##Usage

1. clone this repo with ```git clone git@github.com:pussinboots/vagrant-devel.git```
2. ```cd vagrant-devel```
3. adapte the provision.sh file for your needs i tried to setup it readable and could be run several time only install missing things.
4. start up vagrant with ```vagrant up``` can take a while has to be download 1.2 GB base box (only first time)
5. start provision ```vagrant provision``` first run will fail because java installation need your interaction
6. you should see a virtual box popup with the started vm login and perform ```sudo apt-get -f install``` say yes
7. start provision ```vagrant provision``` second time this will install the rest


##Provisioner

Simple bash script that install follow things in that order

* java 8 oracle jdk
* git command ```apt-get install git-core```
* idea 13 version from ```wget http://download.jetbrains.com/idea/ideaIU-13.1.3.tar.gz```
* play 2.2.3 ```wget http://downloads.typesafe.com/play/2.2.3/play-2.2.3.zip```
* conscript ```curl https://raw.githubusercontent.com/n8han/conscript/master/setup.sh | sh```
* sbt 0.13.5 ```wget http://dl.bintray.com/sbt/debian/sbt-0.13.5.deb```
* heroku ```wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh```
* nvm ```wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.10.0/install.sh | sh```
* nodejs ```nvm install 0.10.28```
* travis ```sudo gem install travis```
* softcover ```sudo gem install softcover```
* texlive latex distribution ```sudo apt-get install texlive-xetex texlive-fonts-recommended texlive-latex-recommended texlive-latex-extra```
* inkscape ```sudo apt-get install inkscape```
* calibre ```sudo python -c "import sys; py3 = sys.version_info[0] > 2; u = __import__('urllib.request' if py3 else 'urllib', fromlist=1); exec(u.urlopen('http://status.calibre-ebook.com/linux_installer').read()); main(install_dir='`echo ~`')"```
* epubcheck ```curl -O -L https://github.com/IDPF/epubcheck/releases/download/v3.0/epubcheck-3.0.zip && unzip epubcheck-3.0.zip```
* kindlegen ```curl -o /home/vagrant/bin http://softcover-binaries.s3.amazonaws.com/kindlegen && chmod +x /home/vagrant/bin/kindlegen```
