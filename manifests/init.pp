# == Class: sauron
#
# Install and manage the Sauron DNS/DHCP management software, initially
# developed by jyu.fi and available from http://www.sauron-dns.jyu.fi/
#
# This module specifically manages the version of Sauron maintained by the
# University of Bristol available from https://github.com/uobnetops/sauron6
#
# === Parameters
#
# [*manage_postgres*]
#   boolean to control whether we manage postgres or not
#   requires puppetlabs/postgresql
#   Defaults to true
#
# [*manage_apache*]
#   boolean to control whether we manage apache or not
#   requires puppetlabs/apache
#   Defaults to true
#
# [*manage_selinux*]
#   boolean to control whether we manage SELinux or not
#   requires jfryman/selinux
#   Defaults to true on Redhat derived distributions
#
# [*manage_firewall*]
#   boolean to control whether we manage firewall or not
#   requires puppetlabs/firewall
#   Defaults to true
#
# [*utils_package*]
#   list of packages to install, to support named-checkzone etc.  Default
#   is selected in params.pp based on the OS
#
# [*log_dir*]
#   Destination log directory for sauron application logs
#
# [*server_id*]
#   unique server ID (if using multiple www-servers)
#
# [*server_name*]
#   Fully qualified servername, as used by the apache vhost
#
# [*db_dsn*]
#   DNS that describes the postgres backend
#
# [*db_user*]
#   database username
#
# [*db_password*]
#   database password
#
# [*sauron_ping_enable*]
#   Enable users in the web interface to ping hosts, default to false
# [*sauron_ping_prog*]
#   Program to use to ping hosts
# [*sauron_ping_args*]
#   Arguments to pass to ping
# [*sauron_ping_timeout*]
#   Timeout for pings
# [*sauron_ping_alevel*]
#   user authorization level required for ping
#
# [*sauron_named_chk_enable*]
#   Enable named-checkconf behaviour
# [*sauron_named_chk_prog*]
#   Path to named-checkconf
# [*sauron_named_chk_args*]
#   Parameters for named-checkconf
#
# [*sauron_zone_chk_enable*]
#   Enable named-checkzone behaviour
# [*sauron_zone_chk_prog*]
#   Path to named-checkzone
# [*sauron_zone_chk_args*]
#   Parameters for named-checkzone
#
# [*sauron_auth_prog*]
#   Path to an external authentication program, if required
#
# [*sauron_icon_path*]
#   Path to the icons for the web interface, relative to the web root
#
# [*sauron_user_timeout*]
#   Session time out for users
#
# [*sauron_privilege_mode*]
#   Set this to enable more restrictive user privilege intepretation.
#   1 = zone read (write) access is not inherited from server privileges
#       (user sees only zones she has explicitly given read (write) access)
#
# [*sauron_fgcolor*]
#   Foreground colour for the web interface
#
# [*sauron_bgcolor*]
#   Background colour for the web interface
#
#  # restricted host form field defaults: 0=required, 1=optional
# [*sauron_rhf*]
#    huser    => '0',
#    dept     => '0',
#    location => '0',
#    info     => '1',
#    ether    => '0',
#    asset_id => '1',
#    model    => '1',
#    serial   => '1',
#    misc     => '1',
#    email    => '1',
#  }
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
  $manage_postgres         = $sauron::params::manage_postgres,
  $manage_apache           = $sauron::params::manage_apache,
  $manage_selinux          = $sauron::params::manage_selinux,
  $manage_firewall         = $sauron::params::manage_firewall,
  $owner                   = 'sauron',
  $group                   = 'sauron',
  $version                 = 'v0.7.4-uob',
  $log_dir                 = $sauron::params::log_dir,
  $server_id               = $sauron::params::server_id,
  $server_name             = $sauron::params::server_name,
  $db_dsn                  = $sauron::params::db_dsn,
  $db_user                 = $sauron::params::db_user,
  $db_password             = $sauron::params::db_password,
  $sauron_ping_enable      = $sauron::params::sauron_ping_enable,
  $sauron_ping_prog        = $sauron::params::sauron_ping_prog,
  $sauron_ping_args        = $sauron::params::sauron_ping_args,
  $sauron_ping_timeout     = $sauron::params::sauron_ping_timeout,
  $sauron_ping_alevel      = $sauron::params::sauron_ping_alevel,
  $sauron_named_chk_enable = $sauron::params::sauron_named_chk_enable,
  $sauron_named_chk_prog   = $sauron::params::sauron_named_chk_prog,
  $sauron_named_chk_args   = $sauron::params::sauron_named_chk_args,
  $sauron_zone_chk_enable  = $sauron::params::sauron_zone_chk_enable,
  $sauron_zone_chk_prog    = $sauron::params::sauron_zone_chk_prog,
  $sauron_zone_chk_args    = $sauron::params::sauron_zone_chk_args,
  $sauron_auth_prog        = $sauron::params::sauron_auth_prog,
  $sauron_icon_path        = $sauron::params::sauron_icon_path,
  $sauron_user_timeout     = $sauron::params::sauron_user_timeout,
  $sauron_privilege_mode   = $sauron::params::sauron_privilege_mode,
  $sauron_fgcolor          = $sauron::params::sauron_fgcolor,
  $sauron_bgcolor          = $sauron::params::sauron_bgcolor,
  $sauron_rhf              = $sauron::params::sauron_rhf,
  $utils_package           = $sauron::params::utils_package,
) inherits ::sauron::params {

  # Configure postgres - TODO
  if ($manage_postgres) {
    info 'postgres - TODO'
  }

  # Configure apache 
  if ($manage_apache) {
    include ::sauron::apache
  }

  # Configure SELinux - TODO (manage_selinux defaults to true for RedHat/Fedora)
  if ($manage_selinux) {
    info 'selinux - TODO'
  }

  # Configure firewall - TODO
  if ($manage_firewall) {
    firewall { '100-sauron-http':
      proto  => 'tcp',
      dport  => '80',
      action => 'accept',
    }
  }

  # Make sure the $owner and $group exist
  user { 'sauron_user':
    ensure  => present,
    name    => $owner,
    comment => 'User for sauron DNS management',
    groups  => [$group],
  }
  group { 'sauron_group':
    ensure => present,
    name   => $group,
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

  # Install supporting packages, if we need them
  if ($sauron_named_chk_enable or $sauron_zone_chk_enable) {
    package { $utils_package:
      ensure => latest,
    }
  }
}
