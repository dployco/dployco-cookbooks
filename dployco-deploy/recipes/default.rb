#
# Cookbook Name:: deploy
# Recipe:: default
#
# Copyright 2013, dploy.co
#
# All rights reserved - Do Not Redistribute
#

a = node['dployco']['deploy']
path = a['deploy_to'].gsub('{name}', a['name'])

user a['user'] do
  action :create
  supports manage_home: true
  # TODO: allow customization for all user params
end

group a['group'] do
  action :create
  members a['user']
  # TODO: allow customization for all group params
end

directory File.join('/', 'home', a['user']) do
  owner a['user']
  group a['group']
  mode  '0750'
end

directory path do
  owner a['user']
  group a['group']
  mode  '0755'
  recursive true
end

case a['scm_provider']
when 'svn'
  package 'subversion'
when 'git'
  package 'git'

  ssh_key_path = ::File.join(path, 'id_deploy')
  ssh_wrapper = "#!/bin/sh\n/usr/bin/env ssh -o 'StrictHostKeyChecking=no' $1 $2"

  file ssh_key_path do
    content a['deploy_key']
    owner a['user']
    group a['group']
    mode  '0755'
    only_if { a['deploy_key'] && a['deploy_key'].size > 0 }
  end

  if a['deploy_key'] && a['deploy_key'].size > 0
    ssh_wrapper = "#!/bin/sh\n/usr/bin/env ssh -o 'StrictHostKeyChecking=no' -i '#{ssh_key_path}' $1 $2"
  end

  file ::File.join(path, 'git-ssh-wrapper') do
    content ssh_wrapper
    owner a['user']
    group a['group']
    mode  '0600'
  end
end

deploy a['name'] do

  action a['action'].to_sym

  case a['scm_provider']
  when 'git'
    scm_provider Chef::Provider::Git
    enable_submodules a['enable_submodules']
    remote a['remote']
    shallow_clone a['shallow_clone']
    git_ssh_wrapper a['git_ssh_wrapper']
  when 'svn'
    scm_provider Chef::Provider::Subversion
    svn_arguments a['svn_arguments']
    svn_password a['svn_password']
    svn_username a['svn_username']
  end
  scm_provider a['scm_provider']
  enable_submodules a['enable_submodules']
  repository a['repository']
  if a['revision']
    revision a['revision']
  elsif a['branch']
    branch a['branch']
  end
  deploy_to path

  user a['user']
  group a['group']
  environment a['environment']
  symlink_before_migrate a['symlink_before_migrate']

  before_migrate do
  end

  migration_command a['migration_command']
  migrate a['migrate']

  before_symlink do
  end

  purge_before_symlink a['purge_before_symlink']
  create_dirs_before_symlink a['create_dirs_before_symlink']

  symlinks a['symlinks']

  before_restart do
  end

  after_restart do
  end

end
