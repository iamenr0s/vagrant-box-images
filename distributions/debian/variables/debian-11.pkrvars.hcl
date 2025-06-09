# Debian 11 (Bullseye) variables

version = "11"

// x86_64 specific
x86_64_iso_url = "https://get.debian.org/images/archive/11.11.0/amd64/iso-cd/debian-11.11.0-amd64-netinst.iso"
x86_64_iso_checksum = "sha256:cd5b2a6fc22050affa1d141adb3857af07e94ff886dca1ce17214e2761a3b316"

// arm64 specific
arm64_iso_url = "https://get.debian.org/images/archive/11.11.0/arm64/iso-cd/debian-11.11.0-arm64-netinst.iso"
arm64_iso_checksum = "sha256:c81b6081d5dc5cfac49310b104eb9843252fd3c97cedbcd69ec0388798e7ef7e"

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