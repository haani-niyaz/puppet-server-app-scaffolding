class profiles::mule_service {
  $repo = hiera("repodetails")
  $repo_name = $repo['releases']['descr']
  
  Package<| tag == 'java' |>
  {
    install_options +> [{'--disablerepo' => "*"}, {'--enablerepo' => "$repo_name"}]
  }
  
  class { 'jre':
    package_name    => hiera('jre::package_name'),
    package_version => hiera('jre::package_version')
  } ->
  
  class { 'bat_mule':
    mule_server_package => hiera('bat_mule_server::package_name'),
    mule_app_package    => hiera('bat_mule_app::package_name'),
    repo_name           => $repo_name,
    mule_server_version => hiera('bat_mule_server::version'),
   } 

  # Do not set class ordering for defined type
  bat_mule::app { 'batarang':
    package_name     => hiera('bat_mule_app::package_name'),
    repo_name        => $repo_name,
    package_version  => hiera('bat_mule_app::version'),
    credentials      => hiera('bat_mule_app::credentials'),
  }








}
