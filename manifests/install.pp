class ovs_mule::install (
  $server_package_name,
  $app_package_name,
  $repo_name,
  $server_package_version,
){
  
  if ! ($server_package_name or $app_package_name) {
    fail('No server or app package name specified')
  }
  
  $timestamp = generate('/bin/date', '+%Y%m%d%H%M%S')
  
  # Example:
  # server_package_version = 3.5.0-118 
  # server_version_num     = 3.5.0
  $server_version_num = split($server_package_version, '-')
  
  transition { 'Remove Mule App':
    resource   => Package[$app_package_name],
    attributes => { ensure => 'absent' },
    prior_to   => Package[$server_package_name],
  }

  package { $server_package_name:
    ensure          => $server_package_version,
    install_options => [ { '--disablerepo' => '*' }, { '--enablerepo' => $repo_name } ]
  }
  
  exec{ "Rename backup folder":
    command => "/bin/mv /opt/mule-standalone-${server_version_num[0]}-${server_package_name}-${server_package_version} /opt/mule-standalone-${server_version_num[0]}-${server_package_name}-${server_package_version}_${timestamp}",
    onlyif => "/usr/bin/test -d /opt/mule-standalone-${server_version_num[0]}-${server_package_name}-${server_package_version}",
    before  => Package["${server_package_name}"]
  }

}