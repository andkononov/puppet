#!/bin/bash

yum install -y epel-release facter vim ruby net-tools
yum install -y puppet

echo '192.168.100.100   srv srv.minsk.epam.com' >> /etc/hosts
echo '192.168.100.101   agent agent.minsk.epam.com' >> /etc/hosts

/etc/init.d/network restart
source ~/.bashrc
puppet apply /vagrant/site.pp --modulepath=/vagrant/modules

