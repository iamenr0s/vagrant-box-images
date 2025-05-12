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
  default = "https://download.fedoraproject.org/pub/fedora/linux/releases/36/Server/x86_64/iso/Fedora-Server-dvd-x86_64-36.iso"
}

variable "iso_checksum" {
  type    = string
  default = "sha256:5edaf708a52687b09f9810c2b6d2a3432edae923aaf62f7d6e926637c7474295"
}

source "qemu" "fedora-36-x86_64" {
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
  output_directory = "output/fedora/36/x86_64"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  ssh_password     = "packer"
  ssh_port         = 22
  ssh_timeout      = "30m"
  ssh_username     = "packer"
  vm_name          = "fedora-36-x86_64"
}

build {
  sources = ["source.qemu.fedora-36-x86_64"]

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
    output = "output/fedora/36/x86_64/fedora-36-x86_64.box"
  }
}