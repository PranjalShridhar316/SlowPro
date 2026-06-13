#!/bin/bash

# SlowPro Integrity Module

# Purpose:
# Generate SHA256 hashes for collected artifacts.

generate_hashes() {

# Case directory passed from slowpro.sh
local CASE_DIR="$1"

# Output file
local HASH_FILE="$CASE_DIR/integrity/hashes.txt"

# Create hash manifest
find "$CASE_DIR/artifacts" -type f | while read FILE
do
sha256sum "$FILE"
done > "$HASH_FILE"
}