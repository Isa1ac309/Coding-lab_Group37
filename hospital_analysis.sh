#!/bin/bash

process_vitals() {
    echo "Processing critical patient vitals..."

    mkdir -p reports

    grep "CRITICAL" active_logs/heart_rate.log active_logs/temperature.log | \
    sed 's/active_logs\/[^:]*://' | \
    awk -F',' '{print $1 "," $2 "," $3}' > reports/critical_alerts.txt

    echo "Critical alerts saved to reports/critical_alerts.txt"
}

water_audit() {
    echo "Analyzing ICU water usage..."

    awk -F',' '
    /ICU_WATER_RESERVE/ {
        sum += $3
        count++
    }
    END {
        if (count > 0)
            printf("Average ICU Water Usage: %.2f\n", sum/count)
        else
            printf("No data found\n")
    }' active_logs/water_usage.log
}

process_vitals
water_audit
