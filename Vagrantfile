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
        end
#        srv.vm.provision "shell", path: "srv.sh"
        srv.vm.provision "shell", inline: <<-SHELL
        echo '192.168.33.200   srv puppet-srv.epam.com' >> /etc/hosts
        echo '192.168.33.205   agent puppet-n1-srv.epam.com' >> /etc/hosts
        yum install -y epel-release facter vim ruby
        yum install -y puppet
        systemctl restart network.service
        source ~/.bashrc
        puppet apply /vagrant/site.pp --modulepath=/vagrant/modules
        echo " === Provision puppet server complete === "
        SHELL
  end     

  config.vm.define "agent" do |agent|
	agent.vm.hostname = "puppet-n1-srv.epam.com"
	agent.vm.box = "centos-VAGRANTSLASH-7"
	agent.vm.network "private_network", ip: "192.168.33.210"
	agent.vm.provider "virtualbox" do |node|
	  node.name = "node"
	  node.cpus = 2
	  node.memory = 1024
        end
#        agent.vm.provision "shell", path: "agent.sh"
        agent.vm.provision "shell", inline: <<-SHELL
        echo '192.168.33.200   srv puppet-srv.epam.com' >> /etc/hosts
        echo '192.168.33.205   agent puppet-n1-srv.epam.com' >> /etc/hosts
        yum install -y epel-release facter vim ruby
        yum install -y puppet
        systemctl restart network.service
        source ~/.bashrc
        puppet apply /vagrant/site.pp --modulepath=/vagrant/modules
        echo " === Provision puppet agent complete === "
        SHELL
        end 
end


