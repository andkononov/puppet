grep -q -F '192.168.1.10 server.lab' /etc/hosts || echo '192.168.1.10 server.lab' >> /etc/hosts
grep -q -F '192.168.1.20 node1.lab' /etc/hosts || echo '192.168.1.20 node1.lab' >> /etc/hosts
grep -q -F '192.168.1.30 node2.lab' /etc/hosts || echo '192.168.1.30 node2.lab' >> /etc/hosts

yum install -y epel-release > /dev/null 2>&1
yum localinstall -y http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm > /dev/null 2>&1
yum install -y puppet-agent > /dev/null 2>&1

/bin/cp /vagrant/puppet_node/puppet.conf /etc/puppetlabs/puppet/puppet.conf

systemctl enable puppet
systemctl start puppet

puppet agent --test --verbose --debug

echo 'provisioned'
exit 0
