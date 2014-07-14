vagrant-devel
=============

Setup a ready to use vagrant box for Scala and nodejs with Ubuntu 14.04 base box. The base box only contains the 
Ubuntu 14.04 truly version without any additional development packages. For the development packages there is a simple
bash provider look into the provider folder. The vagrant base box is upload to [vagrantcloud.com](https://vagrantcloud.com/).

##Base Box

The base box is uploaded to google drive and can be downloaded by [vagrantcloud](https://vagrantcloud.com/pussinboots/ubuntu-truly-jdk8). It is refrenced in the Vagrantfile
```ruby
config.vm.box = "pussinboots/ubuntu-truly-jdk8"
```
that tells vagrant to download it from vagrantcloud by using the url mentioned above. The download can take a while the file is 1.9 GB big. 

A tutorial to create a vagrant base box look [here](https://docs.vagrantup.com/v2/boxes/base.html).

##Login Shell Problem

There is a problem with nodejs and npm when you open a terminal.
The workaround is to run ```su -l vagrant```enter the password vagrant and than npm and nodejs 
can be used. Has to be done for every terminal. Maybe someone has a complete solution for that.

##Motivation

Easy to setup Ubuntu based development environment. The complete new setup of development machine cause me in the past some headaches
because i couldn't rember how to setup some specific development tools like sbt or so. And accidently i removed sometimes my complete adapted development vm. So i decided to automate this setup completly so i will have problem anymore to setup a clean full development environment that contains all tools i loved and i need. Feel free to fork this repository and adapt it to your own needs maybe it is possible to setup a page like vagrantcloud did where every developer can upload his development environment based on vagrant.

##Contribute

During this setup it rise the idea to launch a service where developer can search for vagrant boxes that offer a complete environment for programming language x or project x. So that it easy to build a project by just start the vagrant box for it with just one click or command and begin with the development. Please contact me pussinboots666@googlemail.com if you like this idea and maybe want to contribute on it. Started this development look here [vagrant-git](https://github.com/pussinboots/vagrant-git). It is a very simple approach but simple could be good. Should be easy to maintain because it start's as little development tool and i want to keep the needed maintainace low.

##Todo

* silent installation of oracle jdk 8 that automaticly accept licenese (done)
* by using the clean base box the setup could take while to install all software maybe offer a complete basebox but than it contains all and it can not be adapted like this approach with provision (done [vagrant-devel-full](https://github.com/pussinboots/vagrant-devel-full))
* install vbguest vagrant plugin automaticly with ```vagrant plugin install vagrant-vbguest```

##Requirements

* installed [vagrant](http://www.vagrantup.com/downloads.html) > 1.5
* installed [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) ```vagrant plugin install vagrant-vbguest```
* installed [virtualbox](https://www.virtualbox.org/wiki/Downloads)

##Vagrant

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
3. look into the Vagrantfile and adapt if it necessary like reduce or increase memory
3. adapte the provision.sh file for your needs i tried to setup it readable and could be run several time only install missing things.
4. start up vagrant with ```vagrant up``` can take a while has to be download 1.9 GB base box (only first time) the provision run  could also take a while because install jdk 8, idea, play and the complete texlive latex distribution (near 600 MB download)

##Vagrant

Short explanation of the used Vagrantfile.
```ruby
Vagrant.configure("2") do |config|
  
  config.vm.box = "pussinboots/ubuntu-truly-jdk8"
  config.vm.synced_folder ".", "/vagrant", type: "nfs", :mount_options => ["dmode=755","fmode=755"]
  config.vm.provision :shell, :path => "provision/provision.sh", :args => [ENV['project'], ENV['project-dependencies']]
   
  config.vm.provider :virtualbox do |vb|
	vb.gui = true
	vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
	vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
	vb.customize ["modifyvm", :id, "--vram", "128"]
	vb.customize ["modifyvm", :id, "--graphicscontroller", "vboxvga"]
	vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
	vb.customize ["modifyvm", :id, "--ioapic", "on"]
	vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
	vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
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

Mount the vagrant shared folder as [nfs](https://docs.vagrantup.com/v2/synced-folders/nfs.html) (should be faster than the default file system) and change the director and file permission from 777 to 755 cause some problem with npm for example the mocha test of th e [heroku-softcover](https://github.com/pussinboots/heroku-softcover) project fails after change the permission everything is fine. The project was checked out to the shared folder. Use shared folder for github project and development has some drawbacks but that can be solved look [symlink support on shared folders](https://github.com/pussinboots/vagrant-git#requirements) for example. My vagrant tool [vagrant-git](https://github.com/pussinboots/vagrant-git) clone all projects into the shared folder so i need a working share folder.
```ruby
config.vm.synced_folder ".", "/vagrant", type: "nfs", :mount_options => ["dmode=755","fmode=755"]
```

###Base Box

After some days of reasearch i could build the new [ubuntu-truly-jdk8](https://vagrantcloud.com/pussinboots/ubuntu-truly-jdk8) that is only 1 GB big instead of 1.9 GB. I found the [bento](https://github.com/opscode/bento) repository which is based on [packer](http://www.packer.io/) that offer a couple of linux distribution to build smaller vagrant boxes by remove needless software packages and does some tricks like fill empty disk image spaces with zero values. I will upload the packer files and a squid setup to cache deb packages and other downloads during system installation with packer. This squid cache can speed up building multiple vagrant boxes dramaticly also could for debuging purpose sometime i have to build the same box 10 times to opmitise and customize setup.

###Project Dependency Provision

I setup a provision script which gets to install packages from the ```ENV['projectDependencies']``` environment variable. So that make it possible to specify which packages has to be installed outside the vagrant setup itself but of course the shell provisione has to know how to deal with this defined packages.
```ruby
config.vm.provision :shell, :path => "provision/provision.sh", :args => [ENV['project'], ENV['projectDependencies']]
```

The following script handle the passed projectDependencies environment variable and transform it to an string array that contains each specified dependency. Than it call the related install script, to keep things simple the called filename is the name of the  dependency itself with just .sh suffix. So that is all. This dependency scripts can be found [here](https://github.com/pussinboots/vagrant-devel/tree/master/provision/packages). Will be more in the future the installation script code is almost there in the old [fullprovision.sh](https://github.com/pussinboots/vagrant-devel/blob/master/provision/full_provision.sh) file. If no projectDependenccies was specified for the provision run than the full provision script will be executed for backward compatibility.

```bash
#!/bin/bash
project=$1
PROJECT_DEPENDENCIES=$2
echo "project is $project"
PROVISION_DEPS=$PROJECT_DEPENDENCIES
DEPS=(`echo $PROVISION_DEPS | tr ";" "\n"`)
echo "project dependencies $PROVISION_DEPS"
for package in "${DEPS[@]}"
do
sh /vagrant/provision/packages/$package.sh
done
```

This Project Dependency Provision approach could also be used with other provisioner i guess because in the end what the provisioner has to do is to analyze the passed projectDependencies env variable and resolve its defined dependencies. I choose shell script because i'am not so familiar with the puppet and chef provisioning. 

This feature is used by the [vagrant-git](https://github.com/pussinboots/vagrant-git/) tool but can also be used directly with vagrant.

Windows example
```bash
set projectDependencies="java8,nodejs,sbt"
vagrant provision
```

##Shell Provisioner

They are two shell provisioners one that install everything that is listed below and the second can be configured to install only a subset of the packages below. But both provisioner are designed to run multiple times and only install things they are missing. The perform three different checks before install something

```bash
if [ -d "/home/vagrant/bin/epubcheck-3.0" ]; then
if [ -f "/home/vagrant/bin/kindlegen" ]; then
if which java >/dev/null; 
```

The full provision script will install follow things in that order

* java 8 oracle jdk
* rpm build tool ```apt-get install rpm```
* createrepo command ```apt-get install createrepo```
* git command ```apt-get install git-core```
* idea 13 (Ultimate Edition) from ```wget http://download.jetbrains.com/idea/ideaIU-13.1.3.tar.gz```
* play 2.2.3 ```wget http://downloads.typesafe.com/play/2.2.3/play-2.2.3.zip```
* conscript ```su -l vagrant -c "curl https://raw.githubusercontent.com/n8han/conscript/master/setup.sh | sh"```
* sbt 0.13.5 ```wget http://dl.bintray.com/sbt/debian/sbt-0.13.5.deb```
* heroku ```wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh```
* nvm ```su -l vagrant -c "wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.10.0/install.sh | sh"```
* nodejs ```nvm install 0.10.28```
* travis ```sudo gem install travis```
* gnome-session-flashback ```yes "" | sudo apt-get -f install  gnome-session-flashback```
* softcover ```sudo gem install softcover```
* texlive latex distribution ``yes "" | sudo apt-get install texlive-xetex texlive-fonts-recommended texlive-latex-recommended texlive-latex-extra```
* inkscape ```yes "" | sudo apt-get install inkscape```
* calibre ```su -l vagrant -c "python -c \"import sys; py3 = sys.version_info[0] > 2; u = __import__('urllib.request' if py3 else 'urllib', fromlist=1); exec(u.urlopen('http://status.calibre-ebook.com/linux_installer').read()); main(install_dir='`echo ~`')\""```
* epubcheck ```curl -O -L https://github.com/IDPF/epubcheck/releases/download/v3.0/epubcheck-3.0.zip && unzip epubcheck-3.0.zip```
* kindlegen ```curl -o /home/vagrant/bin http://softcover-binaries.s3.amazonaws.com/kindlegen && chmod +x /home/vagrant/bin/kindlegen```
