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
create_or_attach_tmux robofleet-client "source /project/ws_dev/devel/setup.bash && rosrun robofleet_client client /project/ws_dev/src/hri_cacti_xr/robofleet/hl-ss-config.yaml"

tmux attach-session -t robofleet-client
