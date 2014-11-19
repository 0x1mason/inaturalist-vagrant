iNaturalist Vagrant
-------------------
Included is a [Vagrantfile](https://www.vagrantup.com/) that describes how to create a Ubuntu VM using [VirtualBox](https://www.virtualbox.org/) and bootstrapped using [Chef](https://www.getchef.com/chef/). This VM should have everything needed to write software for the [iNaturalist Ruby on Rails codebase](https://github.com/inaturalist/inaturalist).

Installation
------------
####Prerequisites
* [Ruby](https://www.ruby-lang.org/en/downloads/)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads/)
* [Vagrant](https://www.vagrantup.com/downloads.html/)
* [vagrant-omnibus plugin](https://github.com/opscode/vagrant-omnibus) , installed with `vagrant plugin install vagrant-omnibus`

####On your local machine

```
git clone git@github.com:pleary/inaturalist-vagrant.git
cd inaturalist-vagrant
bundle
librarian-chef install
```

####You must first create a database VM:

```
vagrant up db
```

This can take 3-10 minutes.

If you have a copy of the production database, you can place it in the root of this directory (at the same level as this README) and name it `inaturalist_production.csql` . If that file exists, when you `vagrant up db` then a new database named inaturalist_production will be created and that dump imported. This can take an hour or longer. Also note, this VM is defined as being allowed 4GB RAM by default in order for it to complete this import.

####To create a development Rails environment:

```
vagrant up app
```

This can can take 15-20 minutes. You can then log into the new machine and run the specs:

```
vagrant ssh app
cd /vagrant/shared/rails/inaturalist
rspec
```

####To create a development windshaft server:

```
vagrant up windshaft
```

This can take 10-15 minutes. You can then log into the new machine and start the windshaft application:

```
vagrant ssh windshaft
cd /vagrant/shared/nodejs/windshaft
node app.js
```

Confirm this is working by loading this URL: http://192.168.50.6:4000/observations/points/10/236/422.png . You should see a tile image with black dots at
