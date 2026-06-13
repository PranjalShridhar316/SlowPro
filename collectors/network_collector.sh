#!/bin/bash

# SlowPro Network Collector

# Purpose:
# Capture active listening TCP/UDP ports.

# Output:
# artifacts/network/network.json

# Note:
# Initial version stores raw output.
# Future versions will export structured JSON.


collect_network() {

# Case directory passed from slowpro.sh
local CASE_DIR="$1"

# Output file location
local OUTPUT_FILE="$CASE_DIR/artifacts/network/network.txt"

# Capture listening ports
ss -tuln > "$OUTPUT_FILE"
}