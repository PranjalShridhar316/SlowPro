#!/bin/bash

#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
# SlowPro
# Multi-Distro Linux DFIR Framework
#
# Main Entry Point
# Loads required modules and starts workflows.
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

# Absolute path to SlowPro root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load framework modules
source "$SCRIPT_DIR/core/logger.sh"
source "$SCRIPT_DIR/core/utils.sh"
source "$SCRIPT_DIR/core/case_manager.sh"
source "$SCRIPT_DIR/core/init.sh"
source "$SCRIPT_DIR/core/distro_detector.sh"

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

#Environment detection
DISTRO=$(detect_distro)
PACKAGE_MANAGER=$(detect_package_manager "$DISTRO")
ADAPTER=$(load_adapter "$DISTRO")
log_info "Distribution: $DISTRO"
log_info "Package Manager: $PACKAGE_MANAGER"
log_info "Adapter Loaded: $ADAPTER"