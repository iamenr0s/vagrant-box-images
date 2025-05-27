// AlmaLinux Packer template for all versions

// Distribution variables
variable "distribution" {
  type    = string
  default = "almalinux"
}

variable "version" {
  type    = string
  description = "AlmaLinux version (8, 9, etc.)"
}

variable "architecture" {
  type    = string
  description = "The target architecture (x86_64 or arm64)"
}

// ISO variables
// Architecture-specific ISO variables
variable "x86_64_iso_url" {
  type    = string
  default = ""
  description = "URL to the x86_64 ISO image"
}

variable "x86_64_iso_checksum" {
  type    = string
  default = ""
  description = "Checksum of the x86_64 ISO image"
}

variable "x86_64_install_url" {
  type    = string
  default = ""
  description = "URL to the x86_64 installation repository"
}

variable "arm64_iso_url" {
  type    = string
  default = ""
  description = "URL to the arm64 ISO image"
}

variable "arm64_iso_checksum" {
  type    = string
  default = ""
  description = "Checksum of the arm64 ISO image"
}

variable "arm64_install_url" {
  type    = string
  default = ""
  description = "URL to the arm64 installation repository"
}

// Generic ISO variables (for backward compatibility)
variable "iso_url" {
  type    = string
  default = ""
  description = "URL to the ISO image (optional, architecture-specific variables take precedence)"
}

variable "iso_checksum" {
  type    = string
  default = ""
  description = "Checksum of the ISO image (optional, architecture-specific variables take precedence)"
}

variable "install_url" {
  type    = string
  default = ""
  description = "URL to the installation repository (optional, architecture-specific variables take precedence)"
}

// Boot and SSH variables
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

// System resources
variable "cpus" {
  type    = string
  default = "2"
  description = "Number of CPUs"
}

variable "memory" {
  type    = string
  default = "2048"
  description = "Memory in MB"
}

variable "disk_size" {
  type    = string
  default = "40960"
  description = "Disk size in MB"
}

variable "headless" {
  type    = string
  default = "true"
  description = "Start without a console"
}

variable "qemu_binary" {
  type    = string
  default = ""
  description = "Path to QEMU binary"
}

variable "qemu_args" {
  type    = list(list(string))
  default = []
  description = "Additional arguments for QEMU"
}

// Output variables
variable "output_directory" {
  type    = string
  default = "output"
  description = "Directory to output built images"
}

// Determine the effective ISO URL, checksum, and install URL based on architecture
locals {
  effective_iso_url = var.architecture == "x86_64" ? coalesce(var.x86_64_iso_url, var.iso_url) : coalesce(var.arm64_iso_url, var.iso_url)
  effective_iso_checksum = var.architecture == "x86_64" ? coalesce(var.x86_64_iso_checksum, var.iso_checksum) : coalesce(var.arm64_iso_checksum, var.iso_checksum)
  effective_install_url = var.architecture == "x86_64" ? coalesce(var.x86_64_install_url, var.install_url) : coalesce(var.arm64_install_url, var.install_url)
}

// The Packer build definition
source "qemu" "almalinux" {
  iso_url           = local.effective_iso_url
  iso_checksum      = local.effective_iso_checksum
  output_directory  = "${var.output_directory}/${var.distribution}-${var.version}-${var.architecture}"
  shutdown_command  = "echo 'vagrant' | sudo -S /sbin/shutdown -h now"
  disk_size         = var.disk_size
  format            = "qcow2"
  accelerator       = "kvm"
  http_directory    = "http"
  ssh_username      = var.ssh_username
  ssh_password      = var.ssh_password
  ssh_timeout       = var.ssh_timeout
  vm_name           = "${var.distribution}-${var.version}-${var.architecture}.qcow2"
  net_device        = "virtio-net"
  disk_interface    = "virtio"
  boot_wait         = "10s"
  boot_command      = var.boot_command
  qemu_binary       = var.qemu_binary
  qemuargs          = var.qemu_args
  headless          = var.headless
}

build {
  sources = ["source.qemu.almalinux"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    inline = [
      "dnf -y update",
      "dnf -y install epel-release",
      "dnf -y install ansible"
    ]
  }

  provisioner "ansible-local" {
    playbook_file = "${path.root}/scripts/setup.yml"
  }

  provisioner "ansible-local" {
    playbook_files = [
      "${path.cwd}/common/scripts/update.yml",
      "${path.cwd}/common/scripts/cleanup.yml"
    ]
  }

  post-processor "vagrant" {
    output = "${var.output_directory}/${var.distribution}-${var.version}-${var.architecture}.box"
  }
}