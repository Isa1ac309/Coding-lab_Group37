#!/bin/bash

# ==============================================================================
# Script 3: hospital_archive.sh 
# Save 3: Finalized Script with System Continuity rules
# ==============================================================================

rotate_logs() {
    local timestamp
    timestamp=$(date +"%Y%m%d_%H%M")
    echo "Starting log rotation procedure..."
    mkdir -p archived_logs
    
    for file in active_logs/*.log; do
        if [ -f "$file" ]; then
            local filename=$(basename "$file")
            local basement="${filename%.log}"
            local new_archive_name="archived_logs/${basement}_${timestamp}.log"
            
            echo "Archiving: $file -> $new_archive_name"
            mv "$file" "$new_archive_name"
            
            # SYSTEM CONTINUITY RULE: Recreate empty versions of the file
            # so the python data engine doesn't crash from missing folders.
            touch "$file"
            chmod 700 "$file"
        fi
    done
    echo "Log rotation completed successfully."
}

# Run the function
rotate_logs
