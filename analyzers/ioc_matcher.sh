#!/bin/bash

# SlowPro IOC Matching Engine
#
# Purpose:
# Search collected evidence for known
# Indicators of Compromise (IOCs).
#
# Input:
# indicators/iocs.txt
#
# Output:
# analysis/ioc_matches.txt

match_iocs() {

    # Investigation case
    local CASE_DIR="$1"

    # IOC database
    local IOC_FILE="indicators/iocs.txt"

    # Output report
    local REPORT_FILE="$CASE_DIR/analysis/ioc_matches.txt"

    {

    echo "=================================="
    echo "      SlowPro IOC Matches"
    echo "=================================="
    echo

    # Verify IOC database exists
    if [[ ! -f "$IOC_FILE" ]]; then
        echo "IOC database not found."
        return 0
    fi

   while IFS= read -r IOC
do
    [[ -z "$IOC" ]] && continue

    echo "DEBUG: Testing $IOC"

    if grep -qi "$IOC" \
    "$CASE_DIR/artifacts/processes/processes.json" 2>/dev/null
    then
        echo "[IOC MATCH]"
        echo "Indicator: $IOC"
        echo "Source: processes.json"
        echo
    fi

    if grep -qi "$IOC" \
    "$CASE_DIR/artifacts/network/network.txt" 2>/dev/null
    then
        echo "[IOC MATCH]"
        echo "Indicator: $IOC"
        echo "Source: network.txt"
        echo
    fi

done < "$IOC_FILE"
}
}