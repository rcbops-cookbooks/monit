#
# Cookbook Name:: monit_test
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

require_relative "./support/helpers"

describe_recipe "monit_test::server" do
  include MonitTestHelpers

  describe "creates a monit configuration file" do
    let(:config) { file(::File.join(node["monit"]["config_file"])) }

    it { config.must_exist }
  end

  describe "runs the application as a service" do
    it { service("monit").must_be_enabled }
    it { service("monit").must_be_running }
  end
end
