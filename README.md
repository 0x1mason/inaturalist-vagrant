iNaturalist Vagrant
-------------------
Included is a [Vagrantfile](https://www.vagrantup.com/) that describes how to create a Ubuntu VM using [VirtualBox](https://www.virtualbox.org/) and bootstrapped using [Chef](https://www.getchef.com/chef/). This VM should have everything needed to write software for the [iNaturalist Ruby on Rails codebase](https://github.com/inaturalist/inaturalist).


Installation
------------
####Prerequisites
* [Ruby](https://www.ruby-lang.org/en/downloads/)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads/)
* [Vagrant](https://www.vagrantup.com/downloads.html/)

####On your local machine
```
bundle
librarian-chef install
vagrant up
vagrant ssh
```

####On the new VM:
```
cd rails/inaturalist
bundle
rake db:setup
rake db:setup RAILS_ENV=test
rspec
```
