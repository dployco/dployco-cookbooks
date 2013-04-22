#
# Cookbook Name:: dployco-deploy_ruby
# Recipe:: load_balancer
#
# Copyright 2013, Devops Israel
#
# All rights reserved - Do Not Redistribute
#

if node[:dployco][:app][:name].split(" ").count > 1
  Chef::Application.fatal!("Application name must be one word long !")
end

application node[:dployco][:app][:name] do
  nginx_load_balancer do
    #### defaults ###
    template            node[:dployco][:nginx][:template]
    server_name         node[:dployco][:nginx][:server_name]
    port                node[:dployco][:nginx][:port]
    application_port    node[:dployco][:nginx][:application_port]
    static_files        node[:dployco][:nginx][:static_files]   # eg. { "/img" => "images" }
    ssl                 node[:dployco][:nginx][:ssl]
    ssl_certificate     node[:dployco][:nginx][:ssl_certificate]
    ssl_certificate_key node[:dployco][:nginx][:ssl_certificate_key]
    #only_if             node['roles'].include?('nginx_load_balancer')
  end

  #passenger_apache2 do
    # Passenger-specific configuration.
  #end
end
