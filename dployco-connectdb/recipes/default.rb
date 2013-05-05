#
# Cookbook Name:: dploycon-connectdb
# Recipe:: default
#
# Copyright 2013, Devops Israel
#
# All rights reserved - Do Not Redistribute
#

database_connection = { host: node[:dployco][:connectdb][:host] }

case node[:dployco][:connectdb][:type]
when 'postgresql'
  include_recipe "postgresql::ruby"
  db_provider = Chef::Provider::connectdb::Postgresql
  db_user_provider = Chef::Provider::connectdb::PostgresqlUser
  db_root_password = node[:dployco][:connectdb][:root_password] #|| node[:postgresql][:password][:postgres]
  db_port = node[:dployco][:connectdb][:port]
  database_connection.merge!({ :username => "postgres", :password => db_root_password })
when 'mysql'
  include_recipe "mysql::ruby"
  db_provider = Chef::Provider::connectdb::Mysql
  db_user_provider = Chef::Provider::connectdb::MysqlUser
  db_root_password = node[:dployco][:connectdb][:root_password] #|| node[:mysql][:server_root_password]
  db_port = node[:dployco][:connectdb][:port]
  database_connection.merge!({ :username => "root", :password => db_root_password })
else
    Chef::Application.fatal!("Unsupported database type.")
end

database node[:dployco][:connectdb][:dbname] do
  connection database_connection # won't work with 127.0.0.1 as a host
  provider   db_provider
  action :create
end

database_user node[:dployco][:connectdb][:username] do
  connection    database_connection
  provider      db_user_provider
  password      node[:dployco][:connectdb][:password]
  database_name node[:dployco][:connectdb][:dbname]
  action        [:create, :grant]
end

node.set_unless[:dployco][:connectdb][:password] = node[:dployco][:connectdb][:password]
