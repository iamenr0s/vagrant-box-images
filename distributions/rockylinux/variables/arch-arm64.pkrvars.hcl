// arm64 architecture specific variables

architecture = "arm64"
qemu_binary = "qemu-system-aarch64"
cpus = "4"
memory = "4096"
# Edit GRUB entry approach
boot_command = ["<wait10>e", "<down><down><end>", " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg console=ttyS0 inst.cmdline inst.headless", "<leftCtrlOn>x<leftCtrlOff>"]

qemu_args = [
  ["-m", "2048"],
  ["-smp", "2"],
  ["-machine", "virt"],
  ["-cpu", "cortex-a57"],
  ["-display", "none"],
  ["-boot", "menu=on"]
]
