#
# Cookbook Name:: monit
# Provider:: procmon
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

action :add do
    template "#{node['monit']['conf.d_dir']}/#{new_resource.name}.conf" do
        owner "root"
        group "root"
        mode 0644
        source "procmon.erb"
        cookbook "monit"
        variables(
            "identifier" => new_resource.name,
            "process_name" => new_resource.process_name,
            "stop_cmd" => new_resource.stop_cmd,
            "start_cmd" => new_resource.start_cmd
        )
        action :create
        notifies :reload, resources(:service => "monit"), :immediately
    end
    new_resource.updated_by_last_action(true)
end
