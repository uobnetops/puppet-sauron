# Default parameters for Sauron
class sauron::params {

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
}
