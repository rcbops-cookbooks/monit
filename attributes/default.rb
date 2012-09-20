default["monit"]["poll_interval"] = 60                                        # node_attribute
default["monit"]["poll_start_delay"] = 30                                     # node_attribute
default["monit"]["bind_port"] = "2812"                                        # node_attribute
default["monit"]["bind_host"] = "0.0.0.0"                                     # node_attribute
default["monit"]["login_user"] = "admin"                                      # node_attribute
default["monit"]["login_pass"] = "monit"                                      # node_attribute
default["monit"]["allowed_hosts"] = [ "0.0.0.0/0" ]                           # node_attribute

case node["platform"]                                                         # node_attribute
when "fedora", "redhat", "amazon", "centos", "scientific"                     # node_attribute
  default["monit"]["config_dir"] = "/etc"                                     # node_attribute
  default["monit"]["conf.d_dir"] = "#{node['monit']['config_dir']}/monit.d"   # node_attribute
  default["monit"]["service_bin"] = "/sbin/service"                           # node_attribute
else
  default["monit"]["config_dir"] = "/etc/monit"                               # node_attribute
  default["monit"]["conf.d_dir"] = "#{node['monit']['config_dir']}/conf.d"    # node_attribute
  default["monit"]["service_bin"] = "/usr/sbin/service"                       # node_attribute
end

default["monit"]["config_file"] = "#{node['monit']['config_dir']}/monitrc"    # node_attribute

# Notice: no notifies by default.  You must override this attribute
# to send monit alerts
default["monit"]["notify_email"]           = nil                              # cluster_attribute
default["monit"]["mail_format"]["subject"] = "$SERVICE $EVENT"                # cluster_attribute
default["monit"]["mail_format"]["from"]    = "monit@example.com"              # cluster_attribute
default["monit"]["mail_format"]["message"]    = <<-EOS                        # cluster_attribute
Monit $ACTION $SERVICE at $DATE on $HOST: $DESCRIPTION.
Yours sincerely,
monit
EOS
