default[:dployco][:nginx][:application_name] = 'app_name'
default[:dployco][:nginx][:application_ip_port] = ['127.0.0.1:8000']
default[:dployco][:nginx][:application_socket] = ''
default[:dployco][:nginx][:fail_timeout] = 0
default[:dployco][:nginx][:max_fails] = 3
default[:dployco][:nginx][:ssl] = false
default[:dployco][:nginx][:ssl_certificate] = "#{node['fqdn']}.crt"
default[:dployco][:nginx][:ssl_certificate_key] = "#{node['fqdn']}.key"
default[:dployco][:nginx][:listen_port] = 80
default[:dployco][:nginx][:server_name] = node['fqdn']
default[:dployco][:nginx][:ssl] = false
default[:dployco][:nginx][:static_files] = {}
default[:dployco][:nginx][:extra_options] = {}
default[:dployco][:nginx][:enable_site] = true
override[:nginx][:default_site_enabled] = false

#default[:dployco][:nginx][:user] = node[:nginx][:user]
#default[:dployco][:nginx][:group] = node[:nginx][:group]
