#!/bin/bash

#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
# SlowPro
# Multi-Distro Linux DFIR Framework
#
# Main Entry Point
# Loads required modules and starts workflows.
# \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/

# Load framework modules
source core/logger.sh
source core/utils.sh
source core/case_manager.sh
source core/init.sh

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