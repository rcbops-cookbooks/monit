#
# Cookbook Name:: monit
# Recipe:: server
#
# Copyright 2012, Rackspace US, Inc.
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

case node["platform"]
when "fedora", "redhat", "centos", "scientific", "amazon"
  # If this is a RHEL based system install the RCB prod and testing repos

  major = node['platform_version'].to_i
  arch = node['kernel']['machine']

  if not platform?("fedora")
    include_recipe "yum::epel"
    yum_os="RedHat"
  else
    yum_os="Fedora"
  end

  yum_key "RPM-GPG-RCB" do
    url "http://build.monkeypuppetlabs.com/repo/RPM-GPG-RCB.key"
    action :add
  end

  yum_repository "rcb" do
    repo_name "rcb"
    description "RCB Ops Stable Repo"
    url "http://build.monkeypuppetlabs.com/repo/#{yum_os}/#{major}/#{arch}"
    key "RPM-GPG-RCB"
    action :add
  end

  yum_repository "rcb-testing" do
    repo_name "rcb-testing"
    description "RCB Ops Testing Repo"
    url "http://build.monkeypuppetlabs.com/repo-testing/#{yum_os}/#{major}/#{arch}"
    key "RPM-GPG-RCB"
    enabled 1
    action :add
  end
end

case node["platform"]
when "ubuntu", "debian"
  pkg_options = "-o Dpkg::Options:='--force-confold' -o Dpkg::Option:='--force-confdef'"
else
  pkg_options = ""
end

package "monit" do
  action :install
  options pkg_options
end

case node["platform"]
when "ubuntu", "debian"
  template "/etc/default/monit" do
    source "default.monit.erb"
    owner "root"
    group "root"
    mode 0644
  end
end

directory "/var/lib/monit" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

service "monit" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
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
  notifies :restart, resources(:service => "monit"), :delayed
end
