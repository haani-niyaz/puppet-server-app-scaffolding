class ovs_mule::config (
$server_package_version,
){
  # Example:
  # server_package_version = 3.5.0-118 
  # server_version_num        = 3.5.0
  $server_version_num = split($server_package_version, '-')
  
  group { 'mule':
    ensure => present,
  }

  user { 'mule':
    ensure  => present,
    groups  => ["mule"],
    require => Group["mule"]
  }

  file { ["/opt/mule-standalone-${server_version_num[0]}","/shared/conf","/shared/data","/shared/log"]:
    ensure  => directory,
    notify  => Class['ovs_mule::service'],
  }

  chown_r { ["/opt/mule-standalone-${server_version_num[0]}","/shared/conf","/shared/data","/shared/log"]:  
    want_user  => "mule",
    want_group => "mule",
    notify     => Class['ovs_mule::service'],
  }

  file { "/opt/mule":
    ensure  => link,
    target  => "/opt/mule-standalone-${server_version_num[0]}",
    owner   => "mule",
    group   => "mule",
    notify  => Class['ovs_mule::service'],
  }

}
