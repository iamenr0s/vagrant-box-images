// Fedora 39 Packer template

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
  description = "Architecture to build (x86_64 or arm64)"
}

variable "iso_url" {
  type    = string
  description = "URL to the ISO image"
}

variable "iso_checksum" {
  type    = string
  description = "Checksum of the ISO image"
}

variable "http_directory" {
  type    = string
  description = "Directory for HTTP server files"
}

variable "boot_command" {
  type    = list(string)
  description = "Commands to type during boot"
}

variable "qemu_binary" {
  type    = string
  description = "Path to QEMU binary"
}

// Add SSH username variable
variable "ssh_username" {
  type    = string
  default = "vagrant"
  description = "SSH username for connecting to the VM"
}

// Add SSH password variable
variable "ssh_password" {
  type    = string
  default = "vagrant"
  description = "SSH password for connecting to the VM"
}

// Add output directory variable
variable "output_directory" {
  type    = string
  default = "output"
  description = "Directory where the output artifacts will be stored"
}

// Include common builders
source "qemu" "fedora40" {
  iso_url          = var.iso_url
  iso_checksum     = var.iso_checksum
  http_directory   = var.http_directory
  boot_command     = var.boot_command
  qemu_binary      = var.qemu_binary
  ssh_username     = var.ssh_username
  ssh_password     = var.ssh_password
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
  
  // Install Vagrant-specific items
  provisioner "shell" {
    script = "${path.root}/../../../common/scripts/setup_vagrant.sh"
    execute_command = "echo '${var.ssh_password}' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
  }
  
  // Clean up
  provisioner "shell" {
    script = "${path.root}/../../../common/scripts/cleanup.sh"
    execute_command = "echo '${var.ssh_password}' | {{.Vars}} sudo -S -E bash '{{.Path}}'"
  }
  
  // Create Vagrant box
  post-processor "vagrant" {
    compression_level = 9
    output = "${var.output_directory}/${var.distribution}${var.version}-${var.architecture}.box"
  }
}