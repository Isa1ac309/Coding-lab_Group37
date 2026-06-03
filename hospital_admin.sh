#!/bin/bash

# Member 1 - The Architect
initialize_system() {
    echo "=== Initializing KNH System Environment ==="

    if [ ! -d "active_logs" ]; then
        mkdir active_logs
        echo "Creating active_logs directory..."
    else
        echo "active_logs already exists. Skipping."
    fi

    if [ ! -d "archived_logs" ]; then
        mkdir archived_logs
        echo "Creating archived_logs directory..."
    else
        echo "archived_logs already exists. Skipping."
    fi

    if [ ! -d "reports" ]; then
        mkdir reports
        echo "Creating reports directory..."
    else
        echo "reports already exists. Skipping."
    fi

    echo "Directory initialization complete."
}

initialize_system
