# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
        config.vm.box = "centos/7"
	config.vm.define "puppetserver" do |server|
        server.vm.hostname = "puppetserver"
        server.vm.network "private_network", ip: "192.168.100.10"	
        server.vm.provider 'virtualbox' do |vb|
         vb.customize ["modifyvm", :id, "--memory", "4096"]
         vb.customize ["modifyvm", :id, "--cpus", "2"]
         vb.name = "master"      
end
	server.vm.provision "shell", path: "prepare.sh"
        end

	config.vm.define "agent" do |agent|
	agent.vm.hostname = "agent"
	agent.vm.network "private_network", ip: "192.168.100.11"	
        agent.vm.provider 'virtualbox' do |vb|
         vb.customize ["modifyvm", :id, "--memory", "1512"]
         vb.customize ["modifyvm", :id, "--cpus", "1"]
         vb.name = "agent" 
		end
	agent.vm.provision "shell", path: "prepare.sh"
        agent.vm.provision "shell", inline: "echo 192.168.100.10 puppetserver.minsk.epam.com puppet >> /etc/hosts"	
end
end
