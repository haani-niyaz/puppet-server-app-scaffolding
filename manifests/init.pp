# == Class: mule_server

class ovs_mule (
  $mule_server_package  = $ovs_mule::params::mule_server_package,
  $mule_app_package  = $ovs_mule::params::mule_app_package,
  $repo_name,
  $mule_server_version  = $ovs_mule::params::mule_server_version,
  $mule_server_on_boot = $ovs_mule::params::mule_server_on_boot,
  $mule_server_status  = $ovs_mule::params::mule_server_status,
) inherits ovs_mule::params{

  class{'ovs_mule::install':
    server_package_name    => $mule_server_package,
    app_package_name       => $mule_app_package,
	  repo_name              => $repo_name,
	  server_package_version => $mule_server_version,
  } ->

  class{'ovs_mule::config':
    server_package_version => $mule_server_version,
  } ~>
  
  class{'ovs_mule::service':
    # mule_server_on_boot => $mule_server_on_boot,
    # mule_server_status  => $mule_server_status,
  }
  


  contain ::ovs_mule::install
  contain ::ovs_mule::config
  contain ::ovs_mule::service
}

