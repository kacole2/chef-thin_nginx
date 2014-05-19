thin_nginx Cookbook
===================
A super simple Thin and Nginx web and application service. <br>
Why? I found opscode's nginx cookbook with passenger had some quirks. Thin is lightweight and faster than Passenger for simple web apps. I've always had great success running [thin](http://code.macournoyer.com/thin/) with
[nginx](http://nginx.org/), so I figure someone else would want this too. This solution is super simple and doesn't require a lot of confusing parameters. 

Requirements
------------
#### cookbooks
- `rvm` - Sorry. but [rvm](https://github.com/fnichol/chef-rvm) is required because rvm_shell is needed to install Thin from gem

#### gems
- `thin -v 1.6.1` - thin's version 1.6.1 is installed into your current rvm gemset. Solution didn't work correctly when installed to chef's embedded ruby. I haven't had the 
time to experiment installing thin directly from source. That would remove the constraint of RVM, but time wasn't on my side.

#### packages
- `nginx` - nginx is installed from apt package. This does not use the nginx cookbook from opscode.

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
    <td>you <b>must</b> set your application name here. this is typically the folder name used when cloning a git repository such as /var/www/`jumpsquares`.</td>
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
  <tr>
    <td><tt>['thin_nginx']['gemset']</tt></td>
    <td>String</td>
    <td>What gemset should we use? By default none is used so lets keep it that way.</td>
    <td><tt>"default"</tt></td>
  </tr>
</table>

Usage
-----
#### thin_nginx::default
I haven't been able to successfully `override` an attribute with this cookbook from a different cookbook. Change the key attributes above to have this cookbook work successfully.

Before running this cookbook include the following: <br>
1. `rvm::system` - recipe will install ruby across the entire node. Everything works successfully with `ruby-2.1.2`. <br>
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
I am not a software developer by nature. Just a hack. Please contribute to make this better.
<br>
1. Fork the repository on Github<br>
2. Create a named feature branch (like `add_component_x`)<br>
3. Write your change<br>
4. Write tests for your change (if applicable)<br>
5. Run the tests, ensuring they all pass<br>
6. Submit a Pull Request using Github<br>

License and Authors
-------------------
Authors: <a href="http://www.kendrickcoleman.com">Kendrick Coleman</a> | <a href="http://twitter.com/KendrickColeman">@KendrickColeman</a>

Licensed under Apache 2.0