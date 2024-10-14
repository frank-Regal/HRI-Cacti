#!/bin/bash

# Function to kill a tmux session
kill_tmux_session() {
    session_name=$1
    
    # Check if the session exists
    tmux has-session -t $session_name 2>/dev/null

    # If the session exists, kill it
    if [ $? = 0 ]; then
        echo "Killing tmux session: $session_name"
        tmux kill-session -t $session_name
    else
        echo "Tmux session not found: $session_name"
    fi
}

# Kill the "robofleet" session
kill_tmux_session robofleet-server

# Kill the "ngrok" session
kill_tmux_session ngrok

echo "All specified tmux sessions have been terminated."
