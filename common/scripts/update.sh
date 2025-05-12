#!/bin/bash -eux

# Update the system
if [ -f /etc/fedora-release ]; then
    # Fedora
    dnf -y update
elif [ -f /etc/debian_version ]; then
    # Debian/Ubuntu
    apt-get update
    apt-get -y dist-upgrade
elif [ -f /etc/redhat-release ]; then
    # RHEL/CentOS/AlmaLinux
    dnf -y update
fi