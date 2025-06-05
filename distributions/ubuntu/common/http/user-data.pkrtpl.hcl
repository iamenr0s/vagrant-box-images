
#cloud-config
autoinstall:
  version: 1
  identity:
    hostname: ubuntu
    username: vagrant
    password: $6$vshRxzaB0gSkSGVq$fru9FpuDT8PJlRTESOQx.xteyJv8U1nuuMPGOz9LQKFDJYfMB2EzIfg4p0NiPTaShyLMzqsvTPGTHkL2huZ3h.
  user-data:
    disable_root: false
  keyboard:
    layout: us
  locale: en_US
  network:
    ethernets:
      eth0:
        dhcp4: true
        dhcp-identifier: mac
    version: 2
  ssh:
    allow-pw: true
    install-server: true
  storage:
    layout:
      name: lvm
      sizing-policy: scaled
      reset-partition-table: true
    swap:
      size: 0
  late-commands:
    - sed -i -e 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /target/etc/ssh/sshd_config
    - sed -i -e 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /target/etc/ssh/sshd_config
    - echo 'vagrant ALL=(ALL) NOPASSWD:ALL' > /target/etc/sudoers.d/vagrant
    - sed -ie 's/GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX="net.ifnames=0 ipv6.disable=1 biosdevname=0"/' /target/etc/default/grub
    - curtin in-target --target /target update-grub2
  packages:
    - bc
    - curl
    - wget
    - openssh-server
#    - qemu-guest-agent