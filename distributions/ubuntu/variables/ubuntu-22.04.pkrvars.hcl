# Ubuntu 22.04 LTS variables

version = "22.04"

// x86_64 specific
x86_64_iso_url = "https://releases.ubuntu.com/22.04/ubuntu-22.04.5-live-server-amd64.iso"
x86_64_iso_checksum = "sha256:45f873de9f8cb637345d6e66a583762730bbea30277ef7b32c9c3bd6700a32b2"

// arm64 specific
arm64_iso_url = "https://cdimage.ubuntu.com/releases/22.04/release/ubuntu-22.04.4-live-server-arm64.iso"
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
  "ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
  "<enter>"
]