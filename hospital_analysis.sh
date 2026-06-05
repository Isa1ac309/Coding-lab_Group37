#!/bin/bash

# Script 2: Reporting & Analytics
# Handled by Member 2 & Member 3

process_vitals() {
    echo "Processing critical patient vitals..."
    mkdir -p reports
    echo "Timestamp,Device_ID,Value" > reports/critical_alerts.txt
    
    for log in active_logs/heart_rate*.log active_logs/temperature*.log; do
        if [ -f "$log" ]; then
            grep "CRITICAL" "$log" | awk -F',' '{print $1 "," $2 "," $3}' >> reports/critical_alerts.txt
        fi
    done
    echo "Critical alerts saved to reports/critical_alerts.txt"
}

water_audit() {
    echo "Analyzing ICU water usage..."
    
    if ls active_logs/water_usage*.log >/dev/null 2>&1; then
        awk -F',' '
        BEGIN { sum = 0; count = 0; }
        /ICU_WATER_RESERVE/ {
            sum += $3;
            count++;
        }
        END {
            if (count > 0) {
                printf "Average ICU Water Usage: %.2f Liters\n", (sum / count)
            } else {
                printf "No ICU_WATER_RESERVE records discovered.\n"
            }
        }
        ' active_logs/water_usage*.log
    else
        echo "No active water logs found to process."
    fi
}

echo "=== KNH CLINICAL DASHBOARD ==="
process_vitals
echo ""
water_audit
echo "=============================="
