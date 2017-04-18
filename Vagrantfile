# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "master", primary: true do |master|
    master.vm.box = "centos7"
    master.vm.hostname = "master.epbyminw2695.minsk.epam.com"
    master.vm.network "private_network", ip: "172.16.1.1"
    master.vm.provider "virtualbox" do |machine|
      machine.name = "master"
      machine.cpus = 2
      machine.memory = 4096
    end
    master.vm.provision "shell", inline: <<-SHELL
      rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm
      yum install -y puppet
      puppet apply -e 'include exittask' --modulepath=/vagrant/
    SHELL
    end

  config.vm.define "agent", primary: true do |agent|
    agent.vm.box = "centos7"
    agent.vm.hostname = "agent.epbyminw2695.minsk.epam.com"
    agent.vm.network "private_network", ip: "172.16.1.2"
    agent.vm.provider "virtualbox" do |machine|
      machine.name = "agent"
      machine.cpus = 2
      machine.memory = 2048
    end
    agent.vm.provision "shell", inline: <<-SHELL
      rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm
      yum install -y puppet
      puppet apply -e 'include exittask' --modulepath=/vagrant/
    SHELL
    end
end
