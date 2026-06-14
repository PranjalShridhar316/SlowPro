#!/bin/bash

# SlowPro IOC Analyzer
#
# Purpose:
# Detect basic Indicators of Compromise.
#
# Output:
# analysis/ioc_report.txt

analyze_iocs() {

# Case directory passed from slowpro.sh
local CASE_DIR="$1"

# Output file
local REPORT_FILE="$CASE_DIR/analysis/ioc_report.txt"
echo "==================================" > "$REPORT_FILE"
echo "      SlowPro IOC Report" >> "$REPORT_FILE"
echo "==================================" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# ==================================================
# Suspicious Users
# ==================================================

echo "[Suspicious Users]" >> "$REPORT_FILE"
while read IOC_USER
do
grep -q "\"username\":\"$IOC_USER\"" \
"$CASE_DIR/artifacts/users/users.json" && \
echo "[MATCH] User: $IOC_USER" >> "$REPORT_FILE"
done < "$SCRIPT_DIR/data/iocs/suspicious_users.txt"
echo "" >> "$REPORT_FILE"

# ==================================================
# Suspicious Processes
# ==================================================

echo "[Suspicious Processes]" >> "$REPORT_FILE"
while read IOC_PROCESS
do
grep -qi "$IOC_PROCESS" \
"$CASE_DIR/artifacts/processes/processes.json" && \
echo "[MATCH] Process: $IOC_PROCESS" >> "$REPORT_FILE"
done < "$SCRIPT_DIR/data/iocs/suspicious_processes.txt"
echo "" >> "$REPORT_FILE"

# ==================================================
# Suspicious Listening Ports
# ==================================================

echo "[Suspicious Ports]" >> "$REPORT_FILE"
while read IOC_PORT
do
grep -q ":$IOC_PORT" \
"$CASE_DIR/artifacts/network/network.txt" && \
echo "[MATCH] Port: $IOC_PORT" >> "$REPORT_FILE"
done < "$SCRIPT_DIR/data/iocs/suspicious_ports.txt"
echo "" >> "$REPORT_FILE"
}