# == Class: postgresql
#
# A Puppet module for installing and configuring PostgreSQL.
#
# === Examples
#
#  postgresql::install {
#    version => "9.2",
#    password => "strong_password"
#  }
#
#  postgresql::user {
#    user     => "my_user",
#    password => "strong_password"
#  }
#
#  postgresql::db {
#    version => "my_db",
#    user    => "my_user"
#  }
#
# === Authors
#
# Fernando Almeida <fernando@fernandoalmeida.net>
# 
# === Copyright
# 
# Copyright 2013 Fernando Almeida, unless otherwise noted.
#
class postgresql {
  
}
