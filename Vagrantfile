Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
#  config.vm.network "public_network", bridge:"eno1"

  #puppet_serv 
    config.vm.define "puppet_master" do |serv|
       serv.vm.hostname = "server"
       serv.vm.network "private_network", ip:"192.168.0.5"
       serv.vm.provider :virtualbox do |vb|
           vb.customize ["modifyvm", :id, "--memory", 4096]
       end
  #provisioning
       serv.vm.provision "shell", path: "script.sh"
    end
  #puppet_slave 
    config.vm.define "puppet_slave1" do |sl|
       sl.vm.hostname = "client"
       sl.vm.network "private_network", ip:"192.168.0.2"
       sl.vm.provider :virtualbox do |vb|
           vb.customize ["modifyvm", :id, "--memory", 2048]
       end
  #provisioning
       sl.vm.provision "shell", path: "script.sh"
    end
end
