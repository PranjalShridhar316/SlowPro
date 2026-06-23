#!/bin/bash

# ==============================================

# SlowPro Privilege Escalation Hunter

# ==============================================

#

# Purpose:

# Detect common Linux privilege escalation

# opportunities during investigations.

#

# Checks:

# - SUID binaries

# - SGID binaries

# - World-writable files

# - World-writable directories

#

# Output:

# analysis/privesc_report.txt

#

# ==============================================

privesc_hunter() {

# Investigation case directory
local CASE_DIR="$1"

# Output report
local REPORT_FILE="$CASE_DIR/analysis/privesc_report.txt"

{

echo "=================================="
echo " SlowPro PrivEsc Report"
echo "=================================="
echo

# ==========================================
# SUID Binaries
# ==========================================

echo "[SUID Binaries]"
echo

find / \
-xdev \
-perm -4000 \
-type f \
2>/dev/null | sort

echo
echo

# ==========================================
# SGID Binaries
# ==========================================

echo "[SGID Binaries]"
echo

find / \
-xdev \
-perm -2000 \
-type f \
2>/dev/null | sort

echo
echo

# ==========================================
# World Writable Files
# ==========================================

echo "[World Writable Files]"
echo

WW_FILES=$(find / \
-xdev \
-type f \
-perm -0002 \
2>/dev/null | wc -l)

echo "Total World Writable Files: $WW_FILES"
echo

find / \
-xdev \
-type f \
-perm -0002 \
2>/dev/null | head -20

echo
echo

# ==========================================
# World Writable Directories
# ==========================================

echo "[World Writable Directories]"
echo

WW_DIRS=$(find / \
-xdev \
-type d \
-perm -0002 \
2>/dev/null | \
grep -Ev '^/tmp$|^/var/tmp$|^/tmp/.X11-unix$|^/mnt/' | wc -l)

echo "Total World Writable Directories: $WW_DIRS"
echo

find / \
-xdev \
-type d \
-perm -0002 \
2>/dev/null | \
grep -Ev '^/tmp$|^/var/tmp$|^/tmp/.X11-unix$|^/mnt/' | \
head -20

echo
echo

# ==========================================
# Dangerous Permission Findings
# ==========================================

echo "[Dangerous Permission Findings]"
echo

if [[ "$WW_FILES" -gt 0 ]]; then
    echo "[ALERT] World-writable files detected."
fi

if [[ "$WW_DIRS" -gt 0 ]]; then
    echo "[ALERT] Non-standard world-writable directories detected."
fi

echo
echo

# ==========================================
# Summary
# ==========================================

echo "[Summary]"
echo

SUID_COUNT=$(find / \
-xdev \
-perm -4000 \
-type f \
2>/dev/null | wc -l)

SGID_COUNT=$(find / \
-xdev \
-perm -2000 \
-type f \
2>/dev/null | wc -l)

echo "SUID Binaries: $SUID_COUNT"
echo "SGID Binaries: $SGID_COUNT"
echo "World Writable Files: $WW_FILES"
echo "World Writable Directories: $WW_DIRS"

echo
echo "[Privilege Escalation Risk Level]"
echo

if [[ "$WW_FILES" -gt 0 ]]; then
    echo "HIGH"
elif [[ "$WW_DIRS" -gt 0 ]]; then
    echo "MEDIUM"
elif [[ "$SUID_COUNT" -gt 20 ]]; then
    echo "MEDIUM"
else
    echo "LOW"
fi

echo
echo "Privilege Escalation Enumeration Completed."

} > "$REPORT_FILE"

}
