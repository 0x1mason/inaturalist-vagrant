def customize_vm(vm, options = {})
  if options[:ram]
    vm.customize [ "modifyvm", :id, "--memory", options[:ram] ]
  end
  if options[:cpus]
    vm.customize [ "modifyvm", :id, "--cpus", options[:cpus] ]
  end
  if options[:name]
    vm.name = options[:name]
  end
end

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

# there are multiple VMs that could be built, and one should never build
# more than one at a time. Vagrant will allow you to do that, but this
# block of code will prevent users from provisioning more than one at a time
def check_command_and_server(args, servers, server_requested)
  server_commands = [ 'destroy', 'halt', 'provision', 'rdp', 'reload', 'resume',
                      'ssh', 'ssh-config', 'suspend', 'up' ]
  if args[0] && server_commands.include?(args[0])
    if ! args[1]
      puts colorize("You must specify a machine name", 31)
      puts colorize("Choose one of:", 31)
      servers.each{ |s| puts colorize("    #{ s[:name] }", 31) }
      abort
    end
  end
end

def deep_merge_hashes(one_hash, other_hash)
  one_hash.merge(other_hash) do |key, oldval, newval|
    oldval = oldval.to_hash if oldval.respond_to?(:to_hash)
    newval = newval.to_hash if newval.respond_to?(:to_hash)
    oldval.class.to_s == 'Hash' && newval.class.to_s == 'Hash' ? deep_merge_hashes(oldval,newval) : newval
  end
end