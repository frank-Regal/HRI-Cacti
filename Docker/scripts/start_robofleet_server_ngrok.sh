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

# Create or attach to "robofleet" tmux session and run yarn start
create_or_attach_tmux robofleet "cd /mnt/c/Users/Frank/devel/non_ros_projects/robofleet/robofleet_server && yarn start"

# Wait a moment to ensure yarn has started
sleep 5

# Create or attach to "ngrok" tmux session and run ngrok
create_or_attach_tmux ngrok "ngrok tcp --remote-addr=1.tcp.ngrok.io:27907 8080 --authtoken 2ULTEe74gCXJa7GiRgXxr3FoeyE_3tSFdhStKLaKJK2gmTMEK"

# Attach to the "robofleet" session
tmux attach-session -t robofleet
