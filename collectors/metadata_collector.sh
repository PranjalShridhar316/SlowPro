#!/bin/bash

# SlowPro Metadata Collector

# Purpose:
# Generate collection metadata for each case.

# Output:
# analysis/collection_metadata.json

collect_metadata() {

# Case directory passed from slowpro.sh
local CASE_DIR="$1"

# Metadata output file
local OUTPUT_FILE="$CASE_DIR/analysis/collection_metadata.json"

# Extract case ID from directory name
local CASE_ID
CASE_ID=$(basename "$CASE_DIR")

# Create metadata file
cat > "$OUTPUT_FILE" << EOF
{
"case_id": "$CASE_ID",
"collector": "SlowPro",
"version": "1.0",
"collection_time": "$(date -Iseconds)",
"hostname": "$(hostname)",
"distribution": "$(grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d '"')",
"package_manager": "$PACKAGE_MANAGER"
}
EOF

}