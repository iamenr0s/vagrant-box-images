// Fedora 39 x86_64 specific variables

architecture = "x86_64"
iso_url = "https://fedora.mirrorservice.org/fedora/linux/releases/40/Server/x86_64/iso/Fedora-Server-netinst-x86_64-40-1.14.iso"
iso_checksum = "sha256:1b4f163c55aa9b35bb08f3d465534aa68899a4984b8ba8976b1e7b28297b61fe"
http_directory = "distributions/fedora/fedora40/x86_64/http"
qemu_binary = "/usr/bin/qemu-system-x86_64"

boot_command = ["<up>e", "<down><down><end>", " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg", "<leftCtrlOn>x<leftCtrlOff>"]
