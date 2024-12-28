packer {
  required_plugins {
    qemu = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

variable "almalinux_version" {
  type    = string
  default = "9"
}

locals { 
  version = formatdate("YYYY.MM.DD", timestamp())
  iso_url_x86_64  = "https://repo.almalinux.org/almalinux/${var.almalinux_version}/isos/x86_64/AlmaLinux-${var.almalinux_version}-latest-x86_64-minimal.iso"
  iso_url_aarch64 = "https://repo.almalinux.org/almalinux/${var.almalinux_version}/isos/aarch64/AlmaLinux-${var.almalinux_version}-latest-aarch64-minimal.iso"
}

source "qemu" "almalinux_x86_64" {
  boot_command     = [
    "<up><tab>",
    "<leftCtrlOn>w<leftCtrlOff><bs>", // delete the "quiet" word.
    " net.ifnames=0",
    " ipv6.disable=1",
    " inst.cmdline",
    " inst.ksstrict",
    " inst.ks=http://{{.HTTPIP}}:{{.HTTPPort}}/ks9_x86-64.cfg",
    "<enter>"
  ]
  boot_wait        = "5s"
  http_directory   = "http"
  iso_url          = local.iso_url_x86_64
  iso_checksum     = "sha256:eef492206912252f2e24a74d3133b46cb4d240b54ffb3300a94000905b2590d3"
  output_directory = "output-almalinux-x86_64"
  disk_cache       = "unsafe"
  disk_discard     = "unmap"
  disk_interface   = "virtio-scsi"
  disk_size        = "40960"
  format           = "qcow2"
  accelerator      = "kvm"
  headless         = true
  cpus             = 2
  memory           = 2048
  qemuargs         = [
    ["-cpu", "host"],
  ]
  #net_device       = "virtio-net"
  ssh_username     = "vagrant"
  ssh_password     = "vagrant"
  ssh_timeout      = "60m"
  vm_name          = "almalinux9-x86_64"
  shutdown_command = "echo vagrant | sudo -S poweroff"
}

source "qemu" "almalinux_aarch64" {
  boot_command     = [
    "<up><tab>",
    "<leftCtrlOn>w<leftCtrlOff><bs>", // delete the "quiet" word.
    " net.ifnames=0",
    " ipv6.disable=1",
    " inst.cmdline",
    " inst.ksstrict",
    " inst.ks=http://{{.HTTPIP}}:{{.HTTPPort}}/ks9_aarch64.cfg",
    "<enter>"
  ]
  boot_wait        = "5s"
  http_directory   = "http"
  iso_url          = local.iso_url_aarch64
  iso_checksum     = "sha256:3ccea06172314cb3ea58ca9febb763abfa54b4ddb09a2441fc13709173b11eaa"
  output_directory = "output-almalinux-aarch64"
  disk_cache       = "unsafe"
  disk_discard     = "unmap"
  disk_interface   = "virtio-scsi"
  disk_size        = "40960"
  format           = "qcow2"
  accelerator      = "kvm"
  headless         = true
  cpus             = 2
  memory           = 2048
  qemuargs         = [
    ["-machine", "virt"],
    ["-cpu", "cortex-a53"],
  ]
  #net_device       = "virtio-net"
  ssh_username     = "vagrant"
  ssh_password     = "vagrant"
  ssh_timeout      = "60m"
  vm_name          = "almalinux9-aarch64"
  shutdown_command = "echo vagrant | sudo -S poweroff"
}

build {
  sources = [
    "source.qemu.almalinux_x86_64",
    "source.qemu.almalinux_aarch64"
  ]

  provisioner "shell" {
    inline = [
      "echo 'install completed'"
    ]
  }

    #post-processor "vagrant" {
    #    output = "almalinux9-{{.Provider}}.box"
    #}
}
