#!/bin/bash

# SlowPro Snapshot Comparison Engine
#
# Purpose:
# Compare two investigation cases.
#
# Output:
# compare_report.txt

compare_cases() {

local OLD_CASE="$1"
local NEW_CASE="$2"

local OUTPUT_FILE="compare_report.txt"

echo "==================================" > "$OUTPUT_FILE"
echo "   SlowPro Comparison Report" >> "$OUTPUT_FILE"
echo "==================================" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"
echo "[New Users]" >> "$OUTPUT_FILE"

comm -13 \
<(grep username "$OLD_CASE/artifacts/users/users.json" | sed -E 's/.*"username":"([^"]+)".*/\1/' | sort -u) \
<(grep username "$NEW_CASE/artifacts/users/users.json" | sed -E 's/.*"username":"([^"]+)".*/\1/' | sort -u) \
>> "$OUTPUT_FILE"

echo "" >> "$OUTPUT_FILE"

echo "[New Processes]" >> "$OUTPUT_FILE"

comm -13 \
<(grep command "$OLD_CASE/artifacts/processes/processes.json" | sed -E 's/.*"command":"([^"]+)".*/\1/' | sort -u) \
<(grep command "$NEW_CASE/artifacts/processes/processes.json" | sed -E 's/.*"command":"([^"]+)".*/\1/' | sort -u) | \
grep -v "slowpro" \
>> "$OUTPUT_FILE"

echo "" >> "$OUTPUT_FILE"

echo "[New Listening Ports]" >> "$OUTPUT_FILE"

comm -13 \
<(grep LISTEN "$OLD_CASE/artifacts/network/network.txt" | sort) \
<(grep LISTEN "$NEW_CASE/artifacts/network/network.txt" | sort) \
>> "$OUTPUT_FILE"
}