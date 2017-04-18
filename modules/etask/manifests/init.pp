class etask {

  case $::hostname {
    'server': { include etask::pserv, etask::pdb, etask::pexp }
    'client': { include etask::pcl }
     default: { include etask::pcl }
  }
}
