#
# Cookbook Name:: dployco-unicorn
# Recipe:: default
#
# Copyright 2013, Devops Israel
#
# All rights reserved - Do Not Redistribute
#

gem_package "unicorn"

service node[:dployco][:unicorn][:appname] do 
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [ :disable, :stop ]
  only_if { node[:dployco][:unicorn][:uninstall] }
end

# create user & group
user node[:dployco][:unicorn][:owner] do
  action :create
  supports manage_home => true
  not_if { node[:dployco][:unicorn][:uninstall] }
end
group node[:dployco][:unicorn][:group] do
  action :create
  members node[:dployco][:unicorn][:owner]
  not_if { node[:dployco][:unicorn][:uninstall] }
end

unicorn_config "/etc/unicorn/#{node[:dployco][:unicorn][:appname]}.rb" do
  listen({ node[:dployco][:unicorn][:port] => node[:dployco][:unicorn][:options] })
  working_directory ::File.join(node[:dployco][:unicorn][:application_deploy_path], 'current')
  worker_timeout node[:dployco][:unicorn][:worker_timeout]
  preload_app node[:dployco][:unicorn][:preload_app]
  worker_processes node[:dployco][:unicorn][:worker_processes]
  before_fork node[:dployco][:unicorn][:before_fork]
  owner node[:dployco][:unicorn][:owner]
  group node[:dployco][:unicorn][:group]
  not_if { node[:dployco][:unicorn][:uninstall] }
end


directory "/etc/unicorn/" do
  action :delete
  recursive true
  only_if { node[:dployco][:unicorn][:uninstall] }
end

 template "/etc/init/#{node[:dployco][:unicorn][:appname]}.conf" do
  owner node[:dployco][:unicorn][:owner] if node[:dployco][:unicorn][:owner]
  group node[:dployco][:unicorn][:group] if node[:dployco][:unicorn][:group]
  mode "0750"  
  path "/etc/init/#{node[:dployco][:unicorn][:appname]}.conf"
  source "unicorn.conf.erb"
  variables( :app_name  => node[:dployco][:unicorn][:appname],
             :app_path  => node[:dployco][:unicorn][:application_deploy_path],
             :owner     => node[:dployco][:unicorn][:owner],
             :group     => node[:dployco][:unicorn][:group],
             :rails_env => node[:dployco][:unicorn][:environment],
             :bundler   => node[:dployco][:unicorn][:bundler],
             :socket    => node[:dployco][:unicorn][:port],
             :rbfile    => node[:dployco][:unicorn][:rbfile],
             :bundle_command   => node[:dployco][:unicorn][:bundle_command],
             :smells_like_rack => ::File.exists?(::File.join(node[:dployco][:unicorn][:application_deploy_path], "current", "config.ru"))
           )
  not_if { node[:dployco][:unicorn][:uninstall] }
end

file "/etc/init/#{node[:dployco][:unicorn][:appname]}.conf" do
  action :delete
  only_if { node[:dployco][:unicorn][:uninstall] }
end

service node[:dployco][:unicorn][:appname] do 
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
  not_if { node[:dployco][:unicorn][:uninstall] }
end