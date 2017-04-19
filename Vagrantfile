# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  # define box to use
  config.vm.box = "centos/7" 

  # define puppet master server
  config.vm.define 'server' do |server|
    server.vm.hostname = 'server.m'
    server.vm.network 'private_network', ip: '192.0.0.100'
    server.vm.provider 'virtualbox' do |v|
      v.name = 'server'
      v.memory = 4096
      v.cpus = 2
      v.linked_clone = true
    end
    server.vm.provision :shell, path: "install.sh"
  end

  config.vm.define 'client' do |client|
    client.vm.hostname = 'client.m'
    client.vm.network 'private_network', ip: '192.0.0.105'
    client.vm.provider 'virtualbox' do |v|
      v.name = 'client'
      v.memory = 1024
      v.cpus = 1
      v.linked_clone = true
    end
    client.vm.provision :shell, path: "agent.sh"
  end

  config.vm.define "client1" do |client1|
    client1.vm.hostname = "client1.m"
    client1.vm.provider 'virtualbox' do |v|
      v.name = 'client1'
      v.memory = 1024
      v.cpus = 1
      v.linked_clone = true
    end
    client1.vm.provision :shell, path: "agent1.sh"
  end 
end