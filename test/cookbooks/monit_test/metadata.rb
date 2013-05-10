name             "monit_test"
maintainer       "Rackspace US, Inc"
license          "Apache 2.0"
description      "Installs and configures monit_test"
version          "0.0.1"

%w{ amazon centos debian fedora oracle redhat scientific ubuntu }.each do |os|
  supports os
end

%w{ monit }.each do |dep|
  depends dep
end
