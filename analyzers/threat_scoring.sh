#!/bin/bash

# SlowPro Threat Scoring Engine
#
# Purpose:
# Calculate risk score from IOC findings.
#
# Output:
# analysis/threat_score.txt

calculate_threat_score() {
local CASE_DIR="$1"
local IOC_REPORT="$CASE_DIR/analysis/ioc_report.txt"
local SCORE_FILE="$CASE_DIR/analysis/threat_score.txt"
local SCORE=0

# Count IOC matches
wMATCHES=$(grep -c "\[MATCH\]" "$IOC_REPORT")

# Each IOC = 20 points
SCORE=$((MATCHES * 20))

# Cap score at 100
if [ "$SCORE" -gt 100 ]; then
SCORE=100
fi

    # Determine risk level
if [ "$SCORE" -ge 80 ]; then
RISK="Critical"
elif [ "$SCORE" -ge 50 ]; then
RISK="High"
elif [ "$SCORE" -ge 20 ]; then
RISK="Medium"
else
RISK="Low"
fi

{
echo "Threat Score : $SCORE/100"
echo "Risk Level   : $RISK"
echo "IOC Matches  : $MATCHES"
} > "$SCORE_FILE"
}