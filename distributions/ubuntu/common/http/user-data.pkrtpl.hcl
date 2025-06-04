#cloud-config
autoinstall:
  version: 1
  interactive-sections: []
  
  # Minimal locale
  locale: en_US.UTF-8
  
  # Minimal keyboard
  keyboard:
    layout: us
  
  # Minimal identity - this is REQUIRED
  identity:
    hostname: ubuntu-${version}
    username: vagrant
    password: '$6$rounds=4096$saltsalt$L9tjczoIVP68LKlz5COoo5NP.4HBOjZOBY/FSHhHZrVfuY6NK.n3rOx6qX.T5tMh.VjfYGqnAb9nuZQhxpL5e1'
  
  # Minimal SSH
  ssh:
    install-server: true
    allow-pw: true
  
  # CRITICAL: Minimal storage with direct layout
  storage:
    layout:
      name: direct
  
  # Disable all optional features that could cause prompts
  source:
    search_drivers: false
  
  # Minimal packages
  packages:
    - openssh-server
  
  # Disable updates during install
  updates: security
  
  # Essential late commands only
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