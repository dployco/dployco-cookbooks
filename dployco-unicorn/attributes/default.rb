default[:dployco][:unicorn][:appname] = 'appname' #relative to /etc/unicorn/
default[:dployco][:unicorn][:environment] = 'production'
default[:dployco][:unicorn][:application_deploy_path] = "/var/www/projects/#{node[:dployco][:unicorn][:appname]}"
default[:dployco][:unicorn][:worker_timeout] = 60
default[:dployco][:unicorn][:preload_app] = false
default[:dployco][:unicorn][:worker_processes] = [node[:cpu][:total].to_i * 4, 8].min
default[:dployco][:unicorn][:preload_app] = false
default[:dployco][:unicorn][:before_fork] = 'sleep 1'
default[:dployco][:unicorn][:port] = '8888'
default[:dployco][:unicorn][:options] = {} #{ :tcp_nodelay => true, :backlog => 100 }
default[:dployco][:unicorn][:owner] = 'root'
default[:dployco][:unicorn][:group] = 'root'
default[:dployco][:unicorn][:bundler] = false
default[:dployco][:unicorn][:bundle_command] = '/usr/local/bin/bundle'
default[:dployco][:unicorn][:uninstall] = false
default[:dployco][:unicorn][:rbfile] = nil #relative to (project_root)/config