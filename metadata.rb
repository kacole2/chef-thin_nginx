name             'thin_nginx'
maintainer       'Kendrick Coleman'
maintainer_email 'kendrickcoleman@gmail.com'
license          'Apache 2.0'
description      'Installs and configures thin web server and nginx application server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

recipe "thin_nginx", "It might be ugly, but it works. Installs the thin gem via rvm and nginx via package"

depends "rvm"

supports "ubuntu"
supports "debian"