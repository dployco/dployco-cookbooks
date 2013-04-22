default[:dployco][:deploy][:name] = "one word" # must be one word
default[:dployco][:deploy][:path] = "/var/www/projects/#{node[:dployco][:deploy][:name]}"
default[:dployco][:deploy][:environment] = "production"
default[:dployco][:deploy][:owner] = "deploy"
default[:dployco][:deploy][:group] = "deploy"
default[:dployco][:deploy][:packages] = []
default[:dployco][:deploy][:scm] = "git" # only git is supported at the moment
default[:dployco][:deploy][:ssh_key] = nil
default[:dployco][:deploy][:shallow_clone] = true
default[:dployco][:deploy][:repository] = nil
default[:dployco][:deploy][:revision] = "master"
default[:dployco][:deploy][:enable_submodules] = true
default[:dployco][:deploy][:action] = :deploy # can be :deploy or :force_deploy

default[:dployco][:deploy][:purge_before_symlink] = []
default[:dployco][:deploy][:create_dirs_before_symlink] = []
default[:dployco][:deploy][:symlinks] = {}
default[:dployco][:deploy][:symlink_before_migrate] = {}
default[:dployco][:deploy][:migrate] = false
default[:dployco][:deploy][:migration_command] = nil #"/usr/local/bin/bundle exec rake db:migrate"
default[:dployco][:deploy][:restart_command] = nil

default[:dployco][:deploy][:database][:host]     = "127.0.0.1"
default[:dployco][:deploy][:database][:name]     = node[:dployco][:deploy][:name]
default[:dployco][:deploy][:database][:username] = node[:dployco][:deploy][:name]
default[:dployco][:deploy][:database][:password] = nil
default[:dployco][:deploy][:database][:adapter]  = "mysql2"

#--- Ruby ---

default[:dployco][:deploy_ruby][:ruby_version] = "1.9.1"  # include ruby/recipes/{ver}.rb
default[:dployco][:deploy_ruby][:gems] = [ "bundler" ]

default[:dployco][:deploy_ruby][:precompile_assets] = nil # true or false
default[:dployco][:deploy_ruby][:database_master_role] = nil # used when rendering the `database.yml` file for the host
default[:dployco][:deploy_ruby][:database_template] = nil # nil means database.yml.erb will be used
default[:dployco][:deploy_ruby][:bundler] = true
default[:dployco][:deploy_ruby][:bundle_command] = "/usr/local/bin/bundle"
default[:dployco][:deploy_ruby][:bundler_deployment] = true
default[:dployco][:deploy_ruby][:bundler_without_groups] = []
