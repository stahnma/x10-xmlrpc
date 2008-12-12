#!/usr/bin/env ruby
#
require "xmlrpc/server"

x10_controller = 'mythtv.stahnkage.com'
remote_user = 'stahnma'
remote_command = '/usr/local/bin/heyu'
on_command = 'fon'
off_command = 'foff'

#TODO  swap out heyu for another software that has a better license 
#
s = XMLRPC::Server.new(8080) 

s.add_handler("x10.remote.on") do |address|
  command = 'ssh ' + remote_user.to_s + '@' + x10_controller.to_s +  ' "' + remote_command.to_s + ' ' + on_command.to_s + ' ' + address.to_s + '"'
  puts command
  %x(#{command})
end

s.add_handler("x10.remote.off") do |address| 
  command = 'ssh ' + remote_user + '@' + x10_controller +  ' "/usr/local/bin/heyu foff ' + address.to_s + '"'
  %x(#{command})
end

s.set_default_handler do |name, *args|
  raise XMLRPC::FaultException.new(-99, "Method #{name} missing" +
                                   " or wrong number of parameters!")
end

s.serve
