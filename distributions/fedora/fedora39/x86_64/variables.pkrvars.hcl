// Fedora 39 x86_64 specific variables

architecture = "x86_64"
iso_url = "https://ask4.mm.fcix.net/fedora/linux/releases/39/Server/x86_64/iso/Fedora-Server-netinst-x86_64-39-1.5.iso"
iso_checksum = "sha256:61576ae7170e35210f03aae3102048f0a9e0df7868ac726908669b4ef9cc22e9"
http_directory = "distributions/fedora/fedora39/x86_64/http"
qemu_binary = "/usr/bin/qemu-system-x86_64"

boot_command =  ["<up>e", "<down><down><end>", " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg", "<leftCtrlOn>x<leftCtrlOff>"]