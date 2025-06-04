# Ubuntu 24.04 LTS variables

version = "24.04"

// x86_64 specific
x86_64_iso_url = "https://releases.ubuntu.com/24.04/ubuntu-24.04.1-live-server-amd64.iso"
x86_64_iso_checksum = "sha256:e240e4b801f7bb68c20d1356b60968ad0c33a41d00d828e74ceb3364a0317be9"

// arm64 specific
arm64_iso_url = "https://cdimage.ubuntu.com/releases/24.04/release/ubuntu-24.04.1-live-server-arm64.iso"
arm64_iso_checksum = "sha256:4737ec8c4f3c8c1b5e2b3e3e4b3e3e4b3e3e4b3e3e4b3e3e4b3e3e4b3e3e4b3e"

boot_command = [
  "<enter><wait><f6><wait><esc><wait>",
  "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
  "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
  "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
  "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
  "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
  "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
  "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
  "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
  "<bs><bs><bs>",
  "/casper/vmlinuz ",
  "initrd=/casper/initrd ",
  "autoinstall ",
  "keyboard-configuration/xkb-keymap=us ",
  "debconf/frontend=noninteractive ",
  "netcfg/choose_interface=auto ",
  "netcfg/get_hostname=ubuntu-24.04 ",
  "netcfg/get_domain=localdomain ",
  "ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
  "<enter>"
]