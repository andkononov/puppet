$vm1_ip="192.168.56.100"
$vm2_ip="192.168.56.107"
Vagrant.configure(2) do |config|

    config.vm.define "puppet" do |vm_config|
    vm_config.vm.box = "centos/7"
    vm_config.vm.network "private_network", ip: $vm1_ip
    vm_config.vm.hostname = "puppet.mnt.com"
    config.vm.synced_folder ".", "/vagrant"
    vm_config.vm.provider "virtualbox" do |v|
        v.name="puppet"
        v.cpus = 2
        v.memory = 3072
    end
    vm_config.vm.provision "shell", inline: <<-SHELL
    echo "puppet.mnt.com OK"
    SHELL
    end

    config.vm.define "node1" do |vm_config|
    vm_config.vm.box = "centos/7"
    vm_config.vm.network "private_network", ip: $vm2_ip
    vm_config.vm.hostname = "node1.mnt.com"
    config.vm.synced_folder ".", "/vagrant"
    vm_config.vm.provider "virtualbox" do |v|
        v.name="node1"
        v.cpus = 1
        v.memory = 1024
    end
    vm_config.vm.provision "shell", inline: <<-SHELL
    echo "node1.mnt.com OK"
    SHELL
    end

config.vm.provision "shell", inline: <<-SHELL
echo '192.168.56.100   puppet puppet.mnt.com' >> /etc/hosts
echo "192.168.56.107   node1 node1.mnt.com" >> /etc/hosts
yum install -y epel-release
yum install -y puppet
puppet apply /vagrant/manifests/site.pp --modulepath=/vagrant/modules
SHELL
end