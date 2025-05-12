#!/bin/bash
# Rocky Linux-specific setup script

echo "==> Setting up Rocky Linux-specific configurations"

# Install Rocky Linux-specific packages
dnf install -y \
    NetworkManager \
    cloud-init \
    cloud-utils-growpart \
    open-vm-tools \
    qemu-guest-agent

# Enable services
systemctl enable NetworkManager
systemctl enable qemu-guest-agent

# Configure cloud-init if needed
if [ -d /etc/cloud ]; then
    # Disable cloud-init from running on every boot
    touch /etc/cloud/cloud-init.disabled
fi

# Configure network for Vagrant
cat > /etc/sysconfig/network-scripts/ifcfg-eth0 << EOF
DEVICE="eth0"
BOOTPROTO="dhcp"
ONBOOT="yes"
TYPE="Ethernet"
PERSISTENT_DHCLIENT="yes"
EOF

echo "==> Rocky Linux setup completed"