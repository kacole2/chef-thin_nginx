thin_nginx Cookbook
===================
A super simple Thin and Nginx web and application service. <br>
Why? I found opscode's nginx cookbook with passenger didn't work well. I found many people, as well as myself, getting 403 Forbidden errors with
nginx using Rails 4. I've always had great success running [thin](http://code.macournoyer.com/thin/) with
[nginx](http://nginx.org/). This solution is super simple and doesn't require a lot of parameters. 

Requirements
------------
#### cookbooks
- `rvm` - Sorry. but [rvm](https://github.com/fnichol/chef-rvm) is required because rvm_shell is needed to install Thin

#### gems
- `thin` - thin `version 1.6.1` is installed into your current rvm gemset. Solution didn't work correctly when installed to chef's embedded ruby

#### packages
- `nginx` - nginx is installed from package

#### supported OS
Only tested on Ubuntu 12.04.3

Attributes
----------
#### thin_nginx::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['thin_nginx']['app_name']</tt></td>
    <td>String</td>
    <td>you must set your application name here. this is typically the folder name used when cloning a git repository such as /var/www/`jumpsquares`.</td>
    <td><tt>"jumpsquares"</tt></td>
  </tr>
  <tr>
    <td><tt>['thin_nginx']['www_dir']</tt></td>
    <td>String</td>
    <td>this is your directory used for serving up www. usually at /var/www</td>
    <td><tt>"/var/www/"</tt></td>
  </tr>
  <tr>
    <td><tt>['thin_nginx']['user']</tt></td>
    <td>String</td>
    <td>user that can access www files. usually www-data on Ubuntu/Debian</td>
    <td><tt>"www-data"</tt></td>
  </tr>
  <tr>
    <td><tt>['thin_nginx']['thin_version']</tt></td>
    <td>String</td>
    <td>version of thin to run. Currently tested against 1.6.1</td>
    <td><tt>"1.6.1"</tt></td>
  </tr>
  <tr>
    <td><tt>['thin_nginx']['number_of_thins']</tt></td>
    <td>Integer</td>
    <td>number of thin servers that should run. each server comes up with a new sequential port</td>
    <td><tt>3</tt></td>
  </tr>
  <tr>
    <td><tt>['thin_nginx']['worker_processes']</tt></td>
    <td>Integer</td>
    <td>nginx worker processes</td>
    <td><tt>5</tt></td>
  </tr>
  <tr>
    <td><tt>['thin_nginx']['rails_env']</tt></td>
    <td>String</td>
    <td>Rails environment used for the thin server</td>
    <td><tt>"production"</tt></td>
  </tr>
  <tr>
    <td><tt>['thin_nginx']['ruby_version']</tt></td>
    <td>String</td>
    <td>Ruby version install for rvm_shell</td>
    <td><tt>"ruby-2.1.2"</tt></td>
  </tr>
  <tr>
    <td><tt>['thin_nginx']['ruby_path']</tt></td>
    <td>String</td>
    <td>Ruby path for rvm</td>
    <td><tt>"/usr/local/rvm"</tt></td>
  </tr>
  <tr>
    <td><tt>['thin_nginx']['ruby_source']</tt></td>
    <td>String</td>
    <td>Ruby source path for initiating console</td>
    <td><tt>"/usr/local/rvm/scripts/rvm"</tt></td>
  </tr>
</table>

Usage
-----
#### thin_nginx::default
I haven't been able to successfully `override` an attribute with this cookbook. Make sure to change the key attributes above to have this cookbook work successfully.

Before use:
1. `rvm::system` - use this recipe to install ruby across the entire node. Everything works successfully with `ruby-2.1.2`. <br>
2. your application - run `git clone` on a git repository to the `/var/www/` directory
 
Include `thin_nginx` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[thin_nginx]"
  ]
}
```

Contributing
------------
I am not a software developer. Just a hack. Please contribute to make this better.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: <a href="http://www.kendrickcoleman.com">Kendrick Coleman</a> | <a href="http://twitter.com/KendrickColeman">@KendrickColeman</a>

Licensed under Apache 2.0