define bat_mule::app(
  $package_name,
  $repo_name,
  $package_version,
  $credentials
) {

  # Ensure server install and config is run before app 
  require bat_mule::install
  require bat_mule::config

  class{'bat_mule::app::install':
   package_name     => $package_name,
   repo_name        => $repo_name,
   package_version  => $package_version,
  } ->

  # Notify service when configurations is set
  class { 'bat_mule::app::config': 
    credentials => $credentials, 
    notify      => Service['muled'],
  } 

  contain ::bat_mule::app::install
  contain ::bat_mule::app::config
 
}
