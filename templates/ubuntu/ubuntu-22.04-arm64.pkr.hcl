packer {
  required_plugins {
    qemu = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

source "qemu" "ubuntu-22.04-arm64" {
  accelerator      = "kvm"
  boot_command     = [
    "c<wait>",
    "linux /casper/vmlinuz --- autoinstall ds=\"nocloud-net;seedfrom=http://{{.HTTPIP}}:{{.HTTPPort}}/ubuntu/\"<enter><wait>",
    "initrd /casper/initrd<enter><wait>",
    "boot<enter>"
  ]
  boot_wait        = "5s"
  disk_size        = "${var.disk_size}"
  format           = "qcow2"
  headless         = "${var.headless}"
  http_directory   = "http"
  iso_checksum     = "${var.iso_checksum_arm64}"
  iso_url          = "${var.iso_url_arm64}"
  memory           = "${var.memory}"
  cpus             = "${var.cpu}"
  output_directory = "output/ubuntu/22.04/arm64"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  ssh_password     = "${var.ssh_password}"
  ssh_port         = "${var.ssh_port}"
  ssh_timeout      = "${var.ssh_timeout}"
  ssh_username     = "${var.ssh_username}"
  vm_name          = "ubuntu-22.04-arm64"
  qemu_binary      = "qemu-system-aarch64"
  machine_type     = "virt"
  qemu_args        = ["-cpu", "cortex-a57"]
}

build {
  sources = ["source.qemu.ubuntu-22.04-arm64"]

  provisioner "shell" {
    execute_command = "echo 'packer' | sudo -S sh -c '{{ .Path }}'"
    scripts         = [
      "scripts/common/update.sh",
      "scripts/common/setup.sh",
      "scripts/provisioners/shell/ubuntu/setup.sh",
      "scripts/common/cleanup.sh"
    ]
  }

  post-processor "vagrant" {
    output = "output/ubuntu/22.04/arm64/ubuntu-22.04-arm64.box"
  }
}