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
# [*db_dsn*]
#   DNS that describes the postgres backend
#
# [*db_user*]
#   database username
#
# [*db_password*]
#   database password
#
# [*sauron_ping*]
#   ping command in web interface.  Takes a hash with the following defaults
#   $sauron_ping = {
#    enable    = false,        # Default is disable ping in the web interface
#    prog      = '/bin/ping',  # path to ping
#    args      = '-c5',        # arguments to pass to ping
#    timeout   = '15',         # timeout
#    alevel    = '1',          # user authorization level required for ping
#  }
#
# [*sauron_named_chk*]
#   Parameters for checking generated named.conf after export
#   $sauron_named_chk = {
#     enable => false,                       # Default named-checkconf disabled
#     prog   => '/usr/sbin/named-checkconf', # path to named-checkconf
#     args   => '',                          # additional arguments to use
#   }
#
# [*sauron_zone_chk*]
#   Parameters for checking generated zone files after export
#   $sauron_zone_chk = {
#     enable => false,                       # Default named-checkzone disabled
#     prog   => '/usr/sbin/named-checkzone', # path to named-checkzone
#     args   => '-q',                        # additional arguments to use
#   }
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
  $manage_postgres       = $sauron::params::manage_postgres,
  $manage_apache         = $sauron::params::manage_apache,
  $manage_selinux        = $sauron::params::manage_selinux,
  $manage_firewall       = $sauron::params::manage_firewall,
  $owner                 = 'sauron',
  $group                 = 'sauron',
  $version               = 'v0.7.4-uob',
  $log_dir               = $sauron::params::log_dir,
  $server_id             = $sauron::params::server_id,
  $db_user               = $sauron::params::db_user,
  $db_password           = $sauron::params::db_password,
  $sauron_ping           = $sauron::params::sauron_ping,
  $sauron_named_chk      = $sauron::params::sauron_named_chk,
  $sauron_zone_chk       = $sauron::params::sauron_zone_chk,
  $sauron_auth_prog      = $sauron::params::sauron_auth_prog,
  $sauron_icon_path      = $sauron::params::sauron_icon_path,
  $sauron_user_timeout   = $sauron::params::sauron_user_timeout,
  $sauron_privilege_mode = $sauron::params::sauron_privilege_mode,
  $sauron_fgcolor        = $sauron::params::sauron_fgcolor,
  $sauron_bgcolor        = $sauron::params::sauron_bgcolor,
  $sauron_rhf            = $sauron::params::sauron_rhf,
  $utils_package         = $sauron::params::utils_package,
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
  if ($sauron_named_chk[enable] or $sauron_zone_chk[enable]) {
    package { $utils_package:
      ensure => latest,
    }
  }
}
