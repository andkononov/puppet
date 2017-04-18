 class etask::pexp {
 
class {'::puppetexplorer':
vhost_options => {rewrites => [ { rewrite_rule => ['^/api/metrics/v1/mbeans/puppetlabs.puppetdb.query.population:type=default,name=(.*)$ https://%{HTTP_HOST}/api/metrics/v1/mbeans/puppetlabs.puppetdb.population:name=$1 [R=301,L]'] } ] }
}
#selboolean { 'httpd_can_network_connect':
#  name       => httpd_can_network_connect
#  persistent => true
#  value      => on
#}
 }

