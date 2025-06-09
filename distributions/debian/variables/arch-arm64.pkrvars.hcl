# arm64 architecture variables for Debian

architecture = "arm64"
cpus = "2"
memory = "2048"
qemu_binary = "qemu-system-aarch64"
qemu_args = [
  ["-cpu", "host"],
  ["-smp", "2"],
  ["-m", "2048M"],
  ["-machine", "virt"]
]