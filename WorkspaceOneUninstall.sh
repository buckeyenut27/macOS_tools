#!/bin/bash
##########################################################################################
##
##Copyright (c) 2021 Jamf.  All rights reserved.
##
##      Redistribution and use in source and binary forms, with or without
##      modification, are permitted provided that the following conditions are met:
##              * Redistributions of source code must retain the above copyright
##                notice, this list of conditions and the following disclaimer.
##              * Redistributions in binary form must reproduce the above copyright
##                notice, this list of conditions and the following disclaimer in the
##                documentation and#or other materials provided with the distribution.
##              * Neither the name of the Jamf nor the names of its contributors may be
##                used to endorse or promote products derived from this software without
##                specific prior written permission.
##
##      THIS SOFTWARE IS PROVIDED BY JAMF SOFTWARE, LLC "AS IS" AND ANY
##      EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
##      WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
##      DISCLAIMED. IN NO EVENT SHALL JAMF SOFTWARE, LLC BE LIABLE FOR ANY
##      DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
##      (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
##      LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
##      ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
##      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
##      SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
##
##########################################################################################
#
# SUPPORT FOR THIS PROGRAM
#
#       This program is distributed "as is" by JAMF Software, Professional Services Team. For more
#       information or support for this script, please contact your JAMF Software Account Manager.
#
####################################################################################################
#
# ABOUT THIS PROGRAM
#
# NAME - uninstallMDM (Workspace ONE).sh
#
# DESCRIPTION - Script is used to remove the Workspace ONE framework from clients running
#				macOS 10.14 (Mojave) and higher. Designed to be run from a Jamf Pro Policy.
#				This script is designed to be called by the custom trigger "MDM_Uninstall"
#
####################################################################################################

if [[ -f "/Library/Scripts/hubuninstaller.sh" ]]; then
	/bin/echo "Running Workspace ONE uninstaller script"
	/Library/Scripts/hubuninstaller.sh
else
	/bin/echo "Workspace ONE uninstaller script not found"
fi

exit 0