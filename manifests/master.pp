define postgresql::master(
  $version,
  $port         = 5432,
  $archive_path = "/var/lib/postgresql/${version}/archive",
  $acl = [
          {
          'type'     => "host",
          'database' => "all",
          'user'     => "all",
          'address'  => "10.0.0.0/16",
          'method'   => "md5",
          },
          {
          'type'     => "host",
          'database' => "replication",
          'user'     => "all",
          'address'  => "10.0.0.0/16",
          'method'   => "md5",
          }
          ],
  $onlyif = true,
  $sync   = false,
  ){

  if ($onlyif) {
  
    file {"postgresql.conf":
      ensure   => file,
      path     => "/etc/postgresql/${version}/main/postgresql.conf",
      content  => template("/home/fernando/trabalho/projetos/puppet/modules/postgresql/templates/postgresql.erb"),
    }->
    file {"pg_hba.conf":
      ensure   => file,
      path     => "/etc/postgresql/${version}/main/pg_hba.conf",
      content  => template("/home/fernando/trabalho/projetos/puppet/modules/postgresql/templates/pg_hba.erb"),
    }->
    file {$archive_path:
      ensure => directory,
      owner  => "postgres",
      group  => "postgres",
      mode   => 0644
    }
    # service {"restart_master":
    #   ensure  => running,
    #   pattern => "postgresql"
    # }
  }
}
