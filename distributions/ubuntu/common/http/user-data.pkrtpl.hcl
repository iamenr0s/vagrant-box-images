#cloud-config
autoinstall:
  version: 1
  interactive-sections: []
  
  # Refresh installer
  refresh-installer:
    update: false
  
  # Source configuration - critical for preventing prompts
  source:
    search_drivers: false
    id: ubuntu-server-minimal
  
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
  
  # Explicit storage configuration with layout name
  storage:
    layout:
      name: direct
      sizing-policy: scaled
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
    authorized-keys: []
  
  # APT configuration - critical for preventing mirror prompts
  apt:
    preserve_sources_list: false
    primary:
      - arches: [amd64, i386]
        uri: http://archive.ubuntu.com/ubuntu
      - arches: [default]
        uri: http://ports.ubuntu.com/ubuntu-ports
    security:
      - arches: [amd64, i386]
        uri: http://security.ubuntu.com/ubuntu
      - arches: [default]
        uri: http://ports.ubuntu.com/ubuntu-ports
    sources:
      ubuntu-toolchain-r-test:
        source: "deb http://archive.ubuntu.com/ubuntu $RELEASE main restricted universe multiverse"
        key: |
          -----BEGIN PGP PUBLIC KEY BLOCK-----
          
          mQINBFufwdoBEADkqnxzIEtMFYvzqLpTBTpQTquGCoVWCYNKwKoKe0G6mEs7CKNG
          ...
          -----END PGP PUBLIC KEY BLOCK-----
    geoip: false
    disable_components: []
    
  # Package selection - explicit minimal set
  packages:
    - openssh-server
    - python3
    - python3-pip
    - curl
    - wget
  
  # Snap configuration - disable to prevent prompts
  snaps:
    - name: core
      channel: stable
      classic: false
  
  # User data
  user-data:
    disable_root: true
    preserve_hostname: false
  
  # Updates configuration
  updates: security
  
  # Late commands
  late-commands:
    - echo 'vagrant ALL=(ALL) NOPASSWD:ALL' > /target/etc/sudoers.d/vagrant
    - chmod 440 /target/etc/sudoers.d/vagrant
    - mkdir -p /target/home/vagrant/.ssh
    - chmod 700 /target/home/vagrant/.ssh
    - chown 1000:1000 /target/home/vagrant/.ssh
    - 'DEBIAN_FRONTEND=noninteractive apt-get -y update'
    - 'DEBIAN_FRONTEND=noninteractive apt-get -y upgrade'
  
  # Reporting configuration
  reporting:
    builtin:
      type: print
  
  # Error commands
  error-commands:
    - /bin/true