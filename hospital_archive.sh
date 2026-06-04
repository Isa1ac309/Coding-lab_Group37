#!/bin/bash

# ==============================================================================
# Script 3: hospital_archive.sh 
# Save 2: Adding the folder rotation logic
# ==============================================================================

rotate_logs() {
    local timestamp
    timestamp=$(date +"%Y%m%d_%H%M")
    echo "Starting log rotation procedure..."
    mkdir -p archived_logs
    
    # Look inside active_logs for any files ending in .log
    for file in active_logs/*.log; do
        if [ -f "$file" ]; then
            local filename=$(basename "$file")
            local basement="${filename%.log}"
            
            # Create the final archive path naming format required by instructions
            local new_archive_name="archived_logs/${basement}_${timestamp}.log"
            echo "Archiving: $file -> $new_archive_name"
            
            # STRICT RULE: Fresh move. This cuts the file from active and pastes it to archive.
            mv "$file" "$new_archive_name"
        fi
    done
}
