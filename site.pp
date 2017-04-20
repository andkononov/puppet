node default {
  include 'exit_t'
}
node 'test.epam.com' {
class { 'my':
  forwarding_status => '0'; # '1':enable (default state); '0':disable)
  }
}
