#!/usr/bin/env ruby

# BSD License
# Copyright 2008 Michael Stahnke and Stahnkage.com

require "xmlrpc/server"

#TODO  swap out heyu for another software that has a better license 
x10_command = '/usr/local/bin/heyu'
on_command = 'fon'
off_command = 'foff'


# Ensure that one can ssh from this host and to 
#  the x10_controller as the remote_user
#
#
#
#TODO need a variable to bind to local IP address or something
s = XMLRPC::Server.new(port=8080, host='192.168.1.104') 

s.add_handler("x10.remote.on") do |address|
  command =x10_command + ' ' + on_command + ' ' + address.to_s + '"'
  puts command
  %x(#{command})
end

s.add_handler("x10.remote.off") do |address| 
  command =x10_command + ' ' + off_command + ' ' + address.to_s + '"'
  puts command
  %x(#{command})
end

s.set_default_handler do |name, *args|
  raise XMLRPC::FaultException.new(-99, "Method #{name} missing" +
                                   " or wrong number of parameters!")
end
s.serve
