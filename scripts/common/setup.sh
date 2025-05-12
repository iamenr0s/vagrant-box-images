#!/bin/bash
# Common setup script for all distributions

echo "==> Installing common packages"
if [ -f /etc/debian_release ] || [ -f /etc/debian_version ] || grep -q 'ID=ubuntu' /etc/os-release || grep -q 'ID=debian' /etc/os-release; then
    # Ubuntu/Debian
    apt-get install -y \
        curl \
        wget \
        vim \
        git \
        openssh-server \
        sudo
elif [ -f /etc/redhat-release ] || grep -q 'ID="fedora"' /etc/os-release || grep -q 'ID="rocky"' /etc/os-release || grep -q 'ID="almalinux"' /etc/os-release; then
    # RHEL-based (Fedora, Rocky, AlmaLinux)
    dnf install -y \
        curl \
        wget \
        vim \
        git \
        openssh-server \
        sudo
else
    echo "==> Unsupported distribution, skipping package installation"
fi

echo "==> Setting up vagrant user"
if ! id -u vagrant >/dev/null 2>&1; then
    useradd -m -s /bin/bash vagrant
    echo "vagrant:vagrant" | chpasswd
fi

# Add vagrant user to sudoers
if [ -d /etc/sudoers.d ]; then
    echo "vagrant ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/vagrant
    chmod 0440 /etc/sudoers.d/vagrant
fi

# Set up SSH for vagrant user
mkdir -p /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

echo "==> Common setup completed"