#
# Cookbook Name:: dployco-sysctl
# Recipe:: default
#
# Copyright 2013, dploy.co
#
# All rights reserved - Do Not Redistribute
#
directory "/etc/sysctl.d" do
  mode  "0755"
  owner "root"
  group "root"
  action :create
end

template "/etc/sysctl.d/70-dployco-defaults.conf" do
  mode  "0644"
  owner "root"
  group "root"
  source "sysctl.conf.erb"
end

node['dployco']['sysctl'].each do |systcl, value|
  execute "Setting sysctl: #{systcl}" do
    command "sysctl -w #{systcl}=#{value}"
    action :run
  end
end
