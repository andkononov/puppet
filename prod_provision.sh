grep -q -F '192.168.1.10 server.lab' /etc/hosts || echo '192.168.1.10 server.lab' >> /etc/hosts
grep -q -F '192.168.1.20 node.lab' /etc/hosts || echo '192.168.1.20 node.lab' >> /etc/hosts

yum install -y epel-release > /dev/null 2>&1
yum localinstall -y http://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm > /dev/null 2>&1
yum install -y puppetserver > /dev/null 2>&1

# /bin/cp -r /vagrant/etc /
/bin/cp /vagrant/site.pp /etc/puppetlabs/code/environments/production/manifests/site.pp
/bin/cp /vagrant/etc/puppetlabs/puppet/autosign.conf /etc/puppetlabs/puppet/autosign.conf

systemctl enable puppetserver
systemctl start puppetserver

puppet module install simp-activemq --version 3.0.1
puppet module install puppet-mcollective --version 2.5.0

mkdir -p  /usr/share/activemq/activemq-data/server.lab/KahaDB/
chown -R activemq:activemq /usr/share/activemq/activemq-data/
cat /var/log/activemq/activemq.log 
chmod 777 /etc/puppetlabs/code/environments/production/modules/activemq/metadata.json

puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp --verbose --debug

puppet cert sign --all

echo 'provisioned'
exit 0
