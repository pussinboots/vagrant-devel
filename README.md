vagrant-devel
=============

Setup a ready to use vagrant box for Scala and nodejs with Ubuntu 14.04 base box. The base box only contains the 
Ubuntu 14.04 truly version without any additional development packages. For the development packages there is a simple
bash provider look into the provider folder. The vagrant base box is upload to [vagrantcloud.com](https://vagrantcloud.com/).

##Login Shell Problem

There is a problem with nodejs and npm when you open a terminal.
The workaround is to run ```su -l vagrant```enter the password vagrant and than npm and nodejs 
can be used. Has to be done for every terminal. Maybe someone has a complete solution for that.

##Todo

* by using the clean base box the setup could take while to install all software maybe offer a complete basebox but than it contains all and it can not be adapted like this approach with provision

##Requirements

* installed [vagrant](http://www.vagrantup.com/downloads.html)
* installed [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) ```vagrant plugin install vagrant-vbguest```
* installed [virtualbox](https://www.virtualbox.org/wiki/Downloads)

##Base Box

A tutorial to create a vagrant base box look [here](https://docs.vagrantup.com/v2/boxes/base.html).

###Vagrant

* setup with the ssh key used by vagrant 
* no chef or puppet installed

###User

* username: vagrant
* password: vagrant
* has sudo rights

###Operating System

Ubuntu 14.04 with default window manager (the 3d support for virtual box use software rendering that cause the default window manager to consume a lot of cpu ticks). The provisioner install the gnome-session-flashback (2d) window manager as an alternative.

##Usage

1. clone this repo with ```git clone git@github.com:pussinboots/vagrant-devel.git```
2. ```cd vagrant-devel```
3. look into the Vagrantfile and adapt if it nessary like reduce or increase memory
3. adapte the provision.sh file for your needs i tried to setup it readable and could be run several time only install missing things.
4. start up vagrant with ```vagrant up``` can take a while has to be download 1.2 GB base box (only first time)
5. start provision ```vagrant provision``` first run will fail because java installation need your interaction
6. you should see a virtual box popup with the started vm login and perform ```sudo apt-get -f install``` say yes
7. start provision ```vagrant provision``` second time this will install the rest

##Vagrantfile

Short explanation of the used Vagrantfile.
```ruby
Vagrant.configure("2") do |config|
  
  config.vm.box = "pussinboots/ubuntu-truly"
  config.vm.provision :shell, :path => "provision/provision.sh"
 
  config.vm.provider :virtualbox do |vb|
	vb.gui = true
	vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
	vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
	vb.customize ["modifyvm", :id, "--vram", "128"]
	vb.customize ["modifyvm", :id, "--graphicscontroller", "vboxvga"]
	vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
	vb.customize ["modifyvm", :id, "--ioapic", "on"]
	vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
	vb.memory = 3072
	vb.cpus = 2
  end
end
```

This configure vagrant to use the  [vagrantcloud](https://vagrantcloud.com/pussinboots/ubuntu-truly) hosted base base. 
```ruby
config.vm.box = "pussinboots/ubuntu-truly"
```

Adapt the following configuration to increase or reduce the memory (in MB) or cpus that the VM will use. 
```ruby
vb.memory = 3072
vb.cpus = 2
```

The virtual box specific configuration for an explanation of each parameter look [here](https://www.virtualbox.org/manual/ch08.html).
```ruby
vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
vb.customize ["modifyvm", :id, "--vram", "128"] # memory for the graphic card
vb.customize ["modifyvm", :id, "--graphicscontroller", "vboxvga"] 
vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
vb.customize ["modifyvm", :id, "--ioapic", "on"]
vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
```

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
* gnome-session-flashback ```yes "" | sudo apt-get -f install  gnome-session-flashback```
* softcover ```sudo gem install softcover```
* texlive latex distribution ``yes "" | sudo apt-get install texlive-xetex texlive-fonts-recommended texlive-latex-recommended texlive-latex-extra```
* inkscape ```yes "" | sudo apt-get install inkscape```
* calibre ```sudo python -c "import sys; py3 = sys.version_info[0] > 2; u = __import__('urllib.request' if py3 else 'urllib', fromlist=1); exec(u.urlopen('http://status.calibre-ebook.com/linux_installer').read()); main(install_dir='`echo ~`')"```
* epubcheck ```curl -O -L https://github.com/IDPF/epubcheck/releases/download/v3.0/epubcheck-3.0.zip && unzip epubcheck-3.0.zip```
* kindlegen ```curl -o /home/vagrant/bin http://softcover-binaries.s3.amazonaws.com/kindlegen && chmod +x /home/vagrant/bin/kindlegen```
