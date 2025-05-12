// Fedora 39 x86_64 specific variables

architecture = "x86_64"
iso_url = "https://download.fedoraproject.org/pub/fedora/linux/releases/39/Server/x86_64/iso/Fedora-Server-dvd-x86_64-39-1.5.iso"
iso_checksum = "sha256:c1b48c3de69e4d361f179db64e3d181e3b18f3f248d7d1a5d6342e8f5eaae94f"
http_directory = "distributions/fedora/fedora39/x86_64/http"
qemu_binary = "qemu-system-x86_64"

boot_command = [
  "<tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"
]