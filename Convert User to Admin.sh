#!/bin/sh

# define jamfhelper location

jhelp="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"

# dseditgroup to promote the currently logged in user to admin rights

if [[ `/usr/bin/dscl . read /Groups/admin GroupMembership | /usr/bin/grep -c $3` == 1 ]]
    then /bin/echo "$3 is in the admin group, exiting"
        exit 0
    else /bin/echo "$3 is not an admin, promoting.." 
fi    

/usr/sbin/dseditgroup -o edit -a $3 -t user admin

"$jhelp" -windowType utility -title "Admin rights" -description "You've been granted admin rights, PLEASE DO NOT ABUSE THIS PRIVILEGE." -button1 "OK"