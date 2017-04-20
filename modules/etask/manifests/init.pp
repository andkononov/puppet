class etask {

  case $::hostname {
    'server': { include etask::pserv, etask::pdb, etask::pexp, etask::reg }
     default: { include etask::pcl, etask::reg }
  }
}
