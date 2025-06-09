# Debian preseed configuration
d-i debian-installer/locale string en_GB.UTF-8
d-i console-setup/ask_detect boolean false
d-i keyboard-configuration/layoutcode string us

# Network configuration
d-i netcfg/choose_interface select auto
d-i netcfg/get_hostname string debian-${version}
d-i netcfg/get_domain string localdomain

# Mirror settings
d-i mirror/country string manual
d-i mirror/http/hostname string deb.debian.org
d-i mirror/http/directory string /debian
d-i mirror/http/proxy string

# APT configuration - Skip scanning additional media and external repos
d-i apt-setup/cdrom/set-first boolean false
d-i apt-setup/cdrom/set-next boolean false
d-i apt-setup/cdrom/set-failed boolean false
d-i apt-setup/use_mirror boolean true
d-i apt-setup/services-select multiselect none
d-i apt-setup/security_host string
d-i apt-setup/volatile_host string

# Account setup
# Root password configuration
d-i passwd/root-login boolean true
d-i passwd/root-password password vagrant
d-i passwd/root-password-again password vagrant

# User account configuration
d-i passwd/user-fullname string Vagrant User
d-i passwd/username string vagrant
d-i passwd/user-password password vagrant
d-i passwd/user-password-again password vagrant
d-i user-setup/allow-password-weak boolean true
d-i user-setup/encrypt-home boolean false

# Clock and time zone setup
d-i clock-setup/utc boolean true
d-i time/zone string Europe/London
d-i clock-setup/ntp boolean true

# Partitioning
d-i partman-auto/method string lvm
d-i partman-lvm/device_remove_lvm boolean true
d-i partman-md/device_remove_md boolean true
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm_nooverwrite boolean true
d-i partman-auto-lvm/guided_size string max
d-i partman-auto/choose_recipe select atomic
d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true

# Base system installation
d-i base-installer/install-recommends boolean false
d-i base-installer/kernel/image string linux-image-generic

# Package selection
tasksel tasksel/first multiselect standard
d-i pkgsel/include string openssh-server curl wget vim git qemu-guest-agent sudo
d-i pkgsel/upgrade select full-upgrade
d-i pkgsel/update-policy select none

# Popularity contest configuration - Skip participation
popularity-contest popularity-contest/participate boolean false

# Boot loader installation
d-i grub-installer/only_debian boolean true
d-i grub-installer/with_other_os boolean true
d-i grub-installer/bootdev string default

# Finishing up the installation
d-i finish-install/reboot_in_progress note

# Late commands
d-i preseed/late_command string \
    echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /target/etc/sudoers.d/vagrant; \
    chmod 0440 /target/etc/sudoers.d/vagrant; \
    mkdir -p /target/home/vagrant/.ssh; \
    chmod 700 /target/home/vagrant/.ssh; \
    echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key' > /target/home/vagrant/.ssh/authorized_keys; \
    chmod 600 /target/home/vagrant/.ssh/authorized_keys; \
    chown -R 1000:1000 /target/home/vagrant/.ssh; \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /target/etc/ssh/sshd_config; \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /target/etc/ssh/sshd_config; \
    sed -i 's/#UseDNS yes/UseDNS no/' /target/etc/ssh/sshd_config