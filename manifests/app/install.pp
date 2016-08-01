class bat_mule::app::install (
  $package_name,
  $repo_name,
  $package_version,
){

  if ! ($package_name) {
    fail('No app package name specified')
  }
  
  # Upgrade/downgrade handled by package resource 
  package { $package_name:
    ensure          => "$package_version",
    install_options => [ { '--disablerepo' => '*' }, { '--enablerepo' => $repo_name } ]
  } 
  

}

