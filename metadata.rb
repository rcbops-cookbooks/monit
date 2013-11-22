name             "monit"
maintainer       "Rackspace US, Inc"
license          "Apache 2.0"
description      "Installs and configures monit."
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION'))

%w{ amazon centos debian fedora oracle redhat scientific ubuntu }.each do |os|
  supports os
end

%w{ osops-utils }.each do |dep|
  depends dep
end

recipe "monit::default",
  "Installs the monit package and configures the monit service"

recipe "monit::server",
  "Installs the monit package and configures the monit service"

attribute "monit/poll_interval",
  :description => "The monitor polling interval",
  :default => "60"

attribute "monit/poll_start_delay",
  :description => "The delay time before starting polling",
  :default => "30"

attribute "monit/bind_port",
  :description => "The port to bind monit to",
  :default => "2812"

attribute "monit/bind_host",
  :description => "The host/ip to find monit to",
  :default => "0.0.0.0"

attribute "monit/login_user",
  :description => "The monit login user",
  :default => "admin"

attribute "monit/login_pass",
  :description => "The monit login password",
  :default => "monit"

attribute "monit/allowed_hosts",
  :description => "The list of hosts allowed to connect to monit",
  :default => ["0.0.0.0/0"]

attribute "monit/config_dir",
  :description => "The monit configuration directory path",
  :default => "(/etc|/etc/monit)"

attribute "monit/conf.d_dir",
  :description => "The monit config.d directory path",
  :default => "node['monit']['config_dir']/(monit.d|config.d)"

attribute "monit/service_bin",
  :description => "The platform service management binary",
  :default => "(/sbin/service|/usr/sbin/service)"

attribute "monit/config_file",
  :description => "The monit configuration file path",
  :default => "node['monit']['config_dir']/monitrc"

attribute "monit/notify_email",
  :description => "Enable/Disable email notifications",
  :default => nil

attribute "monit/mail_format/subject",
  :description => "The email notification subject",
  :default => "$SERVICE $EVENT"

attribute "monit/mail_format/from",
  :description => "The email notifiation from address",
  :default => "monit@example.com"

attribute "monit/mail_format/message",
  :description => "The email notification message template",
  :default => <<-EOS
Monit $ACTION $SERVICE at $DATE on $HOST: $DESCRIPTION.
Yours sincerely,
monit
EOS
