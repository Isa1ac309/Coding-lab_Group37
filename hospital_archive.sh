#!/bin/bash
# Script 3: hospital_archive.sh
# Save 3: Finalized script with system continuity rules

rotate_logs() {
    local timestamp=$(date +"%Y%m%d_%H%M")
    mkdir -p archived_logs

    for file in active_logs/*.log; do
        if [ -f "$file" ]; then
            local filename=$(basename "$file")
            local basement="${filename%.log}"
            mv "$file" "archived_logs/${basement}_${timestamp}.log"

            # SYSTEM CONTINUITY: Recreate empty file so data engine doesn't crash
            touch "$file"
            chmod 700 "$file"
        fi
    done
    echo "Log rotation completed."
}

# Execute the engine rotation
rotate_logs
