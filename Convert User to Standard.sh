#!/bin/bash

currentUser=$(who | awk '/console/{print $1}')
echo $currentUser

# Remove user as admin
dseditgroup -o edit -d "$currentUser" admin
