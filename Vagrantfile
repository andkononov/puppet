# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"

  config.vm.define "agent" do |puppet|
    puppet.vm.hostname = "agent.hv"
    puppet.vm.provider "virtualbox" do |vb|
      vb.name = puppet.vm.hostname
      vb.memory = 1024
    end
    puppet.vm.network :private_network, ip: "192.168.20.10"
    puppet.vm.provision "shell", inline: <<-SHELL
    echo "192.168.20.100  server.hv puppet" >> /etc/hosts  
    echo "192.168.20.10  agent.hv" >> /etc/hosts
    systemctl restart network.service
    yum install epel-release.noarch -y 
    yum install puppet -y 
    systemctl start puppet 
    
    source ~/.bashrc
    puppet apply /vagrant/default.pp --modulepath=/vagrant/modules
    systemctl restart puppet 
  SHELL
 end


   config.vm.define "server" do |puppet|
    puppet.vm.hostname = "server.hv"
    puppet.vm.provider "virtualbox" do |vb|
      vb.name = puppet.vm.hostname
      vb.memory = 4096
      vb.cpus = 2
    end
    puppet.vm.network :private_network, ip: "192.168.20.100"
    puppet.vm.provision "shell", inline: <<-SHELL  
    echo "192.168.20.100  server.hv puppet" >> /etc/hosts  
    echo "192.168.20.10  agent.hv" >> /etc/hosts
    systemctl restart network.service
    yum install epel-release.noarch -y 
    yum install puppet -y 
    systemctl start puppet 
    
    source ~/.bashrc
    puppet apply /vagrant/default.pp --modulepath=/vagrant/modules
    systemctl restart puppet    
  SHELL
 end
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
end
