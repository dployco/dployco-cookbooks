

if node[:dployco][:nginx][:application_name].split(" ").count > 1
  Chef::Application.fatal!("Application name must be one word long !")
end

case node['platform']
  when "debian","ubuntu"
    include_recipe "apt"  
end
include_recipe "nginx"



template "#{node[:nginx][:dir]}/sites-available/#{node[:dployco][:nginx][:application_name]}" do
  source "vhost.erb"
  owner "root"
  group "root"
  mode 00644
  notifies :reload, 'service[nginx]'
  variables({
    :application_name    => node[:dployco][:nginx][:application_name],
    :application_socket  => node[:dployco][:nginx][:application_socket],
    :fail_timeout        => node[:dployco][:nginx][:fail_timeout],
    :max_fails           => node[:dployco][:nginx][:max_fails],
    :application_ip_port => node[:dployco][:nginx][:application_ip_port],
    :ssl                 => node[:dployco][:nginx][:ssl],
    :ssl_certificate     => node[:dployco][:nginx][:ssl_certificate],
    :ssl_certificate_key => node[:dployco][:nginx][:ssl_certificate_key],
    :listen_port         => node[:dployco][:nginx][:listen_port],
    :server_name         => node[:dployco][:nginx][:server_name],
    :static_files        => node[:dployco][:nginx][:static_files],
    :extra_options       => node[:dployco][:nginx][:extra_options]
  })
  #not_if { File.exists? "#{node[:nginx][:dir]}/sites-available/#{node[:dployco][:nginx][:application_name]}" }
end

nginx_site node[:dployco][:nginx][:application_name] do
  enable node[:dployco][:nginx][:enable_site]
end