#!/bin/bash

# SlowPro Host Information Collector

# Purpose:
# Collect system-level information that helps identify the investigated machine.

# Output:
# artifacts/host/host.json

collect_host_info() {

# Case directory passed from slowpro.sh
local CASE_DIR="$1"

# Output file location
local OUTPUT_FILE="$CASE_DIR/artifacts/host/host.json"

# Generate host information in JSON format
cat > "$OUTPUT_FILE" << EOF
{
"hostname": "$(hostname)",
"kernel": "$(uname -r)",
"architecture": "$(uname -m)",
"distribution": "$(grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d '"')",
"collection_time": "$(date -Iseconds)"
}
EOF

}