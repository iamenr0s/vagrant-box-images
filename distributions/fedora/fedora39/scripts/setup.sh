#!/bin/bash -eux

# Install additional packages for Fedora
dnf -y install \
  vim \
  wget \
  curl \
  git \
  bash-completion \
  cloud-init \
  cloud-utils-growpart \
  NetworkManager \
  qemu-guest-agent

# Enable services
systemctl enable NetworkManager
systemctl enable qemu-guest-agent

# Configure cloud-init for Vagrant
cat > /etc/cloud/cloud.cfg.d/90_vagrant.cfg << 'EOF'
datasource_list: [ NoCloud, ConfigDrive, None ]
EOF

# Disable NetworkManager's DNS management to avoid overwriting /etc/resolv.conf
cat > /etc/NetworkManager/conf.d/90-dns-none.conf << 'EOF'
[main]
dns=none
EOF