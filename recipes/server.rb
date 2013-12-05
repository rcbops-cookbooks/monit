#
# Cookbook Name:: monit
# Recipe:: server
#
# Copyright 2012-2013, Rackspace US, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "osops-utils::packages"

if platform_family?("debian")
  pkg_options = "-o Dpkg::Options::='--force-confold'"
  pkg_options += " -o Dpkg::Options::='--force-confdef'"
else
  pkg_options = ""
end

package "monit" do
  action :install
  options pkg_options
end

template "/etc/default/monit" do
  source "default.monit.erb"
  owner "root"
  group "root"
  mode 0644
  only_if { platform_family?("debian") }
end

directory "/var/lib/monit" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

service "monit" do
  supports value_for_platform_family(
    "rhel" => { "default" => [:status, :restart] },
    "default" => { "default" => [:status, :restart, :reload] }
  )

  action [:enable]
end

template node["monit"]["config_file"] do
  source "monitrc.erb"
  owner "root"
  group "root"
  mode 0600
  variables(
    "poll_interval" => node["monit"]["poll_interval"],
    "poll_start_delay" => node["monit"]["poll_start_delay"],
    "bind_port" => node["monit"]["bind_port"],
    "bind_host" => node["monit"]["bind_host"],
    "login_user" => node["monit"]["login_user"],
    "login_pass" => node["monit"]["login_pass"],
    "allowed_hosts" => node["monit"]["allowed_hosts"]
  )
  notifies :restart, "service[monit]", :delayed
end
