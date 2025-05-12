packer {
  required_plugins {
    qemu = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

variable "cpu" {
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

variable "iso_url" {
  type    = string
  default = "https://download.fedoraproject.org/pub/fedora/linux/releases/39/Server/x86_64/iso/Fedora-Server-dvd-x86_64-39-1.5.iso"
}

variable "iso_checksum" {
  type    = string
  default = "sha256:39da3d3c5a9ed5d9a2a2c9c2c1d5bb5573c82a30b404a5a1a92c8fe70c6cc8f3"
}

source "qemu" "fedora-39-x86_64" {
  accelerator      = "kvm"
  boot_command     = [
    "<tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/fedora/ks.cfg<enter><wait>"
  ]
  boot_wait        = "10s"
  disk_size        = "${var.disk_size}"
  format           = "qcow2"
  headless         = "${var.headless}"
  http_directory   = "http"
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
  memory           = "${var.memory}"
  cpus             = "${var.cpu}"
  output_directory = "output/fedora/39/x86_64"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  ssh_password     = "packer"
  ssh_port         = 22
  ssh_timeout      = "30m"
  ssh_username     = "packer"
  vm_name          = "fedora-39-x86_64"
}

build {
  sources = ["source.qemu.fedora-39-x86_64"]

  provisioner "shell" {
    execute_command = "echo 'packer' | sudo -S sh -c '{{ .Path }}'"
    scripts         = [
      "scripts/common/update.sh",
      "scripts/common/setup.sh",
      "scripts/provisioners/shell/fedora/setup.sh",
      "scripts/common/cleanup.sh"
    ]
  }

  post-processor "vagrant" {
    output = "output/fedora/39/x86_64/fedora-39-x86_64.box"
  }
}