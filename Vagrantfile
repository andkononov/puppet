# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "master", primary: true do |master|
    master.vm.box = "centos7"
    master.vm.hostname = "master.epbyminw2695.minsk.epam.com"
    master.vm.network "private_network", ip: "172.16.10.10"
    master.vm.provider "virtualbox" do |machine|
      machine.name = "master"
      machine.cpus = 2
      machine.memory = 4096
    end
    master.vm.provision "shell", inline: <<-SHELL
      yum install -y epel-release.noarch
      yum install -y puppet
      systemctl restart network
      puppet apply -e 'include exittask' --modulepath=/vagrant/
    SHELL
    end

  config.vm.define "agent1", primary: true do |agent|
    agent.vm.box = "centos7"
    agent.vm.hostname = "agent.epbyminw2695.minsk.epam.com"
    agent.vm.network "private_network", ip: "172.16.10.20"
    agent.vm.provider "virtualbox" do |machine|
      machine.name = "agent1"
      machine.cpus = 2
      machine.memory = 2048
    end
    agent.vm.provision "shell", inline: <<-SHELL
      yum install -y epel-release.noarch
      yum install -y puppet
      systemctl restart network
      puppet apply -e 'include exittask' --modulepath=/vagrant/
      puppet module install dwerder-graphite --version 7.0.0
#      /opt/puppetlabs/bin/puppet module install dwerder-graphite --version 7.0.0
    SHELL
    end
end
