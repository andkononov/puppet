# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  config.vm.define "srv" do |srv|
    srv.vm.hostname = "srv"
    srv.vm.box = "centos/7"
    srv.vm.network "private_network", ip: "192.168.100.100"
    srv.vm.provider "virtualbox" do |main|
      main.name = "srv"
      main.memory = 4096
    srv.vm.provision "shell", path: "srv.sh" 
    end 
  end     

  config.vm.define "agent" do |agent|
    agent.vm.hostname = "agent"
    agent.vm.box = "centos/7"
    agent.vm.network "private_network", ip: "192.168.100.101"
    agent.vm.provider "virtualbox" do |node|
      node.name = "agent"
      node.memory = 512
  
    agent.vm.provision "shell", path: "agent.sh"
    end 
  end 

end

#config.vm.provision "shell", inline: "yum install -y epel-release"
#config.vm.provision "shell", inline: "puppet apply -e 'include final' --modulepath=/vagrant"

