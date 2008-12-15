#!/usr/bin/env ruby

#require 'erb'

remote_host='mythtv.stahnkage.com'
basedir = "/usr/share/x10-xmlrpc"

task :default => :install

task :clean do
#  puts "rm -f off.rb on.rb nohup.out"
#  sh   "rm -f off.rb on.rb nohup.out" 
  sh "clear"
end


task :install   do
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

  # install the controller file
  puts "install -p -m755 -o root -g root x10-controller.rb #{installdir}#{basedir}"
  sh   "install -p -m755 -o root -g root x10-controller.rb #{installdir}#{basedir}"

  # Restart Apache
  puts "/sbin/service httpd restart"
  sh "/sbin/service httpd restart"
end

task :uninstall do
  puts "rm -rf #{basedir}"
  sh   "rm -rf #{basedir}"
  puts "rm -f  /etc/httpd/conf.d/x10.conf"
  sh   "rm -f  /etc/httpd/conf.d/x10.conf"
end


task :server do
  # install x10-xmlrpcd.init into /etc/init.d
#  puts "install -p -m755 -o root -g root x10-xmlrpcd.init #{installdir}/etc/init.d/x10-xmlrpcd"
#  sh   "install -p -m755 -o root -g root x10-xmlrpcd.init #{installdir}/etc/init.d/x10-xmlrpcd"

  # install the /sbin shell script
#  puts "install -p -m755 -o root -g root x10-xmlrpcd.sh #{installdir}/sbin/x10-xmlrpcd"
#  sh   "install -p -m755 -o root -g root x10-xmlrpcd.sh #{installdir}/sbin/x10-xmlrpcd"

  # install daemon
  puts "install -p -m755 -o root -g root x10-xmlrpcd.rb #{installdir}#{basedir}/x10-xmlrpcd"
  sh   "install -p -m755 -o root -g root x10-xmlrpcd.rb #{installdir}#{basedir}/x10-xmlrpcd"
end
