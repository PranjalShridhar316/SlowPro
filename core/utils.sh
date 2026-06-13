#!/bin/bash

#SlowPro utility function
#common helper functiion accross the moduel

#ensures SlowPro is executed with root prevliges
#some forensic artifacts requir elivated access

check_root(){
if [[ $EUID -ne 0 ]]; then
echo "[ERROR] Please run SlowPro as root."
exit 1
fi
}
