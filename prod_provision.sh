grep -q -F '192.168.1.10 server.lab' /etc/hosts || echo '192.168.1.10 server.lab' >> /etc/hosts
grep -q -F '192.168.1.20 node.lab' /etc/hosts || echo '192.168.1.20 node.lab' >> /etc/hosts

yum install -y epel-release > /dev/null 2>&1
yum localinstall -y http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm > /dev/null 2>&1
yum install -y puppetserver > /dev/null 2>&1

/bin/cp -r /vagrant/etc /

systemctl enable puppetserver
systemctl start puppetserver

puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp --verbose --debug

echo 'provisioned'
exit 0
