# -*- mode: ruby -*-
# vi: set ft=ruby :
require "./shared_methods.rb"
require "pp"

default_run_list = [ "role[base]" ]
servers = JSON.parse( IO.read("servers.json"), symbolize_names: true ).sort_by{ |s| s[:name] }
server_requested = servers.detect{ |s| s[:name] == ARGV[1] }

# this will abort of a server needs to be requested and wasn't
check_command_and_server(ARGV, servers, server_requested)

Vagrant.configure("2") do |c|
  c.omnibus.chef_version = :latest
  c.vm.box = "opscode-ubuntu-14.04"
  c.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"

  # find the definition of each server in ./servers.json
  servers.each do |s|
    c.vm.define s[:name] do |m|
      name = "inaturalist-#{ s[:name] }"
      m.vm.hostname = s[:name]
      m.vm.network "private_network", ip: s[:ip]
      m.vm.provider :virtualbox do |p|
        customize_vm(p, ram: s[:ram], cpus: s[:cpus], name: name)
      end
    end
  end

  c.vm.provision :chef_solo do |chef|
    if server_requested && server_requested[:run_list]
      default_run_list += server_requested[:run_list]
    end
    chef.run_list = default_run_list
    chef.data_bags_path = "data_bags"
    chef.roles_path = "roles"
  end
end
