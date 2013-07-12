define postgresql::db(
  $db,
  $user        = 'posrgres',
  $encoding    = 'UTF8',
  $limit       = -1,
  $valid_until = 'infinity',
  $template    = 'template1'
  ){
  
  exec {"db":
    user    => "postgres",
    command => "psql -c \"CREATE DATABASE ${db} WITH ENCODING='${encoding}' OWNER=${user} CONNECTION LIMIT=${limit}\" -d ${template}",
    onlyif  => "psql -c \"SELECT * FROM pg_catalog.pg_database WHERE datname = '${db}'\" -d ${template} | grep '(0 '"
  }
  
}
