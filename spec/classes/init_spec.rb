# == Class: mule_server
require 'spec_helper'
require 'rspec-puppet-facts'
require 'shared_contexts'

describe 'ovs_mule_server' do
  hiera = Hiera.new(:config => 'spec/fixtures/hiera/hiera.yaml')

  mule_server_package = hiera.lookup('ovs_mule_server::package_name',nil,nil)
  mule_app_package    = hiera.lookup('ovs_mule_app::package_name',nil,nil)
  repo_details        = hiera.lookup('repodetails',nil,nil)
  mule_server_version = hiera.lookup('ovs_mule_server::version',nil,nil)
  mule_server_on_boot = hiera.lookup('mule_server_on_boot::params::mule_server_on_boot',nil,nil)
  mule_server_status  = hiera.lookup('mule_server_status::params::mule_server_status',nil,nil)
 
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
      :mule_server_package  => mule_server_package,
      :mule_app_package     => mule_app_package,
      :repo_name            => repo_name,
      :mule_server_version  => mule_server_version,
      :mule_server_on_boot  => mule_server_on_boot,
      :mule_server_status   => mule_server_status,
    }
  end
  
  # add these two lines in a single test block to enable puppet and hiera debug mode
   Puppet::Util::Log.level = :debug
   Puppet::Util::Log.newdestination(:console)
  
  it { should contain_class('ovs_mule_server::install').that_comes_before('Class[ovs_mule_server::config]') }
  it { should contain_class('ovs_mule_server::config').that_notifies('Class[ovs_mule_server::service]') }
  it { should contain_class('ovs_mule_server::service') }
  it { should contain_class('ovs_mule_server::params') }
  
  at_exit{ RSpec::Puppet::Coverage.report! }

end
