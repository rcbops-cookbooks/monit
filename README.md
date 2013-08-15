Support
=======

Issues have been disabled for this repository.
Any issues with this cookbook should be raised here:

[https://github.com/rcbops/chef-cookbooks/issues](https://github.com/rcbops/chef-cookbooks/issues)

Please title the issue as follows:

[monit]: \<short description of problem\>

In the issue description, please include a longer description of the issue, along with any relevant log/command/error output.
If logfiles are extremely long, please place the relevant portion into the issue description, and link to a gist containing the entire logfile

Please see the [contribution guidelines](CONTRIBUTING.md) for more information about contributing to this cookbook.

Description
===========

Installs Monit.

http://mmonit.com/monit

Requirements
============

Chef 11.0 or higher required (for Chef environment use).

Platforms
---------

This cookbook is actively tested on the following platforms/versions:

* Ubuntu-12.04
* CentOS-6.3

While not actively tested, this cookbook should also work the following platforms:

* Debian/Mint derivitives
* Amazon/Oracle/Scientific/RHEL

Cookbooks
---------

The following cookbooks are dependencies:

* osops-utils

Resources/Providers
===================

procmon
-------

The procmon resource can be used to configure monitoring of a process:

    include_recipe "monit::server"
    
    # matching a process name
    monit_procmon "apache" do
      process_name "apache2"
      start_cmd "/etc/init.d/apache2 start"
      stop_cmd "/etc/init.d/apache2 stop"
    end
    
    # using a pid file
    monit_procmon "apache" do
      pid_file "/var/run/httpd.pid"
      start_cmd "/etc/init.d/apache2 start"
      stop_cmd "/etc/init.d/apache2 stop"
    end

Recipes
=======

default
-------
Installs the monit package and configures the monit service

server
------
Installs the monit package and configures the monit service

Attributes
==========

* `default["monit"]["poll_interval"]` - The monitor polling interval
* `default["monit"]["poll_start_delay"]` - The delay time before starting polling
* `default["monit"]["bind_port"]` - The port to bind monit to
* `default["monit"]["bind_host"]` - The host/ip to find monit to
* `default["monit"]["login_user"]` - The monit login user
* `default["monit"]["login_pass"]` - The monit login password
* `default["monit"]["allowed_hosts"]` - The list of hosts allowed to connect to monit
* `default["monit"]["config_dir"]` - The monit configuration directory path
* `default["monit"]["conf.d_dir"]` - The monit config.d directory path
* `default["monit"]["service_bin"]` - The platform service management binary
* `default["monit"]["config_file"]` - The monit configuration file path
* `default["monit"]["notify_email"]` - Enable/Disable email notifications
* `default["monit"]["mail_format"]["subject"]` - The email notification subject
* `default["monit"]["mail_format"]["from"]` - The email notifiation from address
* `default["monit"]["mail_format"]["message"]` - The email notification message template

Templates
=========

* `default.monit.erb` - Upstart default file for monit service
* `monitrc.erb` - Monit rc file
* `procmon.erb` - Process monitoring config file template

License and Author
==================

Author:: Justin Shepherd (<justin.shepherd@rackspace.com>)
Author:: Jason Cannavale (<jason.cannavale@rackspace.com>)
Author:: Ron Pedde (<ron.pedde@rackspace.com>)
Author:: Joseph Breu (<joseph.breu@rackspace.com>)
Author:: William Kelly (<william.kelly@rackspace.com>)
Author:: Darren Birkett (<darren.birkett@rackspace.co.uk>)
Author:: Evan Callicoat (<evan.callicoat@rackspace.com>)
Author:: Chris Laco (<chris.laco@rackspace.com>)

Copyright 2012-2013, Rackspace US, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
