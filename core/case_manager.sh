#!/bin/bash

#Case management module
#Responsible for creating and organizing investigating cases

create_case() {
# Generate timestamp for unique case IDs
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Build case identifier
CASE_ID="CASE_${TIMESTAMP}"

# Define case path
CASE_DIR="cases/${CASE_ID}"

# Create case directory
mkdir -p \
"$CASE_DIR/artifacts/host" \
"$CASE_DIR/artifacts/users" \
"$CASE_DIR/artifacts/processes" \
"$CASE_DIR/artifacts/network" \
"$CASE_DIR/artifacts/logs" \
"$CASE_DIR/artifacts/services" \
"$CASE_DIR/artifacts/packages" \
"$CASE_DIR/analysis" \
"$CASE_DIR/integrity" \
"$CASE_DIR/reports" \
"$CASE_DIR/archive"

# Return created path
echo "$CASE_DIR"
}















