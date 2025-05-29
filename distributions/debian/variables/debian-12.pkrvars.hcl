# Debian 12 (Bookworm) variables

version = "12"

// x86_64 specific
x86_64_iso_url = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.11.0-amd64-netinst.iso"
x86_64_iso_checksum = "sha256:30ca12a15cae6a1033e03ad59eb7f66a6d5a258dcf27acd115c2bd42d22640e8"

// arm64 specific
arm64_iso_url = "https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-12.11.0-arm64-netinst.iso"
arm64_iso_checksum = "sha256:5c050c495770ee9b076261cb8025a99a4866a15a4e3cdab2f59c49e8f69fb0ee"

boot_command = [
  "<esc><wait>",
  "install <wait>",
  "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>",
  "debian-installer=en_GB <wait>",
  "auto <wait>",
  "locale=en_GB <wait>",
  "kbd-chooser/method=us <wait>",
  "keyboard-configuration/xkb-keymap=us <wait>",
  "netcfg/get_hostname=debian-12 <wait>",
  "netcfg/get_domain=localdomain <wait>",
  "fb=false <wait>",
  "debconf/frontend=noninteractive <wait>",
  "console-setup/ask_detect=false <wait>",
  "console-keymaps-at/keymap=us <wait>",
  "<enter><wait>"
]