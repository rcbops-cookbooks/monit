maintainer       "Rackspace US, Inc"
license          "Apache 2.0"
description      "Installs and configures monit."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.10"
provides	 "service[monit]"

%w{ ubuntu fedora }.each do |os|
  supports os
end

%w{ apt yum }.each do |dep|
  depends dep
end
