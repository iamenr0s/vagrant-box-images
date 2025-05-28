// x86_64 architecture specific variables

architecture = "x86_64"
qemu_binary = "qemu-system-x86_64"
cpus = "2"
memory = "2048"
boot_command = ["<wait5><tab>", " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg inst.cmdline inst.headless ip=dhcp", "<enter>"]

qemu_args = [
  ["-m", "2048"],
  ["-smp", "2"],
  ["-cpu", "host"],
  ["-display", "none"],
  ["-boot", "menu=on"]
]