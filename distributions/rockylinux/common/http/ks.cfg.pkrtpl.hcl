url --url="${install_url}"
text
firstboot --disable
keyboard --vckeymap=us --xlayouts='us'
lang en_UK.UTF-8
network --bootproto=dhcp --device=eth0 --ipv6=auto --activate
network --hostname=rockylinux-"${version}".localdomain
selinux --disabled
timezone Europe/London --utc
bootloader --location=mbr --append=" net.ifnames=0 biosdevname=0 crashkernel=no"
# Set a root password (replace 'password' with your desired password)
rootpw password --plaintext
# Create a user (recommended approach)
user --name=vagrant --groups=wheel --password=vagrant --plaintext
# Clear the Master Boot Record
zerombr
# Remove partitions
clearpart --all --initlabel
# Automatically create partitions using LVM
autopart --type=lvm
# Reboot after successful installation
reboot

%packages --excludedocs
sudo
qemu-guest-agent
openssh-server
-kexec-tools
-dracut-config-rescue
-plymouth*
-iwl*firmware
%end

%addon com_redhat_kdump --disable
%end

# Disable unnecessary services
services --disabled=kdump,tuned,firewalld

%post
# Enable sshd and disable firewalld
/usr/bin/systemctl enable sshd
/usr/bin/systemctl start sshd
/usr/bin/systemctl disable firewalld

# Need for host/guest communication
/usr/bin/systemctl enable qemu-guest-agent
/usr/bin/systemctl start qemu-guest-agent

# Update grub config
grub2-mkconfig -o /boot/grub2/grub.cfg
%end

%post
# Configure sudo
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant

# Configure SSH for Vagrant
sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config

# Create vagrant user SSH directory
mkdir -p /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh

# Add Vagrant insecure public key
cat > /home/vagrant/.ssh/authorized_keys << 'EOF'
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
EOF

# Set permissions on the key
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh
%end