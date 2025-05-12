#!/bin/bash -eux

# Install necessary packages for Vagrant
if [ -f /etc/fedora-release ]; then
    # Fedora
    dnf -y install gcc make perl kernel-devel kernel-headers bzip2
elif [ -f /etc/debian_version ]; then
    # Debian/Ubuntu
    apt-get -y install gcc make perl linux-headers-$(uname -r) bzip2
elif [ -f /etc/redhat-release ]; then
    # RHEL/CentOS/AlmaLinux
    dnf -y install gcc make perl kernel-devel kernel-headers bzip2
fi

# Install VirtualBox Guest Additions if not using libvirt
if [ ! -f /etc/vagrant-libvirt ]; then
    # This is a placeholder - in a real environment, you'd need to mount the
    # VirtualBox Guest Additions ISO and run the installer
    echo "VirtualBox Guest Additions installation would go here"
fi

# Configure password-less sudo for the vagrant user
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant

# Set up SSH for Vagrant
mkdir -p /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh