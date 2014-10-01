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
git clone git@github.com:pleary/inaturalist-vagrant.git
cd inaturalist-vagrant
bundle
librarian-chef install
```

####To create a development Rails environment:
```
vagrant up app
vagrant ssh app
```

...and then on the new machine:
```
cd rails/inaturalist
bundle
rake db:setup
rake db:setup RAILS_ENV=test
rspec
```

####To create a development windshaft server:
```
vagrant up windshaft
vagrant ssh windshaft
```

...and then on the new machine:
```
cd windshaft
node app.js
```

You should see a tile image with black dots at http://192.168.50.6/observations/points/10/236/422.png
