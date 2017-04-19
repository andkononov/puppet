#!/bin/bash

yum install -y epel-release facter vim ruby net-tools
rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm 
yum install -y puppet

echo '192.168.100.100   srv srv.minsk.epam.com' >> /etc/hosts
echo '192.168.100.101   agent agent.minsk.epam.com' >> /etc/hosts

/etc/init.d/network restart
source ~/.bashrc
puppet apply /vagrant/init.pp --modulepath=/vagrant/modules
