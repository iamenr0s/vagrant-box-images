// arm64 architecture specific variables

architecture = "arm64"
qemu_binary = "qemu-system-aarch64"
cpus = "4"
memory = "4096"
# GRUB2-style boot command for ARM64 UEFI
boot_command = ["<wait5>c", "linux /images/pxeboot/vmlinuz inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg console=ttyS0 inst.cmdline inst.headless", "<enter>", "initrd /images/pxeboot/initrd.img", "<enter>", "boot", "<enter>"]

qemu_args = [
  ["-m", "2048"],
  ["-smp", "2"],
  ["-machine", "virt"],
  ["-cpu", "cortex-a57"],
  ["-display", "none"],
  ["-boot", "menu=on"]
]
