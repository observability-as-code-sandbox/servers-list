#!/bin/bash

# 1. INPUT PARAMETERS
_controller_url="${1}" #
# provide token in ".local.token" file

# one of the two has to be specified:
_application_name="Server%20&%20Infrastructure%20Monitoring"

# 2. PREPARE
destination_dir="./exported/"
destination_file="servers.json"

### Validate input parameters
### token
if ([ -z "${_token// }" ]); then
	_token=$(cat ".local.token")
fi

if [ -z "${_token// }" ]; then
    echo "INPUT|ERROR|Token value cannot be empty '${_token}'"
    exit 1
fi

# create auth header
_auth_header="Authorization:Bearer ${_token}"

# validate connection 
_controller_host="$(echo $_controller_url | sed -e 's|^[^/]*//||' -e 's|/.*$||' -e 's|:.*$||')"
_controller_protocol="$(echo $_controller_url | grep :// | sed -e's,^\(.*://\).*,\1,g' | sed 's/.\{3\}$//' | tr '[:upper:]' '[:lower:]')"

# if host url does not contain protocol set https by default
if [ -z "${_controller_protocol}" ]; then
	_controller_protocol="https"
fi

_controller_url="$_controller_protocol://$_controller_host/controller"

echo "INPUT|INFO|Connecting to controller: '$_controller_url'"

# timeout after 10s
controllerReponse=$(curl -s -H "${_auth_header}" ${_controller_url}/rest/applications --connect-timeout 10)

if [ "$controllerReponse" = "" ]; then
    echo "INPUT|ERROR|Unable to connect to controller: '"$_controller_url"'. Aborting..."
    exit 1
fi

# get servers
echo "API|INFO|Exporting server list..."
allServers=$(curl -X GET -s -H "${_auth_header}" "${_controller_url}/rest/applications/${_application_name}/nodes?output=json")

echo "${allServers}" > "${destination_dir}/${destination_file}"

echo "API|INFO|Done."
