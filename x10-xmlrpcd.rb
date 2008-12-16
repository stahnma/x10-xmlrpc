#!/usr/bin/env ruby

# BSD License
# Copyright 2008 Michael Stahnke and Stahnkage.com

require "webrick"
require "xmlrpc/server"

bind_to='192.168.1.104'

#TODO  swap out heyu for another software that has a better license 
x10_command = '/usr/local/bin/heyu'
on_command = 'fon'
off_command = 'foff'

s = XMLRPC::WEBrickServlet.new

s.add_handler("x10.remote.on") do |address|
  command = x10_command + ' ' + on_command + ' ' + address.to_s
  %x(#{command})
end

s.add_handler("x10.remote.off") do |address| 
  command = x10_command + ' ' + off_command + ' ' + address.to_s
  %x(#{command})
end

s.set_default_handler do |name, *args|
  raise XMLRPC::FaultException.new(-99, "Method #{name} missing" +
                                   " or wrong number of parameters!")
end

xmlrpcserver = WEBrick::HTTPServer.new(:Port=>8080, :Host=>bind_to)
xmlrpcserver.mount("/", s)
trap("INT") { xmlrpcserver.shutdown()}
xmlrpcserver.start
