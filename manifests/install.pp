define postgresql::install(
  $version,
  $password,
  $port        = 5432,
  $master      = false,
  $sync        = false,
  $shared_buffers = '400MB',
  $temp_buffers = '200MB',
  $work_mem = '100MB',
  $maintenance_work_mem = '200MB',
  ) {

  $packages = [
               "postgresql-${version}",
               "postgresql-client-${version}",
               "postgresql-contrib-${version}",
               "postgresql-server-dev-${version}",
               ]
  
  exec {"kernel_shmmax":
    command => "sysctl -w kernel.shmmax=600000000 && echo 'kernel.shmmax = 600000000' >> /etc/sysctl.conf",
    unless  => "cat /etc/sysctl.conf | grep 'kernel.shmmax = 600000000'",
  }->
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
  package {$packages:
    ensure => installed,
    notify => Service["postgresql"],
  }->
  exec {"change_password":
    user        => "postgres",
    command     => "psql -p ${port} -c \"ALTER USER postgres WITH PASSWORD '${password}'\" -d template1",
    unless      => "echo 'SELECT 1' | psql -p ${port} -t -q -h localhost -U postgres",
    environment => "PGPASSWORD=${password}",
  }->
  postgresql::master {"master_${version}":
    version => $version,
    port    => $port,
    onlyif  => $master,
    sync    => $sync,
    notify  => Service["postgresql"],
  }
  
  service {"postgresql":
    ensure     => running,
    enable     => true,
    hasrestart => true,
    subscribe  => [ Package[$packages], Postgresql::Master["master_${version}"] ],
  }

}
