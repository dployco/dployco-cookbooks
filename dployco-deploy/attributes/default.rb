###
# http://docs.opscode.com/resource_deploy.html
#
default['dployco']['deploy']['name'] = '' # mandatory attribute
default['dployco']['deploy']['action'] = :deploy # :deploy/:force_deploy/:rollback

default['dployco']['deploy']['user'] = 'deploy'
default['dployco']['deploy']['group'] = 'deploy'
default['dployco']['deploy']['environment'] = {}

default['dployco']['deploy']['scm_provider'] = 'git' # git/svn/subversion
if node['dployco']['deploy']['scm_provider'] == 'git'
  default['dployco']['deploy']['enable_submodules'] = false
  default['dployco']['deploy']['remote'] = 'origin'
  default['dployco']['deploy']['shallow_clone'] = true
  default['dployco']['deploy']['git_ssh_wrapper'] = nil
  default['dployco']['deploy']['deploy_key'] = nil
end
if node['dployco']['deploy']['scm_provider'] == 'svn'
  default['dployco']['deploy']['svn_arguments'] = ''
  default['dployco']['deploy']['svn_password'] = ''
  default['dployco']['deploy']['svn_username'] = ''
end
default['dployco']['deploy']['repository'] = '' # mandatory attribute
default['dployco']['deploy']['branch'] = 'master'
default['dployco']['deploy']['revision'] = nil
default['dployco']['deploy']['deploy_to'] = '/var/www/projects/{name}'

default['dployco']['deploy']['migrate'] = false
default['dployco']['deploy']['migration_command'] = ""
default['dployco']['deploy']['symlink_before_migrate'] = {}

default['dployco']['deploy']['symlinks'] = {}
default['dployco']['deploy']['purge_before_symlink'] = []
default['dployco']['deploy']['create_dirs_before_symlink'] = []
