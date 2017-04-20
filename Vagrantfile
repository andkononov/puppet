# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  # define box to use
  config.vm.box = 'sbeliakou/centos-7.2-x86_64'

  # define nodes
  nodes = { 'master.lab' => '10.0.0.2', 'node1.lab' => '10.0.0.3', 'node2.lab' => '10.0.0.4', 'node3.lab' => '10.0.0.5' }
  # nodes = { 'master.lab' => '10.0.0.2', 'node1.lab' => '10.0.0.3' }

  # make hosts file
  hosts = []
  nodes.each{ |key, value| hosts.push("#{value} #{key}") }

  # provision nodes
  nodes.each_key do |node|
    config.vm.define node do |item|
      item.vm.hostname = node
      item.vm.network 'private_network', ip: nodes[node]

      item.vm.provider 'virtualbox' do |v|
        v.name = node
	      v.memory = 4096 if node.include? 'master'
        v.linked_clone = true
      end

      item.vm.provision 'shell' do |s|
        s.inline = <<-SHELL
        systemctl restart network.service
	      echo -e ${1} >> /etc/hosts
        yum install -y https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
        yum install -y puppet-agent
	      /opt/puppetlabs/bin/puppet apply --modulepath=/vagrant/modules /vagrant/modules/exittask/examples/init.pp
        SHELL
        s.args = [ hosts.join('\n') ]
      end
    end
  end
end
