require 'spec_helper'
require 'shared_contexts'

describe 'ovs_mule_server::service' do

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
      :mule_server_on_boot  => "false",
      :mule_server_status   => "running",
    }
  end
  
  # add these two lines in a single test block to enable puppet and hiera debug mode
  # Puppet::Util::Log.level = :debug
  # Puppet::Util::Log.newdestination(:console)
 
  context 'when muled service is disabled' do
    it{ 
	   is_expected.to contain_service('muled')
          .with(
            'enable'    => "false",
            'ensure'    => "running",
            'hasstatus' => false,
            'status'    => "ps -ef | grep mule | grep -v grep | grep -v muled"
    )}
  end
  
end