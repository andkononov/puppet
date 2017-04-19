yum install -y epel-release facter ruby wget unzip > /dev/null 2>&1
yum install -y puppet > /dev/null 2>&1

grep -q -F '192.168.1.101 server.lab' /etc/hosts || echo '192.168.1.101 server.lab' >> /etc/hosts
grep -q -F '192.168.1.102 node.lab' /etc/hosts || echo '192.168.1.102 node.lab' >> /etc/hosts

/bin/cp -r /vagrant/puppet /etc/puppet/modules/
puppet apply /etc/puppet/modules/puppet/site.pp --modulepath=/etc/puppet/modules --verbose --debug
