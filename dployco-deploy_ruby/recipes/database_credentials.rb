#
# Cookbook Name:: dployco-deploy_ruby
# Recipe:: database_credentials
#
# Copyright 2013, Devops Israel
#
# All rights reserved - Do Not Redistribute
#

database_connection = { host: node[:dployco][:database][:host] }

case node[:dployco][:database][:type]
when "postgresql"
  include_recipe "database::postgresql"
  db_provider = Chef::Provider::Database::Postgresql
  db_user_provider = Chef::Provider::Database::PostgresqlUser
  db_root_password = node[:dployco][:database][:root_password] || node[:postgresql][:password][:postgres]
  db_port = node[:dployco][:database][:port] || node[:postgresql][:config][:port] || 5432
  database_connection.merge!({ :username => "postgres", :password => db_root_password })
when "mysql"
  include_recipe "database::mysql"
  db_provider = Chef::Provider::Database::Mysql
  db_user_provider = Chef::Provider::Database::MysqlUser
  db_root_password = node[:dployco][:database][:root_password] || node[:mysql][:server_root_password]
  db_port = node[:dployco][:database][:port] || node[:mysql][:port] || 3306
  database_connection.merge!({ :username => "root", :password => db_root_password })
else
    Chef::Application.fatal!("Unsupported database type.")
end

database node[:dployco][:database][:name] do
  connection database_connection # won't work with 127.0.0.1 as a host
  provider   db_provider
  action :create
end

database_user node[:dployco][:database][:username] do
  connection    database_connection
  provider      db_user_provider
  password      node[:dployco][:database][:password]
  database_name node[:dployco][:database][:name]
  action        [:create, :grant]
end

node.set_unless[:dployco][:database][:password] = node[:dployco][:database][:password]
