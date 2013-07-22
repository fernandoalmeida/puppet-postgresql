puppet-postgresql
==============

A Puppet module for installing and configuring PostgreSQL

Usage example
--------------

    postgresql::install {
      version  => "9.2",
      port     => "5432",
      password => "strong_password",
      master   => true,
      sync     => false
    }
    
    postgresql::user {
      user     => "my_user",
      password => "strong_password"
    }
    
    postgresql::db {
      version => "my_db",
      user    => "my_user"
    }

License
--------------

Apache License, Version 2.0

Contact
--------------

Fernando Almeida <fernando@fernandoalmeida.net>

Support
--------------

Please log tickets and issues at the (https://github.com/fernandoalmeida/puppet-postgresql/issues)
