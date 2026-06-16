#!/bin/bash

# SlowPro Authentication Log Analyzer

#

# Purpose:

# Analyze authentication logs for

# suspicious login activity.

#

# Detects:

# - Failed SSH logins

# - Successful SSH logins

# - Invalid user attempts

#

# Output:

# analysis/auth_report.txt

analyze_auth_logs() {

# Investigation case directory

local CASE_DIR="$1"

# Output report

local REPORT_FILE="$CASE_DIR/analysis/auth_report.txt"

{
echo "=================================="
echo "   SlowPro Authentication Report"
echo "=================================="
echo

# ==================================

# Failed SSH Logins

# ==================================

echo "[Failed SSH Logins]"
grep "Failed password" "$CASE_DIR/artifacts/logs/auth.log" 2>/dev/null || true

echo

# ==================================

# Successful SSH Logins

# ==================================

echo "[Successful SSH Logins]"
grep "Accepted password" "$CASE_DIR/artifacts/logs/auth.log" 2>/dev/null || true


echo

# ==================================

# Invalid User Attempts

# ==================================

echo "[Invalid Users]"
grep "Invalid user" "$CASE_DIR/artifacts/logs/auth.log" 2>/dev/null || true

echo

# ==================================

# Summary Statistics

# ==================================

echo "[Summary]"

FAILED_COUNT=$(grep -c "Failed password" \
"$CASE_DIR/artifacts/logs/auth.log" 2>/dev/null)

SUCCESS_COUNT=$(grep -c "Accepted password" \
"$CASE_DIR/artifacts/logs/auth.log" 2>/dev/null)

INVALID_COUNT=$(grep -c "Invalid user" \
"$CASE_DIR/artifacts/logs/auth.log" 2>/dev/null)

FAILED_COUNT=${FAILED_COUNT:-0}
SUCCESS_COUNT=${SUCCESS_COUNT:-0}
INVALID_COUNT=${INVALID_COUNT:-0}

echo "Failed Logins: $FAILED_COUNT"
echo "Successful Logins: $SUCCESS_COUNT"
echo "Invalid User Attempts: $INVALID_COUNT"

} > "$REPORT_FILE"

}
