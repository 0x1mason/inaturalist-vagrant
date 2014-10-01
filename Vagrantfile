# -*- mode: ruby -*-
# vi: set ft=ruby :

run_list = [ ]

Vagrant.configure("2") do |c|
  c.omnibus.chef_version = :latest
  c.vm.box = "opscode-ubuntu-14.04"
  c.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"

  c.vm.define "app" do |s|
    s.vm.hostname = "inaturalist-app"
    s.vm.network "private_network", ip: "192.168.50.4"
    s.vm.provider :virtualbox do |p|
      p.customize [ "modifyvm", :id, "--memory", "1024" ]
      p.customize [ "modifyvm", :id, "--cpus", "1" ]
      p.name = "inaturalist-app"
    end
    run_list << "recipe[inaturalist-cookbook]"
    run_list << "recipe[inaturalist-cookbook::development]"
    run_list << "recipe[inaturalist-cookbook::_development_config]"
  end

  c.vm.define "app2" do |s|
    s.vm.hostname = "inaturalist-app2"
    s.vm.network "private_network", ip: "192.168.50.5"
    s.vm.provider :virtualbox do |p|
      p.customize [ "modifyvm", :id, "--memory", "1024" ]
      p.customize [ "modifyvm", :id, "--cpus", "1" ]
      p.name = "inaturalist-app2"
    end
    run_list << "recipe[inaturalist-cookbook]"
    run_list << "recipe[inaturalist-cookbook::development]"
    run_list << "recipe[inaturalist-cookbook::_development_config]"
  end

  c.vm.define "windshaft" do |s|
    s.vm.hostname = "inaturalist-windshaft"
    s.vm.network "private_network", ip: "192.168.50.6"
    s.vm.provider :virtualbox do |p|
      p.customize [ "modifyvm", :id, "--memory", "1024" ]
      p.customize [ "modifyvm", :id, "--cpus", "1" ]
      p.name = "inaturalist-windshaft"
    end
    run_list << "recipe[inaturalist-cookbook]"
    run_list << "recipe[inaturalist-cookbook::varnish]"
  end

  c.vm.provision :chef_solo do |chef|
    chef.json = {
      postgresql: {
        password: {
          postgres: "vagrantpostgrespw"
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
          users: [ "vagrant" ],
          passwordless: true
        }
      },
      varnish: {
        listen_port: 80,
        vcl_cookbook: "inaturalist-cookbook",
        vcl_source: "vagrant_default.vcl.erb"
      }
    }

    # You can uncomment and modify these values to point to your
    # local PostgreSQL database with the full iNaturalist dataset
    # chef.json[:inaturalist] = {
    #   postgres_host: "HOST",
    #   postgres_user: "USER",
    #   postgres_database: "DATABASE",
    #   postgres_port: 5432,
    #   postgres_debug: true/false
    # }

    chef.run_list = run_list
  end
end
