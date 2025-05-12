#!/bin/bash
# Common update script for all distributions

echo "==> Updating package lists"
if [ -f /etc/debian_release ] || [ -f /etc/debian_version ] || grep -q 'ID=ubuntu' /etc/os-release || grep -q 'ID=debian' /etc/os-release; then
    # Ubuntu/Debian
    apt-get update -y
    apt-get upgrade -y
elif [ -f /etc/redhat-release ] || grep -q 'ID="fedora"' /etc/os-release || grep -q 'ID="rocky"' /etc/os-release || grep -q 'ID="almalinux"' /etc/os-release; then
    # RHEL-based (Fedora, Rocky, AlmaLinux)
    dnf update -y
else
    echo "==> Unsupported distribution, skipping updates"
fi

echo "==> Update completed"