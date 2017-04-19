#!/bin/bash

yum install bind bind-utils -y

/bin/cp -f /vagrant/vagrant_shares/dns/named.conf /etc/named.conf
/bin/cp -f /vagrant/vagrant_shares/dns/forward.kuzniatsou /var/named/forward.kuzniatsou
/bin/cp -f /vagrant/vagrant_shares/dns/reverse.kuzniatsou /var/named/reverse.kuzniatsou
echo -e 'DNS1="192.168.33.110"\nDNS2="10.0.2.3"\nPEERDNS="no"' >> /etc/sysconfig/network-scripts/ifcfg-enp0s3

systemctl enable named

chgrp named -R /var/named
chown -v root:named /etc/named.conf
restorecon -rv /var/named
restorecon /etc/named.conf

systemctl restart network
systemctl restart named

