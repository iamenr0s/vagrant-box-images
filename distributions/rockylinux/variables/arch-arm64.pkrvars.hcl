// arm64 architecture specific variables

architecture = "arm64"
qemu_binary = "qemu-system-aarch64"
cpus = "4"
memory = "4096"
boot_command = ["<up><wait>", "e", "<down><down><down><left>", " console=ttyS0 inst.cmdline inst.text inst.ks=http://{{.HTTPIP}}:{{.HTTPPort}}/ks.cfg <f10>"]

qemu_args = [
  ["-m", "2048"],
  ["-smp", "2"],
  ["-machine", "virt"],
  ["-cpu", "cortex-a57"],
  ["-display", "none"],
  ["-boot", "order=dc"]
  // Use order=dc instead of once=d for ARM64 compatibility
]
