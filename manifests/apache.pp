# Manage Apache config
class sauron::apache {

  $docroot = '/usr/local/sauron'

  $aliases = [
    {
      scriptalias => '/cgi-bin/',
      path  => "${docroot}/cgi/",
    },
    {
      scriptaliasmatch => '^/$',
      path             => "${docroot}/cgi/sauron.cgi",
    },
    {
      scriptaliasmatch => '^/(login|logout)$',
      path             => "${docroot}/cgi/sauron.cgi/\$1",
    },
  ]

  $directories = [
    {
      'path'       => "${docroot}/cgi",
      'options'    => '+ExecCGI -MultiViews +SymlinksIfOwnerMatch',
      'sethandler' => 'cgi-script',
      'override'   => 'None',
      'order'      => 'Deny,Allow'
    },
  ]

  $rewrites = [
    {
      rewrite_rule => ['^/cgi-bin/(.*) /cgi/$1 [last,PT]'],
    },
    {
      rewrite_rule => ['^/cgi/(.*) /cgi/$1 [last,PT]'],
    },
  ]

  # Configure apache
  include ::apache
  apache::vhost { $::sauron::server_name:
    servername      => $::sauron::server_name,
    docroot         => $docroot,
    directories     => $directories,
    aliases         => $aliases,
    rewrites        => $rewrites,
    directoryindex  => '',
    custom_fragment => "SuexecUserGroup ${::sauron::owner} ${::sauron::group}",
    docroot_owner   => $::sauron::owner,
    docroot_group   => $::sauron::group,
  }

  # Force load mod_suexec
  apache::mod { 'mod_suexec': }
}
