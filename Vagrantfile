# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |c|
  c.omnibus.chef_version = :latest
  c.vm.box = "opscode-ubuntu-14.04"
  c.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"
  c.vm.hostname = "inaturalist-vagrant"
  c.vm.network "private_network", ip: "192.168.50.4"

  c.vm.provider :virtualbox do |p|
    p.customize [ "modifyvm", :id, "--memory", "1024" ]
    p.customize [ "modifyvm", :id, "--cpus", "2" ]
    p.name = "inaturalist-vagrant"
  end

  c.vm.provision :chef_solo do |chef|
    chef.json = {
      postgresql: {
        password: {
          postgres: "0928743rwhf0834fh"
        }
      },
      rvm: {
        user_installs: [ {
          user: "vagrant",
          rubies: [ "ruby-1.9.3" ],
          default_ruby: "ruby-1.9.3",
          vagrant: {
            system_chef_solo: "/usr/bin/chef-solo"
          }
        } ]
      },
      authorization: {
        sudo: {
          users: [ 'vagrant' ],
          passwordless: true
        }
      }
    }

    chef.add_recipe "inaturalist-cookbook::development"
    chef.add_recipe "inaturalist-cookbook::_development_config"
  end
end
