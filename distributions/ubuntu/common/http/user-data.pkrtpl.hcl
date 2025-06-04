#cloud-config
autoinstall:
  version: 1
  interactive-sections: []
  locale: en_GB.UTF-8
  keyboard:
    layout: us
    variant: ''
  network:
    network:
      version: 2
      ethernets:
        ens3:
          dhcp4: true
  storage:
    layout:
      name: lvm
  identity:
    hostname: ubuntu-${version}
    username: vagrant
    password: '$6$rounds=4096$saltsalt$L9tjczoIVP68LKlz5COoo5NP.4HBOjZOBY/FSHhHZrVfuY6NK.n3rOx6qX.T5tMh.VjfYGqnAb9nuZQhxpL5e1'
  ssh:
    install-server: true
    allow-pw: true
  packages:
    - openssh-server
    - python3
    - python3-pip
  late-commands:
    - echo 'vagrant ALL=(ALL) NOPASSWD:ALL' > /target/etc/sudoers.d/vagrant
    - chmod 440 /target/etc/sudoers.d/vagrant