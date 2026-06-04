#!/bin/bash

# hospital_archive.sh
# Rotates hospital log files: timestamps them, moves to archive, recreates empty files

ACTIVE="active_logs"
ARCHIVE="archived_logs"

mkdir -p "$ARCHIVE"

TIMESTAMP=$(date +"%Y%m%d_%H%M")

for FILE in "$ACTIVE"/*.log; do
    BASENAME=$(basename "$FILE")
    NAME="${BASENAME%.log}"
    NEW_NAME="${NAME}_${TIMESTAMP}.log"

    mv "$FILE" "$ARCHIVE/$NEW_NAME"
    echo "Archived: $FILE → $ARCHIVE/$NEW_NAME"

    touch "$FILE"
    echo "Recreated empty: $FILE"
done

echo "All logs rotated successfully."
