default["monit"]["poll_interval"] = 60
default["monit"]["poll_start_delay"] = 30

case node["platform"]
when "fedora"
  default["monit"]["config_dir"] = "/etc"
  default["monit"]["conf.d_dir"] = "/etc/monit.d"
else
  default["monit"]["config_dir"] = "/etc/monit"
  default["monit"]["conf.d_dir"] = "#{node['monit']['config_dir']/conf.d"
end
default["monit"]["config_file"] = "#{node["monit"]["config_dir"]}/monitrc"

default[:monit][:notify_email]          = "notify@example.com"
default[:monit][:mail_format][:subject] = "$SERVICE $EVENT"
default[:monit][:mail_format][:from]    = "monit@example.com"
default[:monit][:mail_format][:message]    = <<-EOS
Monit $ACTION $SERVICE at $DATE on $HOST: $DESCRIPTION.
Yours sincerely,
monit
EOS

