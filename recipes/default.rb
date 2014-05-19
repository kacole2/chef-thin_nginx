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

#this RVM shell will download the thin gem to your local RVM gemset
#then we will install the gem and create a configuration file
#the wrapper must be created to allow thin to boot at start
rvm_shell "install thin" do
  ruby_string "#{node['thin_nginx']['ruby_version']}"
  code %{
       source #{node['thin_nginx']['rvm_source']}
       gem install thin -v #{node['thin_nginx']['thin_version']}
       rvmsudo thin install
       /usr/sbin/update-rc.d -f thin defaults
       rvmsudo thin config -C /etc/thin/#{node['thin_nginx']['app_name']} -c #{node['thin_nginx']['application_dir']} --servers #{node['thin_nginx']['number_of_thins']} -e #{node['thin_nginx']['rails_env']}
       rvmsudo rvm wrapper #{node['thin_nginx']['ruby_version']} bootup thin
       }
end
#we are changing the bootup environment to use our new wrapper
ruby_block "changing startup DAEMON for thin" do
original_line = "DAEMON=#{node['thin_nginx']['ruby_path']}/gems/#{node['thin_nginx']['ruby_version']}/bin/thin"
  block do
    daemon_file = Chef::Util::FileEdit.new("/etc/init.d/thin")
    daemon_file.search_file_replace_line(/#{original_line}/, "DAEMON=#{node['thin_nginx']['ruby_path']}/bin/bootup_thin")  
    daemon_file.write_file
  end
end
#install nginx from package
apt_package "nginx" do
  action :install
end
#make necessary changes to our nginx.conf file
template '/etc/nginx/nginx.conf' do
  path   "/etc/nginx/nginx.conf"
  source 'nginx.conf.erb'
  owner  'root'
  group  'root'
  mode   0644
  action :create
end
#make changes to our default site file
template "/etc/nginx/sites-available/#{node['thin_nginx']['app_name']}" do
  path   "/etc/nginx/sites-available/#{node['thin_nginx']['app_name']}"
  source 'default0.erb'
  owner  'root'
  group  'root'
  mode   0644
  action :create
end
#create a symbolic link between two folder
execute "link thin" do
  command "ln -nfs /etc/nginx/sites-available/#{node['thin_nginx']['app_name']} /etc/nginx/sites-enabled/#{node['thin_nginx']['app_name']}"
end
#lets start the nginx service and give it some abilities to etc/init.d
service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
#this will start our webserver for first time use!
rvm_shell "start the webserver" do
  ruby_string "#{node['thin_nginx']['ruby_version']}"
  code %{
       rvmsudo /etc/init.d/thin start
       rvmsudo /etc/init.d/nginx reload
       rvmsudo /etc/init.d/nginx restart
           }
end
