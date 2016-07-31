# ovs\_mule\_server

#### Table of Contents

1. [Description - What the module does and why it is useful](#description)
3. [Setup - The basics of getting started with ovs\_mule\_server](#setup)
    * [Dependency Modules](#dependency-modules)
    * [Hiera Setup](#hiera-setup)
    * [Beginning with ovs\_mule\_server](#beginning-with-ovs\_mule\_server)
    * [Public Classes](#public-classes)
    * [Private Classes](#private-classes)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Development](#development)
    * [Running Tests](#running-tests)

## <a name=description></a>Description

The module installs, configures and maintaians `ovs-mule-server-ce` package. Incase of any upgrade or downgrade, the module uninstalls `ovs-mule-apps` package by invoking `ovs_mule_app` module. The `ovs_mule_app` module takes care of the installation.

## <a name=setup></a>Setup

### <a name=dependency-modules></a>Dependency modules

* ovs\_mule\_app
* transition

### <a name=hiera-setup></a>Hiera Setup

All data items except for `mule_server_on_boot` and `mule_server_status` are read from hiera and passed through profile `mule_esb`. All except for `repo_name` is defaulted in params class.

```
mule_server_package -  String. Package name for mule server installation. defaults to ovs_mule_server::params::mule_server_package
mule_app_package - String. Package name for mule app removal. defaults to ovs_mule_server::params::mule_app_package
repo_name - String. Name of the repo where mule Server package is available.
mule_server_version - String. Package version for mule server installation. defaults to ovs_mule_server::params::mule_server_version
mule_server_on_boot - String. Mentions if the mule service should be configured to start on boot. defaults to ovs_mule_server::params::mule_server_on_boot
mule_server_status - String. Mentions the desired mule service status. defaults to ovs_mule_server::params::mule_server_status
```

### <a name=beginning-with-ovs\_mule\_server></a>Beginning with ovs\_mule\_server

Declare the main `::ovs_mule_server` class.

```
  class { 'ovs_mule_server':
    mule_server_package => hiera('ovs_mule_server::package_name'),
    mule_app_package    => hiera('ovs_mule_app::package_name'),
    repo_name           => $repo_name,
    mule_server_version => hiera('ovs_mule_server::version'),
  }
```

### <a name=public-classes></a>Public Classes
``ovs_mule_server``: Main class. Manages the installation, configuration and maintenance of ovs-mule-server-ce package. 

### <a name=private-classes></a>Private Classes
``ovs_mule_server::install``: Installs `ovs-mule-server-ce` package. 

``ovs_mule_server::config``: Configures the `mule` user and `/opt/mule-standalone-{server_version_num}`, `/opt/mule`, `/shared/conf`, `/shared/data`, `/shared/log` directories after `ovs-mule-server-ce` package installation.

``ovs_mule_server::service``: Maintains `muled` service. 

## <a name=usage></a>Usage

The `ovs_mule_server` class needs to declared with all the required parameters as described above.

## <a name=development></a>Development

### <a name=running-tests></a>Running Tests

This module contains tests for rspec-puppet to verify functionality. Please refer to <a href="https://wiki.staging.proteus.corp.telstra.com/display/PA/How+to+Test+your+Puppet+Code">Rspec Testing</a> for more details.

#### Testing quickstart

```
gem install bundler
bundle install
bundle exec rake spec
```