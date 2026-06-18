#!/bin/bash

# ==============================================
# SlowPro Persistence Hunter

# Purpose:
# Detect common Linux persistence mechanisms
# and identify suspicious persistence artifacts.

# Detects:
# - System crontab entries
# - Cron directory contents
# - Enabled systemd services
# - Suspicious cron keywords
# - Suspicious systemd service paths

# Output:
# analysis/persistence_report.txt
# ==============================================

hunt_persistence() {

# Investigation case directory
local CASE_DIR="$1"

# Output report file
local REPORT_FILE="$CASE_DIR/analysis/persistence_report.txt"

{

echo "=================================="
echo "   SlowPro Persistence Report"
echo "=================================="
echo

# ==========================================
# System Crontab
# ==========================================

echo "[System Crontab]"
cat /etc/crontab 2>/dev/null
echo

# ==========================================
# Cron Directories
# ==========================================

echo "[Cron Directories]"
ls -la /etc/cron.* 2>/dev/null
echo

# ==========================================
# Suspicious Cron Job Detection
#
# Hunt for commonly abused tools found
# inside cron jobs.
# ==========================================

# ==========================================
# Suspicious Cron Job Detection
# ==========================================

echo "[Suspicious Cron Jobs]"
echo

CRON_DATA=$(
grep -v '^#' /etc/crontab 2>/dev/null |
grep -v '^$'
grep -R "" /etc/cron.* 2>/dev/null |
grep -v '^#' |
grep -v '^$'
)

for IOC in curl wget nc netcat socat python python3 perl
do
if echo "$CRON_DATA" | grep -qi "$IOC"
then
secho "[ALERT] Possible persistence keyword detected: $IOC"
fi
done
echo

# ==========================================
# Enabled Services
# ==========================================

echo "[Enabled Services]"
systemctl list-unit-files --state=enabled 2>/dev/null
echo

# ==========================================
# Suspicious Service Detection
#
# Detect services executing binaries
# from attacker-favored locations.
#
# Examples:
# /tmp
# /var/tmp
# /dev/shm
# /home
# ==========================================

echo "[Suspicious Services]"
echo

systemctl list-unit-files \
--state=enabled \
--no-pager \
--no-legend 2>/dev/null |
awk '{print $1}' |
while read -r SERVICE
do
# Retrieve service definition
SERVICE_CONTENT=$(systemctl cat "$SERVICE" 2>/dev/null)
# Extract ExecStart line only
EXEC_LINE=$(echo "$SERVICE_CONTENT" | grep "^ExecStart=")
# Look for suspicious execution paths
if echo "$EXEC_LINE" | \
grep -Eq "/tmp|/var/tmp|/dev/shm|/home"
then
echo "[ALERT] Suspicious service detected: $SERVICE"
echo "$EXEC_LINE"
echo
fi
done
echo

# ==========================================
# Summary
# ==========================================

echo "[Summary]"
echo "Persistence enumeration completed."

} > "$REPORT_FILE"
}
