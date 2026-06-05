#!/bin/bash

# Script 1: Permissions & Setup
# Handled by Member 1 & Member 2

initialize_system() {
    echo "Initializing KNH System Environment..."
    
    local folders=("active_logs" "archived_logs" "reports")
    for dir in "${folders[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
            echo "Created $dir directory"
        else
            echo "$dir already exists. Skipping."
        fi
    done
}

secure_data() {
    echo "Enforcing Security Policies..."
    if [ -d "active_logs" ]; then
        chmod 700 active_logs
        ls -ld active_logs
    else
        echo "Error: active_logs folder not found"
    fi
}

main() {
    initialize_system
    echo ""
    secure_data
    echo ""
    echo "System Environment Secured - $(date)"
}

main
