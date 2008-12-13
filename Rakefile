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
  output.close
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
  output.close
  puts "Creating #{tp}.rb"
  sh "sudo chown apache:apache #{tp}.rb"
end

task :clean do
  puts "rm -f off.rb on.rb nohup.out"
  sh   "rm -f off.rb on.rb nohup.out" 
end


task :install => [ :generate ] do
  basedir = "/usr/share/x10-xmlrpc"
  installdir = "" 
  if ENV['DESTDIR'] 
    installdir = ""  + ENV['DESTDIR']
  end 

  puts "Preparing for installation."
  puts "Creating Directories"
 
  # /usr/share/x10-xmlrpc
  puts "mkdir -p #{installdir}#{basedir}"
  sh "mkdir -p #{installdir}#{basedir}"
 
  # /etc/httpd/conf.d
  puts "mkdir -p #{installdir}/etc/httpd/conf.d"
  sh "mkdir -p #{installdir}/etc/httpd/conf.d"
  
  puts "Installing Files" 

  # install x10.conf for Apache 
  puts "install -p -m644 -o root -g root x10.conf #{installdir}/etc/httpd/conf.d"
  sh   "install -p -m644 -o root -g root x10.conf #{installdir}/etc/httpd/conf.d"
  
  # install images 
  puts "install -p -m644 -o root -g root *.png #{installdir}#{basedir}"
  sh   "install -p -m644 -o root -g root *.png #{installdir}#{basedir}"

  # install daemon
  puts "install -p -m755 -o root -g root x10-xmlrpcd.rb #{installdir}#{basedir}/x10-xmlrpcd"
  sh   "install -p -m755 -o root -g root x10-xmlrpcd.rb #{installdir}#{basedir}/x10-xmlrpcd"

  # install x10-xmlrpcd.init into /etc/init.d
  puts "install -p -m755 -o root -g root x10-xmlrpcd.init #{installdir}/etc/init.d/x10-xmlrpcd"
  sh   "install -p -m755 -o root -g root x10-xmlrpcd.init #{installdir}/etc/init.d/x10-xmlrpcd"

  # install the /sbin shell script
  puts "install -p -m755 -o root -g root x10-xmlrpcd.sh #{installdir}/sbin/x10-xmlrpcd"
  sh   "install -p -m755 -o root -g root x10-xmlrpcd.sh #{installdir}/sbin/x10-xmlrpcd"

  # install the generated files
  puts "install -p -m755 -o root -g root on.rb #{installdir}#{basedir}"
  sh   "install -p -m755 -o root -g root on.rb #{installdir}#{basedir}"
  puts "install -p -m755 -o root -g root off.rb #{installdir}#{basedir}"
  sh   "install -p -m755 -o root -g root off.rb #{installdir}#{basedir}"

  # Restart Apache
  puts "/sbin/service httpd restart"
  sh "/sbin/service httpd restart"
end


