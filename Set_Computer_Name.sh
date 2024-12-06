#!/bin/bash
#########################################################################################
# License information
#########################################################################################
# Copyright 2022 Jamf Professional Services

# Permission is hereby granted, free of charge, to any person obtaining a copy of this
# software and associated documentation files (the "Software"), to deal in the Software
# without restriction, including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
# to whom the Software is furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all copies or
# substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
# PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
# FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

#########################################################################################
# General Information
#########################################################################################
# This script is design to rename the computer base on serial and prefix 
##########################################################################################
# Build for PDS
# By Gio Martell Jamf PSE
# Version 1.0 11/2022
##########################################################################################
# Lets get some information
CURRENT_USER=$(/usr/bin/stat -f%Su /dev/console)

#Get Serial Number
serial="$(ioreg -l | grep IOPlatformSerialNumber | sed -e 's/.*\"\(.*\)\"/\1/')"
prefix="PDS"


COMPUTERNAME="$prefix"-"$serial"
echo "Setting computer name to $COMPUTERNAME"
/usr/sbin/scutil --set ComputerName "$COMPUTERNAME"
/usr/sbin/scutil --set LocalHostName "$COMPUTERNAME"
/usr/sbin/scutil --set HostName "$COMPUTERNAME"
dscacheutil -flushcache
/usr/local/bin/jamf recon
exit 0

