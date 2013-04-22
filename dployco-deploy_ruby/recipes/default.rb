#
# Cookbook Name:: deployco-deploy_ruby
# Recipe:: default
#
# Copyright 2013, Devops Israel
#
# All rights reserved - Do Not Redistribute
#

#-------- Prerequisites --------

include_recipe "ruby::#{node[:dployco][:deploy_ruby][:ruby_version]}" # install ruby
include_recipe "ruby::symlinks"

#-------- Common --------

if node[:dployco][:deploy][:name].split(" ").count > 1
  Chef::Application.fatal!("Application name must be one word long !")
end

case node[:dployco][:deploy][:scm]
  when "git" 
    include_recipe "git" # install git, no support for svn for now
  #when "svn"
  else Chef::Application.fatal!("Does not support SCM provide #{node[:dployco][:deploy][:type]} !")
end

# create deploy user & group
user node[:dployco][:deploy][:owner] do
  action :create
  supports manage_home => false
end
group node[:dployco][:deploy][:group] do
  action :create
  members node[:dployco][:deploy][:owner]
end
#directory File.join('/','home',node[:dployco][:deploy][:owner]) do
#  owner node[:dployco][:deploy][:owner]
#  group node[:dployco][:deploy][:group]
#end


#-------- Deploying --------

# can't put node[:dployco][...] things inside the database block

db_host     = node[:dployco][:deploy][:database][:host]
db_name     = node[:dployco][:deploy][:database][:name]
db_username = node[:dployco][:deploy][:database][:username]
db_password = node[:dployco][:deploy][:database][:password]
db_adapter  = node[:dployco][:deploy][:database][:adapter]

application node[:dployco][:deploy][:name] do
  action    node[:dployco][:deploy][:action]
  path      node[:dployco][:deploy][:path]

  if node[:dployco][:deploy][:ssh_key]
    deploy_key node[:dployco][:deploy][:ssh_key]
  end
  repository        node[:dployco][:deploy][:repository]
  revision          node[:dployco][:deploy][:revision]
  enable_submodules node[:dployco][:deploy][:enable_submodules]
  shallow_clone     node[:dployco][:deploy][:shallow_clone]

  environment_name  node[:dployco][:deploy][:environment]
  scm_provider      node[:dployco][:deploy][:scm]

  packages   node[:dployco][:deploy][:packages]
  owner      node[:dployco][:deploy][:owner]
  group      node[:dployco][:deploy][:group]

  # symlink/remove/create various things during deploys
  purge_before_symlink       node[:dployco][:deploy][:purge_before_symlink]
  create_dirs_before_symlink node[:dployco][:deploy][:create_dirs_before_symlink]
  symlinks                   node[:dployco][:deploy][:symlinks]
  symlink_before_migrate     node[:dployco][:deploy][:symlink_before_migrate]

  # useful commands
  migrate           node[:dployco][:deploy][:migrate]
  migration_command node[:dployco][:deploy][:migration_command]
  restart_command   node[:dployco][:deploy][:restart_command]

  rails do
    bundler                node[:dployco][:deploy_ruby][:bundler]
    bundle_command         node[:dployco][:deploy_ruby][:bundle_command]
    bundler_deployment     node[:dployco][:deploy_ruby][:bundler_deployment]
    bundler_without_groups node[:dployco][:deploy_ruby][:bundler_without_groups]
    precompile_assets      node[:dployco][:deploy_ruby][:precompile_assets]
    database_master_role   node[:dployco][:deploy_ruby][:database_master_role]
    database_template      node[:dployco][:deploy_ruby][:database_template]
    gems                   node[:dployco][:deploy_ruby][:gems]
    # can't put node[:dployco][...] things inside the database block
    database do
      adapter  db_adapter
      host     db_host
      database db_name
      username db_username
      password db_password
    end
  end

  before_restart do
    execute "upstart-reload-configuration" do
      command "/sbin/initctl reload-configuration"
      action [:nothing]
    end
  end

end

