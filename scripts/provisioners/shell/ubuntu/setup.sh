#!/bin/bash
# Ubuntu-specific setup script

echo "==> Setting up Ubuntu-specific configurations"

# Install Ubuntu-specific packages
apt-get install -y \
    cloud-init \
    cloud-utils \
    open-vm-tools \
    qemu-guest-agent

# Enable services
systemctl enable qemu-guest-agent

# Configure cloud-init if needed
if [ -d /etc/cloud ]; then
    # Disable cloud-init from running on every boot
    touch /etc/cloud/cloud-init.disabled
fi

# Configure network for Vagrant
cat > /etc/netplan/01-netcfg.yaml << EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: true
EOF

echo "==> Ubuntu setup completed"