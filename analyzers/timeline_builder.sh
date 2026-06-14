#!/bin/bash

# SlowPro Timeline Builder

# Purpose:
# Build investigation timeline.

# Output:
# analysis/timeline.txt


build_timeline() {
local CASE_DIR="$1"
local OUTPUT_FILE="$CASE_DIR/analysis/timeline.txt"
{
echo "=================================="
echo "      SlowPro Timeline"
echo "=================================="
echo
echo "$(date -Iseconds) | Case Created"
echo "$(date -Iseconds) | Host Collection Completed"
echo "$(date -Iseconds) | User Collection Completed"
echo "$(date -Iseconds) | Process Collection Completed"
echo "$(date -Iseconds) | Network Collection Completed"
echo "$(date -Iseconds) | Service Collection Completed"
echo "$(date -Iseconds) | Package Collection Completed"
echo "$(date -Iseconds) | Integrity Verification Completed"
echo "$(date -Iseconds) | IOC Analysis Completed"
echo "$(date -Iseconds) | Threat Scoring Completed"

} > "$OUTPUT_FILE"
}