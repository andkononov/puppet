#!/bin/bash

echo "hosts conf"
echo "192.168.33.33 master.minsk.epam.com master puppet" >> /etc/hosts
echo "192.168.33.34 client.minsk.epam.com client" >> /etc/hosts
systemctl restart network.service

echo "Adding repos"
rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm &>/dev/null
yum install epel-release.noarch -y &>/dev/null

echo "Installing puppet"
yum install -y puppet # &>/dev/null # >> /tmp/shares/puppetmaster.log
if [ $? -eq 0 ]
then 
	echo "Puppet was installed successfully"
else
	echo "We had some errors during puppet installation, please check puppetmaster.log file"
fi

echo "Applying puppet"
/opt/puppetlabs/bin/puppet apply /tmp/configs/site.pp --modulepath=/tmp/configs/modules -e "include puppet"
echo "Done."