#cloud-config
autoinstall:
  version: 1
  interactive-sections: []
  
  # Refresh installer
  refresh-installer:
    update: false
  
  # Locale configuration
  locale: en_US.UTF-8
  
  # Keyboard configuration
  keyboard:
    layout: us
    variant: ""
  
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
  
  # Explicit storage configuration to prevent prompts
  storage:
    config:
      - type: disk
        id: disk0
        match:
          size: largest
        wipe: superblock-recursive
        preserve: false
        grub_device: false
      - type: partition
        id: boot-partition
        device: disk0
        size: 1G
        wipe: superblock
        flag: boot
        number: 1
        preserve: false
        grub_device: true
      - type: partition
        id: lvm-partition
        device: disk0
        size: -1
        wipe: superblock
        flag: ""
        number: 2
        preserve: false
      - type: lvm_volgroup
        id: ubuntu-vg
        name: ubuntu-vg
        devices:
          - lvm-partition
        preserve: false
      - type: lvm_partition
        id: root-lv
        name: ubuntu-lv
        volgroup: ubuntu-vg
        size: -1
        wipe: superblock
        preserve: false
      - type: format
        id: boot-fs
        volume: boot-partition
        fstype: ext4
        preserve: false
      - type: format
        id: root-fs
        volume: root-lv
        fstype: ext4
        preserve: false
      - type: mount
        id: boot-mount
        device: boot-fs
        path: /boot
      - type: mount
        id: root-mount
        device: root-fs
        path: /
    swap:
      size: 0
  
  # Identity configuration
  identity:
    hostname: ubuntu-${version}
    username: vagrant
    password: '$6$rounds=4096$saltsalt$L9tjczoIVP68LKlz5COoo5NP.4HBOjZOBY/FSHhHZrVfuY6NK.n3rOx6qX.T5tMh.VjfYGqnAb9nuZQhxpL5e1'
  
  # SSH configuration
  ssh:
    install-server: true
    allow-pw: true
  
  # Package selection
  packages:
    - openssh-server
    - python3
    - python3-pip
  
  # Updates
  updates: security
  
  # Late commands
  late-commands:
    - echo 'vagrant ALL=(ALL) NOPASSWD:ALL' > /target/etc/sudoers.d/vagrant
    - chmod 440 /target/etc/sudoers.d/vagrant
    - mkdir -p /target/home/vagrant/.ssh
    - chmod 700 /target/home/vagrant/.ssh
    - chown 1000:1000 /target/home/vagrant/.ssh
    - 'DEBIAN_FRONTEND=noninteractive apt-get -y update'
  
  # Reporting configuration to suppress prompts
  reporting:
    builtin:
      type: print
  
  # Error commands
  error-commands:
    - /bin/true