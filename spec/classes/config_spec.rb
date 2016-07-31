require 'spec_helper'
require 'shared_contexts'

describe 'ovs_mule_server::config' do
  hiera = Hiera.new(:config => 'spec/fixtures/hiera/hiera.yaml')

  server_package_version = hiera.lookup('ovs_mule_server::version',nil,nil)
  server_version_num     = server_package_version.split('-')

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
      :server_package_version  => server_package_version
    }
  end
  
  
  # add these two lines in a single test block to enable puppet and hiera debug mode
  # Puppet::Util::Log.level = :debug
  # Puppet::Util::Log.newdestination(:console)
  
  context 'when mule_server package is installed' do
    it{ 
	   is_expected.to contain_group('mule')
          .with(
            'ensure'  => 'present',
    )}
	
	it{ 
	   is_expected.to contain_user('mule')
          .with(
            'ensure'   => 'present',
            'groups'   => 'mule',
    )}
	
	it{ 
	   is_expected.to contain_file("/opt/mule-standalone-#{server_version_num[0]}")
          .with(
            'ensure'  => 'directory',
    )}

  it{ 
	   is_expected.to contain_file('/opt/mule')
          .with(
            'ensure'  => 'link',
            'target'  => "/opt/mule-standalone-#{server_version_num[0]}",
    )}
  
  it{ 
	   is_expected.to contain_file('/shared/conf')
          .with(
            'ensure'  => 'directory',
            
    )}
  it{ 
	   is_expected.to contain_file('/shared/data')
          .with(
            'ensure'  => 'directory',
            
    )}
  it{ 
	   is_expected.to contain_file('/shared/log')
          .with(
            'ensure'  => 'directory',
            
    )}

    [ "/opt/mule-standalone-#{server_version_num[0]}" ,'/shared/data', '/shared/log', '/shared/conf'].each do |dir|

      it{
         is_expected.to contain_chown_r(dir)
            .with(
              'want_user'  => 'mule',
              'want_group' => 'mule',
      )}
           
    end
  
  end 

end
