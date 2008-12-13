#!/usr/bin/env ruby

# BSD License
# Copyright 2008 Michael Stahnke and Stahnkage.com

require "xmlrpc/server"

x10_controller = 'mythtv.stahnkage.com'
remote_user = 'stahnma'
#TODO  swap out heyu for another software that has a better license 
remote_command = '/usr/local/bin/heyu'
on_command = 'fon'
off_command = 'foff'


# Ensure that one can ssh from this host and to 
#  the x10_controller as the remote_user
#
# See if this works
command = "ssh -l #{remote_user} #{x10_controller} /bin/true &> /dev/null"
system(command)
if $? != 0
   raise "Problem with connecting to #{x10_controller} as #{remote_user}...aborting"
end

s = XMLRPC::Server.new(8080) 

s.add_handler("x10.remote.on") do |address|
  command = 'ssh ' + remote_user.to_s + '@' + x10_controller.to_s +  ' "' + remote_command.to_s + ' ' + on_command.to_s + ' ' + address.to_s + '"'
  %x(#{command})
end

s.add_handler("x10.remote.off") do |address| 
  command = 'ssh ' + remote_user.to_s + '@' + x10_controller.to_s +  ' "' + remote_command.to_s + ' ' + off_command.to_s + ' ' + address.to_s + '"'
  %x(#{command})
end

s.set_default_handler do |name, *args|
  raise XMLRPC::FaultException.new(-99, "Method #{name} missing" +
                                   " or wrong number of parameters!")
end

s.serve
