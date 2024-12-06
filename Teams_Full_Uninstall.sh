#!/bin/bash

# Function to force quit Microsoft Teams
echo "Force quitting Microsoft Teams..."
osascript -e 'quit app "Microsoft Teams"'
sleep 2

# Check if Teams is still running and force quit if necessary
if pgrep -x "Teams" > /dev/null; then
    echo "Microsoft Teams is still running. Forcing it to quit."
    killall -9 "Teams"
else
    echo "Microsoft Teams successfully quit."
fi

# Remove Microsoft Teams from the Applications folder
echo "Removing Microsoft Teams from the Applications folder..."
if [ -d "/Applications/Microsoft Teams.app" ]; then
    mv /Applications/Microsoft\ Teams.app ~/.Trash/
    echo "Microsoft Teams moved to Trash."
else
    echo "Microsoft Teams is not installed in /Applications."
fi

# Remove Teams-related cache and support files
echo "Removing Teams cache and support files..."

rm -rf ~/Library/Caches/com.microsoft.teams
rm -rf ~/Library/Caches/com.microsoft.teams.shipit
rm -rf ~/Library/Application\ Support/Microsoft/Teams
rm -rf ~/Library/Application\ Support/Microsoft/Teams/Application\ Cache/Cache
rm -rf ~/Library/Application\ Support/Microsoft/Teams/blob_storage
rm -rf ~/Library/Application\ Support/Microsoft/Teams/Cache
rm -rf ~/Library/Application\ Support/Microsoft/Teams/databases
rm -rf ~/Library/Application\ Support/Microsoft/Teams/GPUCache
rm -rf ~/Library/Application\ Support/Microsoft/Teams/IndexedDB
rm -rf ~/Library/Application\ Support/Microsoft/Teams/Local\ Storage
rm -rf ~/Library/Application\ Support/Microsoft/Teams/tmp

echo "All specified Microsoft Teams files have been deleted."

# Finished
echo "Microsoft Teams cleanup is complete."