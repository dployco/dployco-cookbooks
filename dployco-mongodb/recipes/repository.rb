# docs.mongodb.org/manual/tutorial/install-mongodb-on-debian/
# docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
# TODO: docs.mongodb.org/manual/tutorial/install-mongodb-on-red-hat-centos-or-fedora-linux/

case node['platform_family']
when 'debian'
  execute "apt-key mongodb-10gen" do
    command "apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10"
  end
  execute "apt-get update" do
    action :nothing
  end
  file "/etc/apt/sources.list.d/10gen.list" do
    case node['platform']
    when 'ubuntu'
      content "deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen"
    else
      content "deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen"
    end
    notifies :run, "execute[apt-get update]", :immediately
  end
else
  Chef::Log.warn "Adding #{node['platform']} 10gen repository is not supported"
end
