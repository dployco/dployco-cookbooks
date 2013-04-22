#
# Cookbook Name:: shipit
# Recipe:: database_server
#
# Copyright 2013, Devops Israel
#
# All rights reserved - Do Not Redistribute
#

case node[:shipit][:database][:type]
when "postgresql"
  node.set_unless['postgresql']['password']['postgres'] = node[:shipit][:database][:root_password]
  include_recipe "postgresql::server"
  include_recipe "database::postgresql"
when "mysql"
  node.set_unless['mysql']['server_root_password']  = node[:shipit][:database][:root_password]
  include_recipe "mysql::server"
  include_recipe "database::mysql"
else
  Chef::Application.fatal!("Unsupported database type.")
end
