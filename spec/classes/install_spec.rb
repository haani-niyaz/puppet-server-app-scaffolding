require 'spec_helper'
require 'shared_contexts'

describe 'ovs_mule_server::install' do
  hiera = Hiera.new(:config => 'spec/fixtures/hiera/hiera.yaml')

  server_package_name    = hiera.lookup('ovs_mule_server::package_name',nil,'undef')
  app_package_name       = hiera.lookup('ovs_mule_app::package_name',nil,'undef')
  repo_details           = hiera.lookup('repodetails',nil,nil)
  server_package_version = hiera.lookup('ovs_mule_server::version',nil,"latest")
  
  repo_name = repo_details['ovs-releases']['descr']

  # below is the facts hash that gives you the ability to mock
  # facts on a per describe/context block.  If you use a fact in your
  # manifest you should mock the facts below.
  let(:facts) do
    {}
  end
  
  # below is a list of the resource parameters that you can override.
  # By default all non-required parameters are commented out,
  # while all required parameters will require you to add a value
  let(:params) do
  {  
    :server_package_name    => server_package_name,
    :app_package_name       => app_package_name,
    :repo_name              => repo_name,
    :server_package_version => server_package_version,
  }
  end
  
  # add these two lines in a single test block to enable puppet and hiera debug mode
  # Puppet::Util::Log.level = :debug
  # Puppet::Util::Log.newdestination(:console)
  
  #TODO: how to check if package name exist in rspec?
  #if ! ($server_package_name or $app_package_name) {
  # fail('No server or app package name specified')
  #}
  
  # Refer to 'Rename backup folder' testcase
  #server_version_num = server_package_version.split('-')
  #t = Time.now
  #timestamp = t.strftime "%Y%m%d%H%M%S"
  
  context 'when mule_server package is installed' do
    it{ 
	   is_expected.to contain_transition('Remove Mule App')
          .with(
		    'resource'     => "Package[#{app_package_name}]",
		    'attributes'   => { 'ensure' => 'absent' },
		    'prior_to'     => "Package[#{server_package_name}]",
    )}
	
    it{ 
	   is_expected.to contain_package(server_package_name)
          .with(
		    'ensure'          => server_package_version,
		    'install_options' => [ { '--disablerepo' => '*' }, { '--enablerepo' => repo_name } ]
    )}
	
	# Different timestamp generated during catalogue compilation and catalogue execution leading to testcase failure.
	# it{ 
	   # is_expected.to contain_exec('Rename backup folder')
          # .with(
            # 'command' => "/bin/mv /opt/mule-standalone-#{server_version_num[0]}-#{server_package_name}-#{server_package_version} /opt/mule-standalone-#{server_version_num[0]}-#{server_package_name}-#{server_package_version}_#{timestamp}",
            # 'onlyif'  => "/usr/bin/test -d /opt/mule-standalone-#{server_version_num[0]}-#{server_package_name}-#{server_package_version}",
            # 'before'  => "Package[#{server_package_name}]"
	# )}
  end

end
