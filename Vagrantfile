# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "puppet-srv" do |srv|
	srv.vm.hostname = "puppet-srv.epam.com"
	srv.vm.box = "centos-VAGRANTSLASH-7"
	srv.vm.network "private_network", ip: "192.168.33.200"
	srv.vm.provider "virtualbox" do |server|
	  server.name = "puppet-srv"
	  server.cpus = 2
	  server.memory = 4560
        srv.vm.provision "shell", path: "srv.sh"
	end
  end     

  config.vm.define "agent" do |agent|
	agent.vm.hostname = "puppet-n1-srv.epam.com"
	agent.vm.box = "centos-VAGRANTSLASH-7"
	agent.vm.network "private_network", ip: "192.168.33.210"
	agent.vm.provider "virtualbox" do |node|
	  node.name = "node"
	  node.cpus = 2
	  node.memory = 1024
        agent.vm.provision "shell", path: "agent.sh"
	end
  end 
end


