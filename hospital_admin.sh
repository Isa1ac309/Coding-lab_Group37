#!/bin/bash

# ==============================================================================
# Script 1: hospital_admin.sh (Permissions & Setup)
# Tailored for 3-Member Team (Member 1, Member 2, and Member 3)
# ==============================================================================

# Member 1: System Initialization
initialize_system() {
    echo "=== Initializing KNH System Environment ==="
    
    local folders=("active_logs" "archived_logs" "reports")
    for dir in "${folders[@]}"; do
        if [ ! -d "$dir" ]; then
            mkdir -p "$dir"
            echo "Creating $dir directory..."
        else
            echo "$dir already exists. Skipping."
        fi
    done
    echo "Directory initialization complete."
}

# Member 2: Data Protection & Security Lockdown
secure_data() {
    echo "=== Enforcing Security Policies ==="
    if [ -d "active_logs" ]; then
        # Restrict access so ONLY the owner can read/write
        chmod 700 active_logs
        echo "Permissions restricted successfully."
        ls -ld active_logs
    else
        echo "Error: active_logs folder not found."
    fi
}

# Member 3: Core Execution Logic
main() {
    initialize_system
    echo ""
    secure_data
    echo ""
    echo "System Environment Secured - $(date)"
}

# Run the script
main
