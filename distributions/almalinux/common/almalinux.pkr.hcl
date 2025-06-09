// AlmaLinux Packer template for all versions
packer {
  required_plugins {
    qemu = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/qemu"
    }
    ansible = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/ansible"
    }
    vagrant = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}

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
  description = "Number of CPUs"
}

variable "memory" {
  type    = string
  description = "Memory size in MB"
}

variable "disk_size" {
  type    = string
  default = "40960"
  description = "Disk size in MB"
}

// QEMU specific
variable "qemu_binary" {
  type    = string
  description = "Path to the QEMU binary"
}

variable "qemu_args" {
  type    = list(list(string))
  description = "Additional arguments to pass to QEMU"
}

// Output variables
variable "output_directory" {
  type    = string
  default = "output"
  description = "Directory where the output artifacts will be stored"
}

variable "headless" {
  type    = string
  default = "true"
}

// Local variables to handle architecture-specific settings
locals {
  // Use architecture-specific variables if available, otherwise fall back to generic ones
  actual_iso_url = var.architecture == "x86_64" ? coalesce(var.x86_64_iso_url, var.iso_url) : coalesce(var.arm64_iso_url, var.iso_url)
  actual_iso_checksum = var.architecture == "x86_64" ? coalesce(var.x86_64_iso_checksum, var.iso_checksum) : coalesce(var.arm64_iso_checksum, var.iso_checksum)
  actual_install_url = var.architecture == "x86_64" ? coalesce(var.x86_64_install_url, var.install_url) : coalesce(var.arm64_install_url, var.install_url)
}

// Fedora QEMU builder configuration
source "qemu" "almalinux" {
  iso_url           = local.actual_iso_url
  iso_checksum      = local.actual_iso_checksum
  output_directory  = "${var.output_directory}/${var.distribution}-${var.version}-${var.architecture}"
  shutdown_command  = "echo 'vagrant' | sudo -S shutdown -P now"
  disk_size         = var.disk_size
  format            = "qcow2"
  accelerator       = "kvm"
  ssh_username      = var.ssh_username
  ssh_password      = var.ssh_password
  ssh_timeout       = var.ssh_timeout
  vm_name           = "${var.distribution}-${var.version}-${var.architecture}.qcow2"
  net_device        = "virtio-net"
  disk_interface    = "virtio"
  boot_wait         = "10s"
  boot_command      = var.boot_command
  qemu_binary       = var.qemu_binary
  headless          = var.headless
  qemuargs          = var.qemu_args
  http_content = {
    "/ks.cfg" = templatefile("http/ks.cfg.pkrtpl.hcl", {
      install_url = local.actual_install_url
      version = var.version
    })
  }
}

// Build definition
build {
  name = "${var.distribution}-${var.version}-${var.architecture}"
  
  sources = ["source.qemu.almalinux"]

  // Install Python and pip dependencies as root
  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
    inline = [
      "dnf -y install python3 python3-pip"
    ]
  }
  
  // Install Ansible as vagrant user
  provisioner "shell" {
    inline = [
      "pip3 install --user --upgrade pip",
      "pip3 install --user ansible",
      "echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc",
      "export PATH=$HOME/.local/bin:$PATH"
    ]
  }

  // Run Fedora-specific setup using Ansible
  provisioner "ansible-local" {
    playbook_file = "${path.root}/scripts/setup.yml"
    command = "$HOME/.local/bin/ansible-playbook"
    extra_arguments = ["-b", "-v"] // Added -v for verbose output
  }

  // Run common Ansible playbooks
  provisioner "ansible-local" {
    playbook_files = [
      "${path.cwd}/common/scripts/update.yml",
      "${path.cwd}/common/scripts/setup_vagrant.yml",
      "${path.cwd}/common/scripts/cleanup.yml"
    ]
    command = "$HOME/.local/bin/ansible-playbook"
    extra_arguments = ["-b", "-v"] // Added -v for verbose output
  }

  // Create Vagrant box
  post-processor "vagrant" {
    compression_level = 9
    output = "${var.output_directory}/${var.distribution}-${var.version}-${var.architecture}/${var.distribution}-${var.version}-${var.architecture}.box"
  }
}