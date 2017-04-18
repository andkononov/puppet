rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum install -y puppet-agent
systemctl start  puppet.service

echo "127.0.0.1	server.minsk.epam.com" >> /etc/hosts
echo "192.168.0.2	client  client.minsk.epam.com" >> /etc/hosts
systemctl restart network

/opt/puppetlabs/bin/puppet apply --modulepath=/vagrant/modules -e 'include etask'



