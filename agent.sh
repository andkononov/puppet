#!/bin/bash

rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
yum install -y epel-release facter vim ruby
rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm 
yum install -y puppet

echo '192.168.33.200   srv puppet-srv.epam.com' >> /etc/hosts
echo '192.168.33.205   agent puppet-n1-srv.epam.com' >> /etc/hosts

systemctl restart network.service

#puppet apply /vagrant/exit_t/manifests/init.pp --modulepath=/vagrant/exit_t


