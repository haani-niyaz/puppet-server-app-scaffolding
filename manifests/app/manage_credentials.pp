define ovs_mule::app::manage_credentials(
	$key, 
	$value, 
	$file_path) {
    	
	file_line { "change password for $key in $file_path":
		  path   => $file_path,
		  line   => "$key=$value",
		  match  => "$key",
	}

}
