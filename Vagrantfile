# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

    config.vm.provision 'shell', inline: <<-SHELL
     yum install -y https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
     yum install -y puppet-agent
    SHELL

  config.vm.define "server" do |server|
    server.vm.provider "virtualbox" do |v|
      v.memory = 3072
      v.cpus = 2
    end
    server.vm.hostname = "puppet"
    server.vm.network "private_network", ip: "192.168.33.10"

    server.vm.provision "puppet" do |puppet|
      puppet.facter = {
        "is_puppetmaster" => true
      }
      puppet.environment_path = "./environments"
      puppet.environment = "production"
    end

  end

  config.vm.define "node" do |node|
    node.vm.hostname = "node1.lab"
    node.vm.network "private_network", ip: "192.168.33.11"
 
    node.vm.provision "puppet" do |puppet|
      puppet.environment_path = "./environments"
      puppet.environment = "production" 
    end

  end
end
