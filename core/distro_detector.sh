#!/bin/bash

#Detects Linux distributions and package managers.

# Detect Linux distribution
detect_distro() {
if [[ ! -f /etc/os-release ]]; then
echo "unknown"
return
fi
source /etc/os-release
echo "$ID"
}

# Detect package manager
detect_package_manager() {
case "$1" in
ubuntu|debian|kali)
echo "apt"
;;

rhel|rocky|almalinux)
echo "dnf"
;;

arch)
echo "pacman"
;;
*)
echo "unknown"
;;
esac
}

# Load distribution adapter
load_adapter() {
local distro="$1"
if [[ -f "$SCRIPT_DIR/adapters/${distro}.sh" ]]; then
source "$SCRIPT_DIR/adapters/${distro}.sh"
echo "$ADAPTER_NAME"
else
echo "Unsupported Distribution"
fi
}