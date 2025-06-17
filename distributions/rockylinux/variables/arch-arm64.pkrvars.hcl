// arm64 architecture specific variables

architecture = "arm64"
qemu_binary = "qemu-system-aarch64"
cpus = "4"
memory = "4096"
# Edit GRUB entry approach
boot_command = [ "<up><wait>", "e<wait>", "<down><down><end><wait>", " inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/rocky9.ks<wait>", "<F10>"]

qemuargs = [
  ["-serial", "stdio"],
  ["-bios", "/usr/share/qemu-efi-aarch64/QEMU_EFI.fd"],
  ["-boot", "strict=off"],
  ["-machine", "type=virt"],
  ["-device", "qemu-xhci"],
  ["-device", "usb-kbd"],
  ["-device", "usb-mouse"],
  ["-cpu", "cortex-a57"],
  ["-device", "virtio-gpu-pci"],
]
