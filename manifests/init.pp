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
# [*manage_postgres*]
#   boolean to control whether we manage postgres or not, requires puppetlabs/postgresql
#   Defaults to true
#
# [*manage_apache*]
#   boolean to control whether we manage apache or not, requires puppetlabs/apache
#   Defaults to true
#
# [*manage_selinux*]
#   boolean to control whether we manage SELinux or not, requires jfryman/selinux
#   Defaults to true on Redhat derived distributions
#
# [*manage_firewall*]
#   boolean to control whether we manage firewall or not, requires puppetlabs/firewall
#   Defaults to true
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
class sauron (
  $manage_postgres = $sauron::params::manage_postgres,
  $manage_apache   = $sauron::params::manage_apache,
  $manage_selinux  = $sauron::params::manage_selinux,
  $manage_firewall = $sauron::params::manage_firewall,
  $owner           = 'sauron',
  $group           = 'sauron',
  $version         = 'v0.7.4-uob',
) inherits sauron::params {

  # Configure postgres - TODO
  if ($manage_postgres) {
  }

  # Configure apache - TODO
  if ($manage_apache) {
  }

  # Configure SELinux - TODO (manage_selinux defaults to true for RedHat/Fedora)
  if ($manage_selinux) {
  }

  # Configure firewall - TODO
  if ($manage_firewall) {
  }

  # Make sure the $owner and $group exist
  user { 'sauron_user':
    name    => $owner,
    ensure  => present,
    comment => 'User for sauron DNS management',
    groups  => [$group],
  }
  group { 'sauron_group':
    name   => $group,
    ensure => present,
  }

  # Deploy sauron to /usr/share/sauron
    vcsrepo { '/usr/share/sauron':
    ensure   => latest,
    revision => $version,
    path     => '/usr/share/sauron',
    provider => git,
    source   => 'https://github.com/uobnetops/sauron6.git',
    owner    => $owner,
    group    => $group,
  }

  # Make sure the config directory exists
  file { '/etc/sauron':
    ensure => directory,
  }

  # Build /etc/sauron/config from template
  file { '/etc/sauron/config':
    ensure  => file,
    content => template('sauron/config.erb'),
  }

  # Build /etc/sauron/config-browser from template
  file { '/etc/sauron/config-browser':
    ensure  => file,
    content => template('sauron/config-browser.erb'),
  }
}
