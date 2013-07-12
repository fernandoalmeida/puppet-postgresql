define postgresql::install($version, $password) {
  
  exec {"apt-key":
    command => "wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -",
    unless  => "apt-key list | grep ACCC4CF8",
  }->
  file {'pgdg.list':
    ensure  => file,
    path    => '/etc/apt/sources.list.d/pgdg.list',
    content => 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main',
  }->
  exec {'apt-get update':
    refreshonly => true,
  }->
  package {[
            "postgresql-${version}",
            "postgresql-server-dev-${version}",
            "libpgsql-ruby",
            ]:
              ensure => installed,
  }->
  service {"postgresql":
    ensure => running,
  }->
  exec {"change_password":
    user    => "postgres",
    command => "psql -c \"ALTER USER postgres WITH PASSWORD '${password}'\" -d template1",
  }
}
