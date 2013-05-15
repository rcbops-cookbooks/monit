# -*- mode: ruby -*-
# vi: set ft=ruby :
# encoding: utf-8

site :opscode

metadata

group :test do
  # use master commits like we do in chef-cookbooks
  cookbook "apt",         :git => "https://github.com/opscode-cookbooks/apt.git"
  cookbook "osops-utils", :git => "https://github.com/rcbops-cookbooks/osops-utils.git", :branch => "grizzly"
  cookbook "yum",         :git => "https://github.com/opscode-cookbooks/yum.git"

  # use our local test cookbooks
  cookbook "monit_test", :path => "./test/cookbooks/monit_test"

  # use specific version until minitest file discovery is fixed
  cookbook "minitest-handler", "0.1.7"
end
