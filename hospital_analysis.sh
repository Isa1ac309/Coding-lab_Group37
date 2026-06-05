#!/bin/bash

# ==============================================================================
# Script 2: hospital_analysis.sh (Reporting & Analytics)
# Covered by Team Members to fulfill Clinical & Facility Analytics
# ==============================================================================

process_vitals() {
    echo "Processing critical patient vitals..."
    mkdir -p reports
    
    # Create the file with proper column headers
    echo "Timestamp,Device_ID,Value" > reports/critical_alerts.txt
    
    # Use wildcards (*) to catch all dynamically generated files safely
    for log in active_logs/heart_rate*.log active_logs/temperature*.log; do
        if [ -f "$log" ]; then
            grep "CRITICAL" "$log" | awk -F',' '{print $1 "," $2 "," $3}' >> reports/critical_alerts.txt
        fi
    done
    echo "Critical alerts saved to reports/critical_alerts.txt"
}

water_audit() {
    echo "Analyzing ICU water usage..."
    
    # Safely verify if files exist before processing
    if ls active_logs/water_usage*.log >/dev/null 2>&1; then
        awk -F',' '
        BEGIN { sum = 0; count = 0; }
        /ICU_WATER_RESERVE/ {
            sum += $3;
            count++;
        }
        END {
            if (count > 0) {
                printf "==========================================\n"
                printf "Average ICU Water Usage: %.2f Liters\n", (sum / count)
                printf "==========================================\n"
            } else {
                printf "No ICU_WATER_RESERVE records discovered.\n"
            }
        }
        ' active_logs/water_usage*.log
    else
        echo "No active water logs found to process."
    fi
}

# Run the functions
process_vitals
echo ""
water_audit
