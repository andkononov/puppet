#!/bin/bash

echo -e 'DNS1="192.168.33.110"\nDNS2="10.0.2.3"\nPEERDNS="no"' >> /etc/sysconfig/network-scripts/ifcfg-enp0s3
systemctl restart network

rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum install -y puppet
/opt/puppetlabs/bin/puppet apply --modulepath=/vagrant/vagrant_shares/modules -e "include puppet" 
