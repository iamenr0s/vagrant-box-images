# Debian 11 (Bullseye) variables

version = "11"

// x86_64 specific
x86_64_iso_url = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.8.0-amd64-netinst.iso"
x86_64_iso_checksum = "sha256:f3c1c6fdba0f5b5b2b4b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b"

// arm64 specific
arm64_iso_url = "https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-11.8.0-arm64-netinst.iso"
arm64_iso_checksum = "sha256:f3c1c6fdba0f5b5b2b4b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b3b"

boot_command = [
  "<esc><wait>",
  "install <wait>",
  "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>",
  "debian-installer=en_GB <wait>",
  "auto <wait>",
  "locale=en_GB <wait>",
  "kbd-chooser/method=us <wait>",
  "keyboard-configuration/xkb-keymap=us <wait>",
  "netcfg/get_hostname=debian-11 <wait>",
  "netcfg/get_domain=localdomain <wait>",
  "fb=false <wait>",
  "debconf/frontend=noninteractive <wait>",
  "console-setup/ask_detect=false <wait>",
  "console-keymaps-at/keymap=us <wait>",
  "<enter><wait>"
]