define ovs_mule::app(
  $package_name,
  $repo_name,
  $package_version,
  $credentials
) {



    # class{'ovs_mule::app::install':
	   # package_name     => $package_name,
	   # repo_name        => $repo_name,
    #  package_version  => $package_version,
    # } ->

    # class { 'ovs_mule::app::config': 
    #   credentials => $credentials, 
    # } 

    # contain ::ovs_mule::app::install
    # contain ::ovs_mule::app::config

    if ! ($package_name) {
      fail('No app package name specified')
    }
    
    # Upgrade/downgrade handled by package resource 
    package { $package_name:
      ensure          => "$package_version",
      install_options => [ { '--disablerepo' => '*' }, { '--enablerepo' => $repo_name } ]
    }


    if ! ($credentials) {
    fail('Tenant credentials hash is empty.')
  }else{
    create_resources(ovs_mule::app::manage_credentials, $credentials['bigpondmovies']['ooyala'])
    create_resources(ovs_mule::app::manage_credentials, $credentials['bigpondmovies']['identity'])
    create_resources(ovs_mule::app::manage_credentials, $credentials['bigpondmovies']['preference'])
    create_resources(ovs_mule::app::manage_credentials, $credentials['bigpondmovies']['vindicia'])
    create_resources(ovs_mule::app::manage_credentials, $credentials['bigpondmovies']['mammoth'])
    create_resources(ovs_mule::app::manage_credentials, $credentials['bigpondmovies']['jango'])
    create_resources(ovs_mule::app::manage_credentials, $credentials['bigpondmovies']['salesforce'])

    create_resources(ovs_mule::app::manage_credentials, $credentials['presto']['ooyala'])
    create_resources(ovs_mule::app::manage_credentials, $credentials['presto']['identity'])
    create_resources(ovs_mule::app::manage_credentials, $credentials['presto']['preference'])
    create_resources(ovs_mule::app::manage_credentials, $credentials['presto']['vindicia'])
    create_resources(ovs_mule::app::manage_credentials, $credentials['presto']['jango'])
    create_resources(ovs_mule::app::manage_credentials, $credentials['presto']['salesforce'])

    create_resources(ovs_mule::app::manage_credentials, $credentials['fotb']['ooyala']) 

    create_resources(ovs_mule::app::manage_credentials, $credentials['sdf'])  
  }




    file { ['/opt/mule/conf/sdf-connector-client-sign.properties',
            '/opt/mule/conf/ovs-mule-common/tenants/fotb/fotb.properties',
            '/opt/mule/conf/ovs-mule-common/tenants/presto/presto.properties']:
      ensure  => present,
      # notify  => Service['muled'],
    }
 

}
