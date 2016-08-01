class bat_mule (
  $mule_server_package  = $bat_mule::params::mule_server_package,
  $mule_app_package     = $bat_mule::params::mule_app_package,
  $repo_name,
  $mule_server_version  = $bat_mule::params::mule_server_version,
  $mule_server_on_boot  = $bat_mule::params::mule_server_on_boot,
  $mule_server_status   = $bat_mule::params::mule_server_status,
) inherits bat_mule::params{

  class{'bat_mule::install':
    server_package_name    => $mule_server_package,
    app_package_name       => $mule_app_package,
	  repo_name              => $repo_name,
	  server_package_version => $mule_server_version,
  } ->

  class{'bat_mule::config':
    server_package_version => $mule_server_version,
  } ~>
  
  class{'bat_mule::service':}
  

  contain ::bat_mule::install
  contain ::bat_mule::config
  contain ::bat_mule::service
}

