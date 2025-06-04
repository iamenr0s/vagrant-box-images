# Ubuntu 20.04 LTS variables

version = "20.04"

// x86_64 specific
x86_64_iso_url = "https://releases.ubuntu.com/20.04/ubuntu-20.04.6-live-server-amd64.iso"
x86_64_iso_checksum = "sha256:b8f31413336b9393ad5d8ef0282717b2ab19f007df2e9ed5196c13d8f9153c8b"

// arm64 specific
arm64_iso_url = "https://cdimage.ubuntu.com/releases/20.04/release/ubuntu-20.04.6-live-server-arm64.iso"
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
  "quiet ",
  "splash ",
  "fsck.mode=skip ",
  "keyboard-configuration/xkb-keymap=us ",
  "debconf/frontend=noninteractive ",
  "debconf/priority=critical ",
  "DEBIAN_FRONTEND=noninteractive ",
  "netcfg/choose_interface=auto ",
  "netcfg/get_hostname=ubuntu-20.04 ",
  "netcfg/get_domain=localdomain ",
  "cloud-config-url=/dev/null ",
  "ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
  "<enter>"
]