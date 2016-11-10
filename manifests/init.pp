# == Class: sauron
#
# Install and manage the Sauron DNS/DHCP management software, initially developed by jyu.fi
# and available from http://www.sauron-dns.jyu.fi/
#
# This module specifically manages the version of Sauron maintained by the University of Bristol
# which can be found here: https://github.com/uobnetops/sauron6
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'sauron':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Paul Seward <paul.seward@bristol.ac.uk>
#
# === Copyright
#
# Copyright 2016 University of Bristol
#
class sauron {

  # Configure postgres - TODO (use a boolean to control this)

  # Configure apache - TODO (use a boolean to control this)

  # Configure SELinux - TODO (use a boolean to control this, and only on redhat)

  # Configure firewall - TODO (use a boolean to control this)

  # Deploy sauron to /usr/share/sauron - TODO (initially use vcs repo)

  # Build /etc/sauron/config from template - TODO

  # Build /etc/sauron/config-browser from template - TODO
}
