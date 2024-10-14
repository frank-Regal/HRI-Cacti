#!/bin/bash

# Function to create or attach to a tmux session
create_or_attach_tmux() {
    session_name=$1
    command=$2
    
    # Check if the session exists
    tmux has-session -t $session_name 2>/dev/null

    # If the session doesn't exist, create it
    if [ $? != 0 ]; then
        tmux new-session -d -s $session_name
    fi

    # Send the command to the session
    tmux send-keys -t $session_name "$command" C-m
}

# Function to get the local IP address
get_local_ip() {
    local_ip=$(hostname -I | awk '{print $1}')
    echo $local_ip
}

# Function to update config.ts with the IP range
update_config() {
    local ip=$1
    local config_file="/deps/robofleet/robofleet_server/src/config.ts"
    
    # Extract the subnet
    local subnet=$(echo $ip | cut -d. -f1-3)
    
    # Create the new line to add
    local new_line="{ipRange: [\"$subnet.1\", \"$subnet.255\"], allow: [\"send\", \"receive\"]},"
    
    # Use sed to add the new line after the permissions array opening
    sudo sed -i "/permissions: \[/a \ \ \ \ \ \ \ \ $new_line" $config_file
    
    echo "Updated config.ts with IP range: $subnet.1 to $subnet.255"
}

# Get the local IP address
ip_address=$(get_local_ip)

# Update the config.ts file with the IP range
update_config $ip_address

# Create or attach to "robofleet" tmux session and run yarn start
create_or_attach_tmux robofleet-server "cd /deps/robofleet/robofleet_server && sudo yarn start"

# Print the IP address and start message
echo "Robofleet server started on IP: $ip_address"
echo "To view the status of the server, run: 'tmux attach-session -t robofleet-server'"