packer {
  required_plugins {
    qemu = {
      version = ">= 1.0.9"
      source  = "github.com/hashicorp/qemu"
    }
    vagrant = {
      version = ">= 1.0.2"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}

variable "almalinux_version" {
  type    = string
  default = "9.3"
}

variable "iso_url_x86_64" {
  type    = string
  default = "https://repo.almalinux.org/almalinux/9/isos/x86_64/AlmaLinux-9-latest-x86_64-boot.iso"
}

variable "iso_checksum_x86_64" {
  type    = string
  default = "sha256:3038fb71a29d33c3c93117bd8f4c3f612cb152dce057c666b6b11dfa793fb65c"
}

variable "iso_url_aarch64" {
  type    = string
  default = "https://repo.almalinux.org/almalinux/9/isos/aarch64/AlmaLinux-9-latest-aarch64-boot.iso"
}

variable "iso_checksum_aarch64" {
  type    = string
  default = "sha256:bcb053044ebfa2005d732825f4929626edb4c0802ca43b02140b15f00796ea81"
}

variable "cpus" {
  type    = string
  default = "2"
}

variable "memory" {
  type    = string
  default = "2048"
}

variable "disk_size" {
  type    = string
  default = "40960"
}

variable "headless" {
  type    = bool
  default = true
}

variable "ssh_username" {
  type    = string
  default = "vagrant"
}

variable "ssh_password" {
  type    = string
  default = "vagrant"
}

variable "ssh_timeout" {
  type    = string
  default = "30m"
}

source "qemu" "almalinux_x86_64" {
  iso_url           = var.iso_url_x86_64
  iso_checksum      = var.iso_checksum_x86_64
  output_directory  = "output-almalinux-${var.almalinux_version}-x86_64"
  shutdown_command  = "echo 'vagrant' | sudo -S /sbin/shutdown -h now"
  disk_size         = var.disk_size
  format            = "qcow2"
  accelerator       = "kvm"
  http_directory    = "http"
  ssh_username      = var.ssh_username
  ssh_password      = var.ssh_password
  ssh_timeout       = var.ssh_timeout
  
  # Adding qemuargs to fix kernel panic
  qemuargs          = [
    ["-m", "${var.memory}M"],
    ["-smp", "${var.cpus}"],
    ["-cpu", "host"]
  ]
  
  vm_name           = "almalinux-${var.almalinux_version}-x86_64.qcow2"
  net_device        = "virtio-net"
  disk_interface    = "virtio"
  boot_wait         = "10s"
  boot_command      = [
    "<tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg console=ttyS0 net.ifnames=0 biosdevname=0 crashkernel=auto<enter><wait>"
  ]
  cpus              = var.cpus
  memory            = var.memory
  headless          = var.headless
}

source "qemu" "almalinux_aarch64" {
  iso_url           = var.iso_url_aarch64
  iso_checksum      = var.iso_checksum_aarch64
  output_directory  = "output-almalinux-${var.almalinux_version}-aarch64"
  shutdown_command  = "echo 'vagrant' | sudo -S /sbin/shutdown -h now"
  disk_size         = var.disk_size
  format            = "qcow2"
  accelerator       = "tcg"
  http_directory    = "http"
  ssh_username      = var.ssh_username
  ssh_password      = var.ssh_password
  ssh_timeout       = var.ssh_timeout
  vm_name           = "almalinux-${var.almalinux_version}-aarch64.qcow2"
  net_device        = "virtio-net"
  disk_interface    = "virtio"
  boot_wait         = "10s"
  boot_command      = [
    "<tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"
  ]
  cpus              = var.cpus
  memory            = var.memory
  headless          = var.headless
  qemu_binary       = "qemu-system-aarch64"
  machine_type      = "virt"
  qemuargs          = [
    ["-cpu", "cortex-a57"],
    ["-bios", "/usr/share/qemu-efi-aarch64/QEMU_EFI.fd"]
  ]
}

build {
  name = "almalinux"
  
  sources = [
    "source.qemu.almalinux_x86_64",
    "source.qemu.almalinux_aarch64"
  ]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    inline = [
      "dnf -y update",
      "dnf -y install cloud-init cloud-utils-growpart",
      "dnf clean all",
      "systemctl enable cloud-init",
      
      # Install guest additions
      "dnf -y install qemu-guest-agent",
      "systemctl enable qemu-guest-agent",
      
      # Clean up
      "rm -rf /tmp/*",
      "rm -f /var/log/wtmp /var/log/btmp",
      "rm -f /var/log/lastlog",
      "rm -rf /var/cache/dnf/*",
      "rm -rf /var/cache/yum/*",
      "rm -rf /home/vagrant/.cache/",
      "rm -f /etc/udev/rules.d/70-persistent-net.rules",
      "rm -f /lib/udev/rules.d/75-persistent-net-generator.rules",
      "rm -rf /dev/.udev/",
      
      # Zero out the free space to save space in the final image
      "dd if=/dev/zero of=/EMPTY bs=1M || true",
      "rm -f /EMPTY"
    ]
  }

  post-processor "vagrant" {
    output = "almalinux-${var.almalinux_version}-{{ .Provider }}-{{ .BuildName }}.box"
    compression_level = 9
    keep_input_artifact = true
  }
}
