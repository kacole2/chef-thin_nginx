#
# Cookbook Name:: thin_nginx
# Attributes:: source
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

#localization parameters
default['thin_nginx']['app_name'] = "jumpsquares"
default['thin_nginx']['www_dir']  = "/var/www/"
default['thin_nginx']['application_dir']  = "#{node['thin_nginx']['www_dir']}#{node['thin_nginx']['app_name']}"

#user that owns www directory
default['thin_nginx']['user'] = 'www-data'

#thin parameters
default['thin_nginx']['thin_version'] = "1.6.1"
default['thin_nginx']['number_of_thins'] = 3
default['thin_nginx']['worker_processes'] = 5
default['thin_nginx']['rails_env'] = "appliance-production"

#ruby parameters. Sorry RVM is the only way I could get this to work
default['thin_nginx']['ruby_version'] = "ruby-2.1.2"
default['thin_nginx']['ruby_path'] = "/usr/local/rvm"
default['thin_nginx']['rvm_source'] = "/usr/local/rvm/scripts/rvm"

#ruby environment parameters
default['thin_nginx']['rvm_path'] = "#{node['thin_nginx']['ruby_path']}/gems/#{node['thin_nginx']['ruby_version']}/bin:#{node['thin_nginx']['ruby_path']}/gems/#{node['thin_nginx']['ruby_version']}@global/bin:#{node['thin_nginx']['ruby_path']}/rubies/#{node['thin_nginx']['ruby_version']}/bin"
default['thin_nginx']['ruby'] = "#{node['thin_nginx']['ruby_path']}/wrappers/#{node['thin_nginx']['ruby_version']}/ruby"
default['thin_nginx']['gem_binary'] = "#{node['thin_nginx']['ruby_path']}/wrappers/#{node['thin_nginx']['ruby_version']}/gem"

