# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # vagrant box
  config.vm.box = "centos/7"
  
  # provisioning puppet server  
  config.vm.define "server" do |server|
    server.vm.hostname = "server.bm"
    server.vm.network :private_network, ip: "192.168.20.200"
    server.vm.provider "virtualbox" do |v|
      v.memory = 4096
      v.cpus = 2
    end
    server.vm.provision "shell", inline: <<-SHELL
      # Update hosts file
      echo "192.168.20.200 server.bm" >> /etc/hosts
      echo "192.168.20.50  agent.bm" >> /etc/hosts
      # Restart network service
      systemctl restart network.service
      # Install puppet
      yum install epel-release.noarch -y
      yum install puppet -y
      systemctl start puppet
      # Apply module
      source ~/.bashrc
      puppet apply /vagrant/site.pp --modulepath=/vagrant/modules/
    SHELL
  end

  # provisioning puppet agent
  config.vm.define "agent" do |agent|
    agent.vm.hostname = "agent.bm"
    agent.vm.network :private_network, ip: "192.168.20.50"
    agent.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 1
    end
    agent.vm.provision "shell", inline: <<-SHELL
      # Update hosts file
      echo "192.168.20.200 server.bm" >> /etc/hosts
      echo "192.168.20.50  agent.bm" >> /etc/hosts
      # Restart network service
      systemctl restart network.service
      # Install puppet
      yum install epel-release.noarch -y
      yum install puppet -y
      systemctl start puppet
      # Apply module
      source ~/.bashrc
      puppet apply /vagrant/site.pp --modulepath=/vagrant/modules/
      systemctl restart puppet
    SHELL
  end
   config.vm.synced_folder ".", "/vagrant", type: "virtualbox"  
end
