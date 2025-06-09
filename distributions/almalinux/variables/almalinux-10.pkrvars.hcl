// AlmaLinux 10 specific variables

version = "10"

// x86_64 specific
x86_64_iso_url = "https://repo.almalinux.org/almalinux/10/isos/x86_64/AlmaLinux-10.0-x86_64-minimal.iso"
x86_64_iso_checksum = "sha256:e73ccc95ff21a43ab23eebe227257fa34df091570b2bcf8a23f918bf9b662fc3"
x86_64_install_url = "https://repo.almalinux.org/almalinux/10/BaseOS/x86_64/os/"

// arm64 specific
arm64_iso_url = "https://repo.almalinux.org/almalinux/10/isos/aarch64/AlmaLinux-10.0-aarch64-minimal.iso"
arm64_iso_checksum = "sha256:6257c3425b634c0cef9016e008627584f7eb96b09d27c521a0cb299409293dab"
arm64_install_url = "https://repo.almalinux.org/almalinux/10/BaseOS/aarch64/os/"

// AlmaLinux 10 specific boot command
boot_command = ["<up>e", "<down><down><end>", " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg inst.cmdline inst.headless ip=dhcp", "<leftCtrlOn>x<leftCtrlOff>"]