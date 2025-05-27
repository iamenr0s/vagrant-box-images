// x86_64 architecture specific variables

architecture = "x86_64"
qemu_binary = "qemu-system-x86_64"
cpus = "2"
memory = "2048"
boot_command = ["<up>e", "<down><down><end>", " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg", "<leftCtrlOn>x<leftCtrlOff>"]

qemu_args = [
  ["-m", "2048"],
  ["-smp", "2"],
  ["-cpu", "host"],
  ["-display", "none"],
  ["-boot", "menu=on"]
]