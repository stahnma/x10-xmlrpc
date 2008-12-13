#!/bin/bash

DAEMON="/usr/share/x10-xmlrpc/x10-xmlrpcd"

if [  ! -f "$DAEMON" ] ; then
   echo "Daemon file missing"
   exit 100
fi
nohup "ruby $DAEMON "  & 
