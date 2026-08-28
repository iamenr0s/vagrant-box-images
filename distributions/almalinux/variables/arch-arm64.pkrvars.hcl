// arm64 architecture specific variables

architecture = "arm64"
qemu_binary = "qemu-system-aarch64"
cpus = "4"
memory = "4096"
boot_command = ["<wait5>c", "linux /images/pxeboot/vmlinuz inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg console=ttyS0", "<enter>", "initrd /images/pxeboot/initrd.img", "<enter>", "boot", "<enter>"]

qemu_args = [
  ["-m", "2048"],
  ["-smp", "2"],
  ["-machine", "virt"],
  ["-cpu", "cortex-a57"],
  ["-bios", "/usr/share/AAVMF/AAVMF_CODE.fd"],
  ["-display", "none"]
]