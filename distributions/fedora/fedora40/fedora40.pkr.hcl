// Fedora 40 Packer template

// Include common variables
variable "distribution" {
  type    = string
  default = "fedora"
}

variable "version" {
  type    = string
  default = "40"
}

variable "architecture" {
  type    = string
  description = "The target architecture (x86_64 or arm64)"
}

variable "iso_url" {
  type    = string
  description = "URL to the ISO image"
}

variable "iso_checksum" {
  type    = string
  description = "Checksum of the ISO image"
}

variable "install_url" {
  type        = string
  description = "URL to the installation repository"
}

variable "http_directory" {
  type    = string
  description = "Directory containing HTTP files"
}

variable "boot_command" {
  type    = list(string)
  description = "Commands to type when the VM is first booted"
}

variable "ssh_username" {
  type    = string
  default = "vagrant"
  description = "Username to use to connect to the VM"
}

variable "ssh_password" {
  type    = string
  default = "vagrant"
  description = "Password to use to connect to the VM"
}

variable "ssh_timeout" {
  type    = string
  default = "120m"
  description = "Time to wait for SSH to become available"
}

variable "cpus" {
  type    = string
  default = "2"
  description = "Number of CPUs"
}

variable "memory" {
  type    = string
  default = "2048"
  description = "Memory size in MB"
}

variable "arm64_cpus" {
  type    = string
  default = "4"  // More CPUs for ARM emulation
}

variable "arm64_memory" {
  type    = string
  default = "4096"  // More memory for ARM emulation
}

variable "disk_size" {
  type    = string
  default = "40960"
  description = "Disk size in MB"
}

variable "qemu_binary" {
  type    = string
  description = "Path to the QEMU binary"
}

variable "output_directory" {
  type    = string
  default = "output"
  description = "Directory where the output artifacts will be stored"
}

variable "headless" {
  type    = string
  default = "true"
}

// QEMU arguments for different architectures
locals {
  qemu_args_x86_64 = [
    ["-m", "${var.memory}"],
    ["-smp", "${var.cpus}"],
    ["-cpu", "host"],
    ["-display", "none"],
    ["-boot", "menu=on"]
  ]
  
  qemu_args_arm64 = [
    ["-m", "${var.arm64_memory}"],
    ["-smp", "${var.arm64_cpus}"],
    ["-serial", "stdio"],
    ["-bios", "/usr/share/qemu-efi-aarch64/QEMU_EFI.fd"],
    ["-boot", "strict=off"],
    ["-machine", "type=virt"],
    ["-device", "qemu-xhci"],
    ["-device", "usb-kbd"],
    ["-device", "usb-mouse"],
    ["-cpu", "cortex-a57"],
    ["-netdev", "user,id=user.0,hostfwd=tcp::{{ .SSHHostPort }}-:22"],
    ["-device", "virtio-net-pci,netdev=user.0"],
    ["-device", "virtio-gpu-pci"],
  ]
  
  qemu_args = var.architecture == "x86_64" ? local.qemu_args_x86_64 : local.qemu_args_arm64
  
  // Define architecture-specific installation URLs
  install_urls = {
    "x86_64" = "https://fedora.mirrorservice.org/fedora/linux/releases/40/Server/x86_64/os/",
    "arm64"  = "https://fedora.mirrorservice.org/fedora/linux/releases/40/Server/aarch64/os/"
  }
}

// Fedora 40 QEMU builder configuration
source "qemu" "fedora40" {
  headless         = var.headless
  memory           = var.memory
  cpus             = var.cpus
  disk_size        = var.disk_size
  ssh_username     = var.ssh_username
  ssh_password     = var.ssh_password
  
  shutdown_command = "echo '${var.ssh_password}' | sudo -S shutdown -P now"
  output_directory = "${var.output_directory}/${var.distribution}/${var.version}/${var.architecture}"
  vm_name          = "${var.distribution}-${var.version}-${var.architecture}.qcow2"
  
  // Distribution-specific configurations
  iso_url          = var.iso_url
  iso_checksum     = var.iso_checksum
  http_directory   = var.http_directory
  boot_command     = var.boot_command
  qemu_binary      = var.qemu_binary
  
  // QEMU settings
  accelerator      = "kvm"
  format           = "qcow2"
  disk_interface   = "virtio"
  disk_cache       = "none"
  disk_compression = true
  disk_discard     = "unmap"
  net_device       = "virtio-net"
  
  // Use architecture-specific QEMU arguments
  qemuargs = local.qemu_args
  
  // Use the template file for HTTP
  http_content = {
    "/ks.cfg" = templatefile("${path.root}/http/ks.cfg.pkrtpl.hcl", {
      install_url = local.install_urls[var.architecture]
    })
  }
}

build {
  name = "fedora40-${var.architecture}"
  
  sources = ["source.qemu.fedora40"]
  
  // Update system
  provisioner "shell" {
    scripts = [
      "${path.root}/../../../common/scripts/update.sh",
      "${path.root}/scripts/setup.sh"
    ]
    execute_command = "echo '${var.ssh_password}' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
  } 
  // Add any additional provisioners here
}

