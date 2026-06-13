#!/bin/bash

# SlowPro Service Collector

# Purpose:
# Collect system service information.

# Output:
# artifacts/services/services.txt

collect_services() {

# Case directory passed from slowpro.sh
local CASE_DIR="$1"

# Output file location
local OUTPUT_FILE="$CASE_DIR/artifacts/services/services.txt"

# Collect active services
systemctl list-units --type=service --no-pager > "$OUTPUT_FILE"

}