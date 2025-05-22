// Fedora 40 arm64 specific variables

iso_url = "https://fedora.mirrorservice.org/fedora/linux/releases/40/Server/aarch64/iso/Fedora-Server-netinst-aarch64-40-1.14.iso"
iso_checksum = "sha256:690731ac6abba81413d97517baa80841cb122d07b296ec3f2935848be45be8fe"
http_directory = "."
qemu_binary = "qemu-system-aarch64"

boot_command = ["<up>e", "<down><down><end>", " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg", "<leftCtrlOn>x<leftCtrlOff>"]