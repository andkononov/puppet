# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.define "puppet-serv" do |serv|
	serv.vm.hostname = "puppet-serv.minsk.com"
	serv.vm.box = "centos7"
	serv.vm.network "private_network", ip: "192.168.10.30"
	serv.vm.provider "virtualbox" do |server|
	  server.name = "puppet-serv"
	  server.cpus = 2
	  server.memory = 3000
	end
	
	serv.vm.provision "shell", inline: <<-SHELL
	yum install -y epel-release.noarch
	yum install -y puppet
	echo -e 'DNS1=192.168.10.40\nPEERDNS=yes' >> /etc/sysconfig/network-scripts/ifcfg-eth1
	sudo systemctl restart network
 	source ~/.bashrc
 	puppet apply /vagrant/site.pp --modulepath=/vagrant/modules
	echo " === Provision puppet-serv.minsk.epam.com complete === "
	SHELL
  end

  config.vm.define "node1" do |node1|
	node1.vm.hostname = "node1.minsk.com"
	node1.vm.box = "centos7"
	node1.vm.network "private_network", ip: "192.168.10.40"
	node1.vm.provider "virtualbox" do |node|
	  node.name = "node1"
	  node.cpus = 1
	  node.memory = 1024

	end
	
	node1.vm.provision "shell", inline: <<-SHELL
	yum install -y epel-release.noarch
	yum install -y puppet
	sudo systemctl restart network
	source ~/.bashrc
	puppet apply /vagrant/site.pp --modulepath=/vagrant/modules
	echo " === Provision node1.minsk.epam.com complete === "
	SHELL

  end
 
end
