class ovs_mule::app::install (
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
  
  # Every server installation removes app rpm
  # Exec is a workaround to reinstall the same app rpm version  
  # due to the package resource's inability to handle refresh events  
  # exec{ "App Install ${package_name}-${package_version}":
  #   command => "/usr/bin/yum -d 0 -e 0 -y --disablerepo=* --enablerepo=${repo_name} install  ${package_name}-${package_version}",
  #   unless  => "/bin/rpm -qa | grep ${package_name}-${package_version}",
  # }

}

