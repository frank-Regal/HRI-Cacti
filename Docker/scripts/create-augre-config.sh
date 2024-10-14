#!/bin/bash

# Function to get the local IP address
get_local_ip() {
    local_ip=$(hostname -I | awk '{print $1}')
    echo $local_ip
}

# Get the local IP address
ip_address=$(get_local_ip)

# Create the AugRESettings.ini file
echo "[Robofleet]" > AugRESettings.ini
echo "Server IP=${ip_address}:8080" >> AugRESettings.ini

echo "Created AugRESettings.ini with IP: ${ip_address}"
