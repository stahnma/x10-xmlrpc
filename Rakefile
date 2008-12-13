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
  puts "Creating #{tp}.rb"
  sh "sudo chown apache:apache #{tp}.rb"
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
  puts "Creating #{tp}.rb"
  sh "sudo chown apache:apache #{tp}.rb"
end

task :clean do
  puts "rm -f off.rb on.rb"
  sh "rm -f off.rb on.rb" 
end


task :install => :generate do
  installdir = "" 
  if ENV['DESTDIR'] 
    installdir = ""  + ENV['DESTDIR']
  end 
  puts "Preparing for installation."
  puts "mkdir -p #{installdir}/var/www/html/x10"
  sh "mkdir -p #{installdir}/var/www/html/x10"
  puts "mkdir -p #{installdir}/etc/httpd/conf.d"
  sh "mkdir -p #{installdir}/etc/httpd/conf.d"
  puts "cp -f x10.conf #{installdir}/etc/httpd/conf.d"
  sh "cp -f x10.conf #{installdir}/etc/httpd/conf.d"
  puts "/sbin/service httpd restart"
  sh "/sbin/service httpd restart"
end


