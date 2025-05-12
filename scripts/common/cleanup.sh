#!/bin/bash
# Common cleanup script for all distributions

echo "==> Cleaning up temporary files"
if [ -f /etc/debian_release ] || [ -f /etc/debian_version ] || grep -q 'ID=ubuntu' /etc/os-release || grep -q 'ID=debian' /etc/os-release; then
    # Ubuntu/Debian
    apt-get clean
    apt-get autoremove -y
elif [ -f /etc/redhat-release ] || grep -q 'ID="fedora"' /etc/os-release || grep -q 'ID="rocky"' /etc/os-release || grep -q 'ID="almalinux"' /etc/os-release; then
    # RHEL-based (Fedora, Rocky, AlmaLinux)
    dnf clean all
    rm -rf /var/cache/dnf/*
else
    echo "==> Unsupported distribution, skipping cleanup"
fi

# Remove temporary files
rm -rf /tmp/*
rm -f /var/log/wtmp /var/log/btmp
rm -f /var/log/*.log
rm -f /var/log/messages*
rm -f /var/log/dmesg*

# Clear bash history
cat /dev/null > ~/.bash_history
history -c

echo "==> Cleanup completed"