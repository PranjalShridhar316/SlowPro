#!/bin/bash

# SlowPro User Collector

# Purpose:
# Enumerate local system users from /etc/passwd.

# Output:
# artifacts/users/users.json


collect_users() {

# Case directory passed from slowpro.sh
local CASE_DIR="$1"

# Output file location
local OUTPUT_FILE="$CASE_DIR/artifacts/users/users.json"

# Start JSON array
echo "[" > "$OUTPUT_FILE"

# Read usernames from /etc/passwd
awk -F: '{print $1}' /etc/passwd | while read USER
do

# Write each username as a JSON object
echo "  {\"username\":\"$USER\"}," >> "$OUTPUT_FILE"

done

# Remove trailing comma from last entry
sed -i '$ s/,$//' "$OUTPUT_FILE"

# Close JSON array
echo "]" >> "$OUTPUT_FILE"
}