#!/bin/bash
# Script 3: hospital_archive.sh 
# Save 2: Implement rotation transfer mechanics
rotate_logs() {
    local timestamp=$(date +"%Y%m%d_%H%M")
    mkdir -p archived_logs
    for file in active_logs/*.log; do
        if [ -f "$file" ]; then
            local filename=$(basename "$file")
            local basement="${filename%.log}"
            mv "$file" "archived_logs/${basement}_${timestamp}.log"
        fi
    done
}
