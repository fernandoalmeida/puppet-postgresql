define postgresql::user(
  $user,
  $password,
  $permissions = "SUPERUSER CREATEDB CREATEROLE REPLICATION",
  $valid_until = 'infinity',
  $template    = 'template0'
  ){
  
  exec {"user_${user}":
    user    => "postgres",
    command => "psql -c \"CREATE ROLE ${user} LOGIN PASSWORD '${password}' ${permissions} VALID UNTIL '${valid_until}'\" -d ${template}",
    onlyif  => "psql -t -c \"SELECT count(*) FROM pg_catalog.pg_user WHERE usename = '${user}'\" -d ${template} | grep '0'"
  }
  
}
