#!/bin/bash

#==============================================
# SlowPro
# Multi-Distro Linux DFIR Framework
# Main Entry Point
# Loads required modules and starts workflows.
#==============================================

# Absolute path to SlowPro root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#=================================================

# Load Framework Modules

#=================================================

# Core modules

source "$SCRIPT_DIR/core/logger.sh"
source "$SCRIPT_DIR/core/utils.sh"
source "$SCRIPT_DIR/core/case_manager.sh"
source "$SCRIPT_DIR/core/init.sh"
source "$SCRIPT_DIR/core/distro_detector.sh"
source "$SCRIPT_DIR/core/integrity.sh"

# Collectors

source "$SCRIPT_DIR/collectors/host_collector.sh"
source "$SCRIPT_DIR/collectors/user_collector.sh"
source "$SCRIPT_DIR/collectors/process_collector.sh"
source "$SCRIPT_DIR/collectors/network_collector.sh"
source "$SCRIPT_DIR/collectors/service_collector.sh"
source "$SCRIPT_DIR/collectors/package_collector.sh"
source "$SCRIPT_DIR/collectors/metadata_collector.sh"
source "$SCRIPT_DIR/collectors/authlog_collector.sh"

# Analyzers

source "$SCRIPT_DIR/analyzers/ioc_analyzer.sh"
source "$SCRIPT_DIR/analyzers/threat_scoring.sh"
source "$SCRIPT_DIR/analyzers/timeline_builder.sh"
source "$SCRIPT_DIR/analyzers/report_generator.sh"
source "$SCRIPT_DIR/analyzers/snapshot_compare.sh"
source "$SCRIPT_DIR/analyzers/authlog_analyzer.sh"

#=================================================

# Snapshot Comparison Mode

#=================================================

if [[ "$1" == "--compare" ]]; then


if [[ -z "$2" || -z "$3" ]]; then
    echo "Usage:"
    echo "./slowpro.sh --compare <OLD_CASE> <NEW_CASE>"
    exit 1
fi

compare_cases "$2" "$3"

echo
cat compare_report.txt

exit 0


fi

#=================================================

# Standard Investigation Workflow

#=================================================

# Display startup banner

banner

# Verify root privileges

check_root

# Start investigation workflow

log_info "Creating investigation case..."

# Create new case

CASE_PATH=$(create_case)

# Notify user

log_success "Case created: $CASE_PATH"

# Environment detection

DISTRO=$(detect_distro)
PACKAGE_MANAGER=$(detect_package_manager "$DISTRO")
ADAPTER=$(load_adapter "$DISTRO")

log_info "Distribution: $DISTRO"
log_info "Package Manager: $PACKAGE_MANAGER"
log_info "Adapter Loaded: $ADAPTER"


# Metadata Collection
log_info "Generating collection metadata..."
collect_metadata "$CASE_PATH"


# Evidence Collection
log_info "Collecting host information..."
collect_host_info "$CASE_PATH"

log_info "Collecting user information..."
collect_users "$CASE_PATH"

log_info "Collecting process information..."
collect_processes "$CASE_PATH"

log_info "Collecting network information..."
collect_network "$CASE_PATH"

log_info "Collecting service information..."
collect_services "$CASE_PATH"

log_info "Collecting installed packages..."
collect_packages "$CASE_PATH"


# Integrity Verification
log_info "Generating evidence hashes..."
generate_hashes "$CASE_PATH"


# Analysis Phase
log_info "Running IOC analysis..."
analyze_iocs "$CASE_PATH"

log_info "Calculating threat score..."
calculate_threat_score "$CASE_PATH"

log_info "Building investigation timeline..."
build_timeline "$CASE_PATH"


# Reporting
log_info "Generating HTML report..."
generate_report "$CASE_PATH"

# Collect authentication logs
log_info "Collecting authentication logs..."
collect_auth_logs "$CASE_PATH"

# Authentication log analysis
log_info "Analyzing authentication logs..."
analyze_auth_logs "$CASE_PATH"

# Complete
log_success "Evidence collection completed."
