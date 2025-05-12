packer {
  required_plugins {
    qemu = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

source "qemu" "rocky-9-x86_64" {
  accelerator      = "kvm"
  boot_command     = [
    "<up><wait><tab><wait> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/rocky/ks.cfg<enter><wait>"
  ]
  boot_wait        = "10s"
  disk_size        = "${var.disk_size}"
  format           = "qcow2"
  headless         = "${var.headless}"
  http_directory   = "http"
  iso_checksum     = "${var.iso_checksum_x86_64}"
  iso_url          = "${var.iso_url_x86_64}"
  memory           = "${var.memory}"
  cpus             = "${var.cpu}"
  output_directory = "output/rocky/9/x86_64"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = "${var.ssh_port}"
  ssh_timeout      = "${var.ssh_timeout}"
  ssh_username     = "${var.ssh_username}"
  vm_name          = "rocky-9-x86_64"
}

build {
  sources = ["source.qemu.rocky-9-x86_64"]

  provisioner "shell" {
    execute_command = "echo 'packer' | sudo -S sh -c '{{ .Path }}'"
    scripts         = [
      "scripts/common/update.sh",
      "scripts/common/setup.sh",
      "scripts/provisioners/shell/rocky/setup.sh",
      "scripts/common/cleanup.sh"
    ]
  }

  post-processor "vagrant" {
    output = "output/rocky/9/x86_64/rocky-9-x86_64.box"
  }
}