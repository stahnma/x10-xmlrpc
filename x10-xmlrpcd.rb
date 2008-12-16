#!/usr/bin/env ruby

# BSD License
# Copyright 2008 Michael Stahnke and Stahnkage.com

require "xmlrpc/server"

x10_controller = 'mythtv.stahnkage.com'
remote_user = 'stahnma'
ssh_key = '/home/stahnma/.ssh/id_dsa'
#TODO  swap out heyu for another software that has a better license 
remote_command = '/usr/local/bin/heyu'
on_command = 'fon'
off_command = 'foff'


s = XMLRPC::Server.new(port=8080, host='192.168.1.104') 

s.add_handler("x10.remote.on") do |address|
  command = '/usr/local/bin/heyu fon ' + address.to_s
  #puts command
  %x(#{command})
end

s.add_handler("x10.remote.off") do |address| 
  command = '/usr/local/bin/heyu foff ' + address.to_s
  #puts command
  %x(#{command})
end

s.set_default_handler do |name, *args|
  raise XMLRPC::FaultException.new(-99, "Method #{name} missing" +
                                   " or wrong number of parameters!")
end

s.serve
