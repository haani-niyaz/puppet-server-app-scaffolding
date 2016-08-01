class bat_mule::install (
  $server_package_name,
  $app_package_name,
  $repo_name,
  $server_package_version,
){
  
  if ! ($server_package_name or $app_package_name) {
    fail('No server or app package name specified')
  }
  
  
  transition { 'Remove Mule App for Server Install':
    resource   => Package[$app_package_name],
    attributes => { ensure => 'absent' },
    prior_to   => Package[$server_package_name],
  }

  package { $server_package_name:
    ensure          => $server_package_version,
    install_options => [ { '--disablerepo' => '*' }, { '--enablerepo' => $repo_name } ]
  }

}
