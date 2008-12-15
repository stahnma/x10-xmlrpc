#!/usr/bin/env ruby
#
# The ON cgi page

#puts ENV['REQUEST_URI']
require 'xmlrpc/client'


print "Content-Type: text/html\r\n"
print "\r\n"

url="http://mythtv.stahnkage.com:8080"
#ENV['REQUEST_URI']  = '/x10/A1/on.rb'
action, address = ""
if ENV['REQUEST_URI']
  address = ENV['REQUEST_URI'].to_s.split('/')[2]
  action =  ENV['REQUEST_URI'].to_s.split('/')[3]
else
  raise "Cannot continue. No requested URI found."
end

if action =~ /on/i 
  action = 'on'.to_s
elsif action =~ /off/i
  action = 'off'.to_s
end

puts '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"> '
puts "<html>"
puts '<head>'
puts "<title>Light #{address}  #{action}</title>"
puts '<link rel="apple-touch-icon" href="/x10/' + action + '.png" />'
puts '</head>'
puts XMLRPC::Client.new2(url).call("x10.remote." + action, address )
puts "<body>"
puts "<img src='/x10/#{action}.png' alt='Lights #{action} '>"
puts "</body>"
puts "</html>"
