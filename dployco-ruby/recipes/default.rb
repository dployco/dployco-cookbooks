#
# Cookbook Name:: dployco-ruby
# Recipe:: default
#
# Copyright 2013, dploy.co
#
# All rights reserved - Do Not Redistribute
#

case node['dployco']['ruby']['version']
when '1.8', '1.8.7'
  pkgver = "1.8"
when '1.9', '1.9.1', '1.9.3'
  pkgver = "1.9.1"
end

%W| ruby#{pkgver} ruby#{pkgver}-dev libruby#{pkgver} irb#{pkgver} libopenssl-ruby#{pkgver} |.each do |pkg_name|
  package pkg_name
end
