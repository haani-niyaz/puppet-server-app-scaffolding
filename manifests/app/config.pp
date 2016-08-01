class bat_mule::app::config($credentials){
  
  if ! ($credentials) {
    fail('Credentials are missing.')
  }else{
    create_resources(bat_mule::app::manage_credentials, $credentials['batcave']['batarange'])
  }

}
