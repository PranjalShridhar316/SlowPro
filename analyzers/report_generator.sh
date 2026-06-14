#!/bin/bash


# SlowPro HTML Report Generator

# Purpose:
# Generate an HTML investigation report.

# Output:
# reports/report.html


generate_report() {
local CASE_DIR="$1"
local REPORT_FILE="$CASE_DIR/reports/report.html"
local SCORE_FILE="$CASE_DIR/analysis/threat_score.txt"
local IOC_FILE="$CASE_DIR/analysis/ioc_report.txt"
local TIMELINE_FILE="$CASE_DIR/analysis/timeline.txt"
cat > "$REPORT_FILE" << EOF
<!DOCTYPE html>
<html>
<head>
<title>SlowPro Investigation Report</title>
<style>
body {
font-family: Arial, sans-serif;
margin: 40px;
}
h1 {
color: #2c3e50;
}
.section {
margin-top: 30px;
}
pre {
background: #f4f4f4;
padding: 15px;
border-radius: 5px;
}
</style>
</head>
<body>
<h1>SlowPro Investigation Report</h1>
<div class="section">
<h2>Threat Score</h2>
<pre>
$(cat "$SCORE_FILE")
</pre>
</div>
<div class="section">
<h2>IOC Findings</h2>
<pre>
$(cat "$IOC_FILE")
</pre>
</div>
<div class="section">
<h2>Timeline</h2>
<pre>
$(cat "$TIMELINE_FILE")
</pre>
</div>
</body>
</html>
EOF
}