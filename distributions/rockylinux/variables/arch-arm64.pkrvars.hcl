// arm64 architecture specific variables

architecture = "arm64"
qemu_binary = "qemu-system-aarch64"
cpus = "2"
memory = "4096"
# Edit GRUB entry approach
boot_command = [ "<up><wait>", "e<wait>", "<down><down><end><wait>", " inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<wait>", "<F10>"]

qemu_args = [
  ["-serial", "stdio"],
  ["-bios", "/usr/share/qemu-efi-aarch64/QEMU_EFI.fd"],
  ["-boot", "strict=off"],
  ["-machine", "type=virt"],
  ["-cpu", "cortex-a57"],
  ["-display", "none"]
]
