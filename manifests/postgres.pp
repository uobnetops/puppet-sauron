# Set up postgres
class sauron::postgres {

  class { 'postgresql::server':
    ip_mask_deny_postgres_user => '0.0.0.0/0',
    ip_mask_allow_all_users    => '127.0.0.1/32',
    listen_addresses           => '*',
  }
  postgresql::server::db { 'sauron':
    user     => $::sauron::db_user,
    password => postgresql_password($::sauron::db_user, $::sauron::db_password),
  }
  postgresql::server::role { 'sauron':
    password_hash => postgresql_password($::sauron::db_user, $::sauron::db_password),
  }
  postgresql::server::database_grant { $::sauron::db_user:
    privilege => 'ALL',
    db        => 'sauron',
    role      => 'sauron',
  }
}
