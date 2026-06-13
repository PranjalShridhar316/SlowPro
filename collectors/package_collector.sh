#!/bin/bash

# SlowPro Package Collector

# Purpose:
# Collect installed package information.

# Output:
# artifacts/packages/packages.txt

collect_packages() {
local CASE_DIR="$1"
local OUTPUT_FILE="$CASE_DIR/artifacts/packages/packages.txt"
case "$PACKAGE_MANAGER" in
apt)
dpkg -l > "$OUTPUT_FILE"
;;

dnf)
rpm -qa > "$OUTPUT_FILE"
;;

pacman)
pacman -Q > "$OUTPUT_FILE"
;;
*)
echo "Unsupported package manager" > "$OUTPUT_FILE"
;;
esac
}