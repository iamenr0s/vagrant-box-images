packer {
  required_plugins {
    qemu = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

# Use the variables from the variables.pkr.hcl file

source "qemu" "fedora-36-arm64" {
  accelerator      = "kvm"
  boot_command     = [
    "<tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/fedora/ks.cfg<enter><wait>"
  ]
  boot_wait        = "10s"
  disk_size        = "${var.disk_size}"
  format           = "qcow2"
  headless         = "${var.headless}"
  http_directory   = "http"
  iso_checksum     = "sha256:c1a4b156bb87e3e8bd8b3a775d5e36e3d5e1e9e89e7cc1a8b6f5e8b34b078fb7"
  iso_url          = "https://download.fedoraproject.org/pub/fedora/linux/releases/36/Server/aarch64/iso/Fedora-Server-dvd-aarch64-36.iso"
  memory           = "${var.memory}"
  cpus             = "${var.cpu}"
  output_directory = "output/fedora/36/arm64"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = "${var.ssh_port}"
  ssh_timeout      = "${var.ssh_timeout}"
  ssh_username     = "${var.ssh_username}"
  vm_name          = "fedora-36-arm64"
  qemu_binary      = "qemu-system-aarch64"
  machine_type     = "virt"
  qemu_args        = ["-cpu", "cortex-a57"]
}

build {
  sources = ["source.qemu.fedora-36-arm64"]

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
    output = "output/fedora/36/arm64/fedora-36-arm64.box"
  }
}