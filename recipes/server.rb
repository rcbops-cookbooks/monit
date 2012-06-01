#
# Cookbook Name:: monit
# Recipe:: server
#
# Copyright 2009, Rackspace Hosting, Inc.
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

package "monit" do
  action :upgrade
  options "-o Dpkg::Options:='--force-confold' -o Dpkg::Option:='--force-confdef'"
end

case node['platform']
when 'ubuntu', 'debian'
  template "/etc/default/monit" do
    source "default.monit.erb"
    owner "root"
    group "root"
    mode 0644
  end
end

service "monit" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

# TODO(shep): we need a variable stanza for passing in attributes
template "/etc/monit/monitrc" do
  source 'monitrc.erb'
  owner "root"
  group "root"
  mode 0600
  variables(
    "poll_interval" => node["monit"]["poll_interval"],
    "poll_start_delay" => node["monit"]["poll_start_delay"]
  )
  notifies :restart, resources(:service => "monit"), :delayed
end
