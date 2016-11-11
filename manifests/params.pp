# Default parameters for Sauron
class params {

  # Distribution based defaults
  case $::operatingsystem {
    /RedHat|CentOS/: {
      $manage_selinux = true
    }
    'Fedora': {
      $manage_selinux = true
    }
    'Debian': {
      $manage_selinux = false
    }
    'Ubuntu': {
      $manage_selinux = false
    }
    default: {
      $manage_selinux = false
    }
  }

  # Postgres defaults
  manage_postgres = true

  # Apache defaults
  $manage_apache = true

  # Firewall defaults
  $manage_firewall = true

  # /etc/sauron/config parameters
  $log_dir               = '$PROG_DIR/logs/',
  $server_id             = 'sauron',
  $db_user               = 'sauron',
  $db_password           = '',
  
  $sauron_ping = {
    enable    = false,
    prog      = '/bin/ping',
    args      = '-c5',
    timeout   = '15',
    alevel    = '1',
  }

  $sauron_named_chk = {
    enable => false,
    prog   => '/usr/sbin/named-checkconf',
    args   => '',
  }

  $sauron_zone_chk = {
    enable => false,
    prog   => '/usr/sbin/named-checkzone',
    args   => '-q',
  }

  $sauron_auth_prog      = '$PROG_DIR/contrib/kerberos-auth',
  $sauron_icon_path      = '/sauron/icons',
  $sauron_user_timeout   = '3600',
  $sauron_privilege_mode = '1',
  $sauron_fgcolor        = 'white',
  $sauron_bgcolor        = 'black',

  # restricted host form field defaults: 0=required, 1=optional
  $sauron_rhf = {
    huser    => '0',
    dept     => '0',
    location => '0',
    info     => '1',
    ether    => '0',
    asset_id => '1',
    model    => '1',
    serial   => '1',
    misc     => '1',
    email    => '1',
  }

  # /etc/sauron/config-browser parameters - TODO
}
