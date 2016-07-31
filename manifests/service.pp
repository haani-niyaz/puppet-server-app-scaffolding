class ovs_mule::service{
  
  service { 'muled':
    enable    => 'false',
    ensure    => 'running',
    hasstatus => false,
    status    => "ps -ef | grep mule | grep -v grep | grep -v muled"
  }
}