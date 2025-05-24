// Fedora Packer template for all versions

// Distribution variables
variable "distribution" {
  type    = string
  default = "fedora"
}

variable "version" {
  type    = string
  description = "Fedora version (40, 41, 42, etc.)"
}

variable "architecture" {
  type    = string
  description = "The target architecture (x86_64 or arm64)"
}

// ISO variables
variable "iso_url" {
  type    = string
  description = "URL to the ISO image"
}

variable "iso_checksum" {
  type    = string
  description = "Checksum of the ISO image"
}

variable "install_url" {
  type    = string
  description = "URL to the installation repository"
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

// Fedora QEMU builder configuration
source "qemu" "fedora" {
  iso_url           = var.iso_url
  iso_checksum      = var.iso_checksum
  output_directory  = "${var.output_directory}/${var.distribution}-${var.version}-${var.architecture}"
  shutdown_command  = "echo 'vagrant' | sudo -S shutdown -P now"
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
  headless          = var.headless
  qemuargs          = var.qemu_args
}

// Build definition
build {
  name = "${var.distribution}-${var.version}-${var.architecture}"
  
  sources = ["source.qemu.fedora"]

  // Copy the kickstart template and process variables
  provisioner "file" {
    source      = "${path.root}/http/ks.cfg.pkrtpl.hcl"
    destination = "/tmp/ks.cfg.pkrtpl.hcl"
  }

  // Process the kickstart template
  provisioner "shell" {
    inline = [
      "mkdir -p /tmp/http",
      "cat /tmp/ks.cfg.pkrtpl.hcl | sed 's/\${install_url}/${var.install_url}/g' > /tmp/http/ks.cfg"
    ]
  }

  // Run Fedora-specific setup script
  provisioner "shell" {
    script = "${path.root}/scripts/setup.sh"
  }

  // Run common scripts
  provisioner "shell" {
    scripts = [
      "${path.root}/../../common/scripts/update.sh",
      "${path.root}/../../common/scripts/setup_vagrant.sh",
      "${path.root}/../../common/scripts/cleanup.sh"
    ]
  }

  // Create Vagrant box
  post-processor "vagrant" {
    compression_level = 9
    output            = "${var.output_directory}/${var.distribution}-${var.version}-${var.architecture}.box"
  }
}