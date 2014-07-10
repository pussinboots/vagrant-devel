# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  config.vm.box = "Ubuntu-LTS-1404-Desktop"
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
