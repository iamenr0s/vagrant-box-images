#cloud-config
autoinstall:
  version: 1
  interactive-sections: []
  
  # Refresh installer to avoid prompts
  refresh-installer:
    update: false
    channel: "stable/ubuntu-${version}"
  
  # Locale configuration
  locale: en_US.UTF-8
  
  # Keyboard configuration
  keyboard:
    layout: us
    variant: ""
    toggle: null
  
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
  
  # Source configuration to avoid prompts
  source:
    search_drivers: false
    id: ubuntu-server-minimal
  
  # Storage configuration
  storage:
    layout:
      name: lvm
      match:
        size: largest
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
  
  # APT configuration to prevent all prompts
  apt:
    preserve_sources_list: false
    disable_components: []
    geoip: false
    sources:
      ubuntu.sources:
        source: |
          Types: deb
          URIs: http://archive.ubuntu.com/ubuntu
          Suites: $RELEASE $RELEASE-updates $RELEASE-security
          Components: main restricted universe multiverse
          Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
  
  # Package selection - minimal to avoid prompts
  packages:
    - openssh-server
    - python3
    - python3-pip
  
  # Updates configuration
  updates: security
  
  # Late commands for vagrant setup
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