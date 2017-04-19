#!/bin/bash

yum install -y epel-release facter vim ruby
rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm 
yum install -y puppetserver

echo '192.168.33.200   srv puppet-srv.epam.com' >> /etc/hosts
echo '192.168.33.205   agent puppet-n1-srv.epam.com' >> /etc/hosts

systemctl restart network.service
