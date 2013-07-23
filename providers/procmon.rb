#
# Cookbook Name:: monit
# Provider:: procmon
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

action :add do
  # use default service_bin for the platform if it has not been
  # set in the provider call
  if not @new_resource.service_bin.nil?
    service_bin = new_resource.service_bin
  else
    service_bin = node["monit"]["service_bin"]
  end

  # if script_name was not set then default it to ""
  if not @new_resource.script_name.nil?
    script_name = new_resource.script_name
  else
    script_name = ""
  end

  # if start_cmd is not defined default to 'start'
  if not @new_resource.start_cmd.nil?
    start_cmd = new_resource.start_cmd
  else
    start_cmd = "start"
  end

  # if start_cmd is not defined default to 'start'
  if not @new_resource.stop_cmd.nil?
    stop_cmd = new_resource.stop_cmd
  else
    stop_cmd = "stop"
  end

  r = template "#{node['monit']['conf.d_dir']}/#{new_resource.name}.conf" do
    owner "root"
    group "root"
    mode 0644
    source "procmon.erb"
    cookbook "monit"
    variables(
      "identifier" => new_resource.name,
      "process_name" => new_resource.process_name,
      "pid_file" => new_resource.pid_file,
      "script_name" => script_name,
      "service_bin" => service_bin,
      "stop_cmd" => stop_cmd,
      "start_cmd" => start_cmd
    )
    action :create
    notifies :reload, "service[monit]", :immediately
  end
  new_resource.updated_by_last_action(r.updated_by_last_action?)
end
