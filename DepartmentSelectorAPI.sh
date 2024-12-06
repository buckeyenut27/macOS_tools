#!/bin/bash

#This version has been edited by Simon Tran, department selection now only appears once

##########################################
#Variables

client_id="$4"
client_secret="$5"
url="https://pacificdental.jamfcloud.com"
serialNumber=$(system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}')

###########################################
# Functions

##This output has multiple values, use plutil to extract the token
getAccessToken() {
	response=$(curl --silent --location --request POST "${url}/api/oauth/token" \
		--header "Content-Type: application/x-www-form-urlencoded" \
		--data-urlencode "client_id=${client_id}" \
		--data-urlencode "grant_type=client_credentials" \
		--data-urlencode "client_secret=${client_secret}")
	access_token=$(echo "$response" | plutil -extract access_token raw -)
	token_expires_in=$(echo "$response" | plutil -extract expires_in raw -)
	token_expiration_epoch=$(($current_epoch + $token_expires_in - 1))
}

checkTokenExpiration() {
	current_epoch=$(date +%s)
	if [[ token_expiration_epoch -ge current_epoch ]]
	then
		echo "Token valid until the following epoch time: " "$token_expiration_epoch"
	else
		echo "No valid token available, getting new token"
		getAccessToken
	fi
}

invalidateToken() {
	responseCode=$(curl -w "%{http_code}" -H "Authorization: Bearer ${access_token}" $url/api/v1/auth/invalidate-token -X POST -s -o /dev/null)
	if [[ ${responseCode} == 204 ]]
	then
		echo "Token successfully invalidated"
		access_token=""
		token_expiration_epoch="0"
	elif [[ ${responseCode} == 401 ]]
	then
		echo "Token already invalid"
	else
		echo "An unknown error occurred invalidating the token"
	fi
}

##################################
# Script Start

echo ""
checkTokenExpiration

# Define the departments
departments=("Information Technology", "Marketing", "Innovation Center", "Finance", "Clinical", "Unified Communications", "Other Support Department")

# Capture the selected department
selected_department=$(osascript -e 'set departments to {"Information Technology", "Marketing", "Innovation Center", "Finance", "Clinical", "Unified Communications", "Other Support Department"}
set chosenDepartment to choose from list departments with prompt "Select your department:" default items {"IT"} without multiple selections allowed and empty selection allowed
if chosenDepartment is false then
    error number -128
else
    return item 1 of chosenDepartment
end if')

# Check if a department was selected
if [ -z "$selected_department" ]; then
    echo "No department selected. Exiting."
    exit 1
fi

# Update the department field in Jamf Pro
	curl -s -X 'PUT' \
	"$url/JSSResource/computers/serialnumber/$serialNumber" \
	-H 'Content-Type: application/xml' \
	-H "Authorization: Bearer $access_token" \
	-d "<computer><location><department>$selected_department</department></location></computer>"