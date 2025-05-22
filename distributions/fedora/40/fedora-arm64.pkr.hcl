// Fedora 40 arm64 Packer template

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
  default = "arm64"
  description = "The target architecture (arm64)"
}

variable "iso_url" {
  type    = string
  description = "URL to the ISO image"
}

variable "iso_checksum" {
  type    = string
  description = "Checksum of the ISO image"
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
  default = "4"
  description = "Number of CPUs"
}

variable "memory" {
  type    = string
  default = "4096"
  description = "Memory size in MB"
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

locals {
  qemu_args_arm64 = [
    ["-m", "${var.memory}"],
    ["-smp", "${var.cpus}"],
    ["-bios", "/usr/share/qemu-efi-aarch64/QEMU_EFI.fd"],
    ["-machine", "type=virt,accel=kvm"],
    ["-cpu", "host,aarch64=on"],
    ["-netdev", "user,id=user.0,hostfwd=tcp::{{ .SSHHostPort }}-:22"],
    ["-device", "virtio-net-pci,netdev=user.0"]
  ]
  
  install_url = "https://fedora.mirrorservice.org/fedora/linux/releases/40/Server/aarch64/os/"
}

source "qemu" "fedora40" {
  headless         = var.headless
  memory           = var.memory
  cpus             = var.cpus
  disk_size        = var.disk_size
  ssh_username     = var.ssh_username
  ssh_password     = var.ssh_password
  ssh_timeout      = var.ssh_timeout
  shutdown_command = "echo '${var.ssh_password}' | sudo -S shutdown -P now"
  output_directory = "${var.output_directory}/${var.distribution}/${var.version}/${var.architecture}"
  vm_name          = "${var.distribution}-${var.version}-${var.architecture}.qcow2"
  iso_url          = var.iso_url
  iso_checksum     = var.iso_checksum
  boot_command     = var.boot_command
  qemu_binary      = var.qemu_binary
  accelerator      = "kvm"
  format           = "qcow2"
  disk_interface   = "virtio"
  disk_cache       = "none"
  disk_compression = true
  disk_discard     = "unmap"
  net_device       = "virtio-net"
  qemuargs = local.qemu_args_arm64
  http_content = {
    "/ks.cfg" = templatefile("http/ks.cfg.pkrtpl.hcl", {
      install_url = local.install_url
    })
  }
}

build {
  name = "fedora40-arm64"
  sources = ["source.qemu.fedora40"]
  provisioner "shell" {
    scripts = [
      "${path.root}/../../../common/scripts/update.sh",
      "${path.root}/scripts/setup.sh"
    ]
    execute_command = "echo '${var.ssh_password}' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
  } 
}