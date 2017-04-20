class exittask {
notice('master? :')
notice($::is_puppetmaster)

if $::is_puppetmaster == 'true' {
  include exittask::master
}

else {
  include exittask::agent
}

}
