#cloud-config
autoinstall:
  version: 1
  interactive-sections: []
  
  # Locale and keyboard
  locale: en_GB.UTF-8
  keyboard:
    layout: us
    variant: ''
  
  # Network configuration
  network:
    network:
      version: 2
      ethernets:
        ens3:
          dhcp4: true
        eth0:
          dhcp4: true
        enp0s3:
          dhcp4: true
  
  # Storage configuration with explicit automation
  storage:
    layout:
      name: lvm
    config:
      - type: disk
        id: disk0
        match:
          size: largest
      - type: partition
        id: boot-partition
        device: disk0
        size: 1G
        flag: boot
      - type: partition
        id: lvm-partition
        device: disk0
        size: -1
      - type: lvm_volgroup
        id: ubuntu-vg
        name: ubuntu-vg
        devices:
          - lvm-partition
      - type: lvm_partition
        id: root-lv
        name: root
        volgroup: ubuntu-vg
        size: -1
      - type: format
        id: boot-fs
        volume: boot-partition
        fstype: ext4
      - type: format
        id: root-fs
        volume: root-lv
        fstype: ext4
      - type: mount
        id: boot-mount
        device: boot-fs
        path: /boot
      - type: mount
        id: root-mount
        device: root-fs
        path: /
  
  # User identity
  identity:
    hostname: ubuntu-${version}
    username: vagrant
    password: '$6$rounds=4096$saltsalt$L9tjczoIVP68LKlz5COoo5NP.4HBOjZOBY/FSHhHZrVfuY6NK.n3rOx6qX.T5tMh.VjfYGqnAb9nuZQhxpL5e1'
  
  # SSH configuration
  ssh:
    install-server: true
    allow-pw: true
  
  # APT configuration to avoid ALL prompts
  apt:
    preserve_sources_list: false
    disable_components: []
    geoip: false
    primary:
      - arches: [amd64, i386]
        uri: http://archive.ubuntu.com/ubuntu
      - arches: [arm64, armhf, powerpc, ppc64el, s390x]
        uri: http://ports.ubuntu.com/ubuntu-ports
    security:
      - arches: [amd64, i386]
        uri: http://security.ubuntu.com/ubuntu
      - arches: [arm64, armhf, powerpc, ppc64el, s390x]
        uri: http://ports.ubuntu.com/ubuntu-ports
    sources_list: |
      deb http://archive.ubuntu.com/ubuntu $RELEASE main restricted universe multiverse
      deb http://archive.ubuntu.com/ubuntu $RELEASE-updates main restricted universe multiverse
      deb http://security.ubuntu.com/ubuntu $RELEASE-security main restricted universe multiverse
    conf: |
      APT::Install-Recommends "false";
      APT::Install-Suggests "false";
      APT::Get::Assume-Yes "true";
      Dpkg::Options {
        "--force-confdef";
        "--force-confold";
      }
  
  # Package installation - minimal set to avoid prompts
  packages:
    - openssh-server
    - python3
    - python3-pip
    - curl
    - wget
  
  # Snap configuration to avoid prompts
  snaps:
    - name: core
      classic: false
  
  # User data to prevent any interactive prompts
  user-data:
    disable_root: false
    ssh_pwauth: true
    package_update: false
    package_upgrade: false
    package_reboot_if_required: false
  
  # Late commands for vagrant setup
  late-commands:
    - echo 'vagrant ALL=(ALL) NOPASSWD:ALL' > /target/etc/sudoers.d/vagrant
    - chmod 440 /target/etc/sudoers.d/vagrant
    - mkdir -p /target/home/vagrant/.ssh
    - chmod 700 /target/home/vagrant/.ssh
    - chown 1000:1000 /target/home/vagrant/.ssh
    - 'echo "Acquire::Check-Valid-Until false;" > /target/etc/apt/apt.conf.d/99no-check-valid-until'
    - 'echo "APT::Get::Assume-Yes true;" >> /target/etc/apt/apt.conf.d/99no-prompts'
    - 'echo "Dpkg::Options { \"--force-confdef\"; \"--force-confold\"; }" >> /target/etc/apt/apt.conf.d/99no-prompts'
  
  # Ensure no interactive prompts and automatic completion
  updates: security
  refresh-installer:
    update: false
    channel: stable
  
  # Autoinstall reporting to suppress prompts
  reporting:
    builtin:
      type: print
  
  # Error handling to continue on errors
  error-commands:
    - /bin/true