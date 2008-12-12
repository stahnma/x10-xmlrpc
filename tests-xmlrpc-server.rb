#!/usr/bin/env ruby
#
#
#
#Test Cases
#  x10.remote.on with a valid argument
#  an invalid argument
#  too many arguments
#  too few arguments
#  
#  Invalid method name
#


require 'xmlrpc/client'
#require 'test/unit'

#class XMLRPC_test < Test::Unit::TestCase
#  @url="http://localhost:8080"
 
  
#   def test_fail
#       assert(false, 'Assertion was false.')
#   end
#end


url="http://localhost:8080"

puts XMLRPC::Client.new2(url).call("x10.remote.off", 'A1' )
puts XMLRPC::Client.new2(url).call("x10.remote.on", 'A1' )


