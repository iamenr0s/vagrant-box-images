// arm64 architecture specific variables

architecture = "arm64"
qemu_binary = "qemu-system-aarch64"
cpus = "4"
memory = "4096"
boot_command = ["<up>e", "<down><down><end>", " inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg", "<leftCtrlOn>x<leftCtrlOff>"]

qemu_args = [
  ["-m", "4096"],
  ["-smp", "4"],
  ["-serial", "stdio"],
  ["-bios", "/usr/share/qemu-efi-aarch64/QEMU_EFI.fd"],
  ["-boot", "menu=on"],
  ["-machine", "type=virt"],
  ["-device", "qemu-xhci"],
  ["-device", "usb-kbd"],
  ["-device", "usb-mouse"],
  ["-cpu", "cortex-a57"],
  ["-display", "none"]
]