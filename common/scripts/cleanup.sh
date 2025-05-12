#!/bin/bash -eux

# Clean up package cache
if [ -f /etc/fedora-release ]; then
    # Fedora
    dnf clean all
elif [ -f /etc/debian_version ]; then
    # Debian/Ubuntu
    apt-get -y autoremove
    apt-get -y clean
elif [ -f /etc/redhat-release ]; then
    # RHEL/CentOS/AlmaLinux
    dnf clean all
fi

# Remove temporary files
rm -rf /tmp/*

# Zero out free space to save space in the final image
dd if=/dev/zero of=/EMPTY bs=1M || echo "dd exit code $? is suppressed"
rm -f /EMPTY

# Sync to ensure all writes are flushed to disk
sync