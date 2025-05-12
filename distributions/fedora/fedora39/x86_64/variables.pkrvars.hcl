// Fedora 39 x86_64 specific variables

architecture = "x86_64"
iso_url = "https://download.fedoraproject.org/pub/fedora/linux/releases/39/Server/x86_64/iso/Fedora-Server-dvd-x86_64-39-1.5.iso"
iso_checksum = "sha256:2755cdff6ac6365c75be60334bf1935ade838fc18de53d4c640a13d3e904f6e9"
http_directory = "distributions/fedora/fedora39/x86_64/http"
qemu_binary = "qemu-system-x86_64"

boot_command = [
  "<tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"
]