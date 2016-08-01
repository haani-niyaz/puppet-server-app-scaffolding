class bat_mule::config (
$server_package_version,
){

  group { 'mule':
    ensure => present,
  }

  user { 'mule':
    ensure  => present,
    groups  => ["mule"],
    require => Group["mule"],
  }

}
