#!/usr/bin/env ruby

require 'erb'
task :default => :generate 

task :generate => [ :generate_on, :generate_off ] 

task :generate_on do
  fh = File.new( "template.erb" )
  eruby_script = fh.read
  tp = 'on'
  tpc = tp.upcase
  erb = ERB.new(eruby_script)
  output = File.new("on.rb", 'w')
  output.puts erb.result(binding)
  output.chmod 0755 
  output.chown(48,  48 ) 
end

task :generate_off do
  fh = File.new( "template.erb" )
  eruby_script = fh.read
  tp = 'off'
  tpc = tp.upcase
  erb = ERB.new(eruby_script)
  output = File.new("off.rb", 'w')
  output.puts erb.result(binding)
  output.chmod 0755 
  output.chown(48,  48 ) 
end


