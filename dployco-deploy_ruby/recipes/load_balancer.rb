#
# Cookbook Name:: shipit
# Recipe:: load_balancer
#
# Copyright 2013, Devops Israel
#
# All rights reserved - Do Not Redistribute
#

if node[:shipit][:app][:name].split(" ").count > 1
  Chef::Application.fatal!("Application name must be one word long !")
end

application node[:shipit][:app][:name] do 
  nginx_load_balancer do
    #### defaults ###
    template            node[:shipit][:nginx][:template]
    server_name         node[:shipit][:nginx][:server_name]
    port                node[:shipit][:nginx][:port]
    application_port    node[:shipit][:nginx][:application_port]
    static_files        node[:shipit][:nginx][:static_files]   # eg. { "/img" => "images" }
    ssl                 node[:shipit][:nginx][:ssl]
    ssl_certificate     node[:shipit][:nginx][:ssl_certificate]
    ssl_certificate_key node[:shipit][:nginx][:ssl_certificate_key]
    #only_if             node['roles'].include?('nginx_load_balancer')
  end
  
  #passenger_apache2 do
    # Passenger-specific configuration.
  #end
end

