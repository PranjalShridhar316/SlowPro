#!/bin/bash

# SlowPro Process Collector

# Purpose:
# Capture currently running processes.

# Output:
# artifacts/processes/processes.json


collect_processes() {

# Case directory passed from slowpro.sh
local CASE_DIR="$1"

# Output file location
local OUTPUT_FILE="$CASE_DIR/artifacts/processes/processes.json"

# Capture process list and convert to JSON-like format
ps -eo pid,user,args --no-headers |
awk '
BEGIN {
print "["
}
{
printf "{\"pid\":\"%s\",\"user\":\"%s\",\"command\":\"%s\"},\n",
$1,$2,$3
}

END {
print "]"
}
' > "$OUTPUT_FILE"

}