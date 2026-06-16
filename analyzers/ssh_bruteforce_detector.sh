#!/bin/bash

# SlowPro SSH Brute Force Detector



# Purpose:
# Detect repeated failed SSH login attempts
# originating from the same source IP.


# Output:

# analysis/bruteforce_report.txt
detect_ssh_bruteforce() {

# Investigation case directory
local CASE_DIR="$1"

# Output report
local REPORT_FILE="$CASE_DIR/analysis/bruteforce_report.txt"

# Alert threshold
local THRESHOLD=5

{
echo "=================================="
echo " SlowPro SSH Brute Force Report"
echo "=================================="
echo

echo "[Failed Login Attempts by IP]"
echo

grep "Failed password" "$CASE_DIR/artifacts/logs/auth.log" 2>/dev/null | 
grep -oE '[0-9]+.[0-9]+.[0-9]+.[0-9]+' | 
sort | uniq -c | sort -nr

echo
echo "[Suspicious Sources]"
echo

grep "Failed password" "$CASE_DIR/artifacts/logs/auth.log" 2>/dev/null | 
grep -oE '[0-9]+.[0-9]+.[0-9]+.[0-9]+' | 
sort | uniq -c | sort -nr | 
while read COUNT IP
do
if [[ "$COUNT" -ge "$THRESHOLD" ]]; then
echo "[ALERT] $IP -> $COUNT failed login attempts"
fi
done

} > "$REPORT_FILE"

}
