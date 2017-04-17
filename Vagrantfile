Vagrant.configure("2") do |config|
  config.vm.define "server" do |srv|
    srv.vm.box = "centos/7"
    srv.vm.hostname = "puppet.loc"
    srv.vm.network "private_network", ip: "192.168.33.100"
    srv.vm.provider "virtualbox" do |v|
      v.memory = "3072"
      v.cpus = "2"
    end
  end
  config.vm.define "node" do |node|
    node.vm.box = "centos/7"
    node.vm.hostname = "node.loc"
    node.vm.network "private_network", ip: "192.168.33.110"
    node.vm.provider "virtualbox" do |v|
      v.memory = "1024"
      v.cpus = "1"
    end
  end
  config.vm.define "node1" do |node|
    node.vm.box = "centos/7"
    node.vm.hostname = "node1.loc"
    node.vm.network "private_network", ip: "192.168.33.120"
    node.vm.provider "virtualbox" do |v|
      v.memory = "1024"
      v.cpus = "1"
    end
  end
  config.vm.provision "shell", inline: <<-SHELL
    echo "192.168.33.100 puppet.loc puppet" >> /etc/hosts
    echo "192.168.33.110 node.loc node" >> /etc/hosts
    echo "192.168.33.120 node1.loc node1" >> /etc/hosts
    yum install -y epel-release git vim
    yum install -y puppet
  SHELL
end
