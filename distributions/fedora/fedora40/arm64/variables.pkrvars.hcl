// Fedora 39 arm64 specific variables

architecture = "arm64"
iso_url = "https://download.fedoraproject.org/pub/fedora/linux/releases/39/Server/aarch64/iso/Fedora-Server-dvd-aarch64-39-1.5.iso"
iso_checksum = "sha256:c8b19a5a0a3a5c5dd4d9f5f0e8a4293d2f4164a0abe94d7c0f4bd6ca9c0c0ab4"
http_directory = "distributions/fedora/fedora39/arm64/http"
qemu_binary = "qemu-system-aarch64"

boot_command = [
  "<tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"
]