# x86_64 architecture variables for Ubuntu

architecture = "x86_64"
cpus = "2"
memory = "2048"
qemu_binary = "qemu-system-x86_64"
qemu_args = [
  ["-cpu", "host"],
  ["-smp", "2"],
  ["-m", "2048M"]
]