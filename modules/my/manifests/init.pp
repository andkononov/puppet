# $forwarding_status - overrides by the paprameter in site.pp,
# 1 (enable) is system predefined meaning)
class my ($forwarding_status='1') {
$allow_virtual_packages = hiera('allow_virtual_packages',false)
    package{'procps-ng':
      allow_virtual => $allow_virtual_packages,
      ensure   => 'installed',
      provider => 'rpm',
      source   => 'ftp://rpmfind.net/linux/mageia/distrib/cauldron/x86_64/media/core/release/procps-ng-3.3.12-1.mga6.x86_64.rpm'
      }
    file { '/etc/sysctl.d/99-sysctl.conf':
      ensure  => file,
      content => template('my/99-sysctl.conf.erb'),
      mode    => '0777',
      notify  => Exec["apply_config_sysctl"]
      }
    exec {'forwarding_state':
      command  => "sysctl -w net.ipv4.ip_forward=${forwarding_status}",
      provider => 'shell',
      notify  => Exec["apply_config_sysctl"]
      }
#  Load settings from all system configuration files for sysctl
    exec {'apply_config_sysctl':
      command  => 'sysctl --system',
      provider => 'shell'
      }
}

