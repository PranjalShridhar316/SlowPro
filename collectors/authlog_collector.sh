#!/bin/bash

# SlowPro Authentication Log Collector

# Purpose:
# Collect authentication logs for
# incident response and forensic analysis.
# Supported Logs:
# - /var/log/auth.log (Debian/Ubuntu/Kali)
# - /var/log/secure   (RHEL/Rocky/AlmaLinux)


# Output:
# artifacts/logs/

collect_auth_logs() {

# Investigation case directory
local CASE_DIR="$1"

# Create destination directory
mkdir -p "$CASE_DIR/artifacts/logs"

# Debian-based systems
if [[ -f /var/log/auth.log ]]; then
cp /var/log/auth.log \
"$CASE_DIR/artifacts/logs/auth.log"
fi

# RHEL-based systems
if [[ -f /var/log/secure ]]; then
cp /var/log/secure \
"$CASE_DIR/artifacts/logs/secure"
fi
}
