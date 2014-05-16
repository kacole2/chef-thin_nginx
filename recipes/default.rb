# Author: Kendrick Coleman (kendrickcoleman@gmail.com)
# Cookbook Name:: thin_nginx
# Recipe:: default
#
# Copyright 2014, KendrickColeman.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

rvm_shell "install thin" do
  ruby_string "#{node['thin_nginx']['ruby_version']}"
  code %{
       source #{node['thin_nginx']['rvm_source']}
       gem install thin -v #{node['thin_nginx']['thin_version']}
       rvmsudo thin install
       /usr/sbin/update-rc.d -f thin defaults
       thin config -C /etc/thin/#{node['thin_nginx']['app_name']} -c #{node['thin_nginx']['application_dir']} --servers #{node['thin_nginx']['number_of_thins']} -e #{node['thin_nginx']['rails_env']}
       }
end

apt_package "nginx" do
  action :install
end

template '/etc/nginx/nginx.conf' do
  path   "/etc/nginx/nginx.conf"
  source 'nginx.conf.erb'
  owner  'root'
  group  'root'
  mode   0644
  action :create
end

template "/etc/nginx/sites-available/#{node['thin_nginx']['app_name']}" do
  path   "/etc/nginx/sites-available/#{node['thin_nginx']['app_name']}"
  source 'default0.erb'
  owner  'root'
  group  'root'
  mode   0644
  action :create
end

execute "link thin" do
  command "ln -nfs /etc/nginx/sites-available/#{node['thin_nginx']['app_name']} /etc/nginx/sites-enabled/#{node['thin_nginx']['app_name']}"
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

rvm_shell "install thin" do
  ruby_string "#{node['thin_nginx']['ruby_version']}"
  code %{
       rvmsudo /etc/init.d/thin start
       rvmsudo /etc/init.d/nginx reload
       rvmsudo /etc/init.d/nginx restart
           }
end
