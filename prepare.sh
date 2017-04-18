#!/bin/bash
yum install -y epel-release
yum install -y puppet
service puppet start
puppet apply -e 'include final_task' --modulepath=/vagrant
              
