// Fedora 39 arm64 specific variables

architecture = "arm64"
iso_url = "https://fedora.mirrorservice.org/fedora/linux/releases/40/Server/aarch64/iso/Fedora-Server-netinst-aarch64-40-1.14.iso"
iso_checksum = "sha256:690731ac6abba81413d97517baa80841cb122d07b296ec3f2935848be45be8fe"
http_directory = "distributions/fedora/fedora40/arm64/http"
qemu_binary = "qemu-system-aarch64"

boot_command = [
  "<tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"
]