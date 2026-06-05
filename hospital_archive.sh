#!/bin/bash

# Script 3: Log Archiving & Continuity Logic
# Handled by Ian Gwiza Rwagitare

rotate_logs() {
    local timestamp=$(date +"%Y%m%d_%H%M")
    mkdir -p archived_logs
    
    for file in active_logs/*.log; do
        if [ -f "$file" ]; then
            local filename=$(basename "$file")
            local basement="${filename%.log}"
            mv "$file" "archived_logs/${basement}_${timestamp}.log"
            
            # Recreate empty files for system continuity
            touch "$file"
            chmod 700 "$file"
        fi
    done
    echo "Log rotation completed."
}

rotate_logs
