# Description: Packer configuration file for Rocky Linux 9
packer {
  required_version = ">= 1.7.0"
  required_plugins {
    qemu = {
      version = "~> 1.0"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

# Variables
variable "rocky_version" {
  type    = string
  default = "9"
  description = "The version of Rocky Linux to install."
}

variable "headless" {
  type        = bool
  default     = false
  description = "Whether VNC viewer should not be launched."
}

# QEMU Builders
source "qemu" "rockylinux9-amd64" {
  iso_url      = "https://download.rockylinux.org/pub/rocky/${var.rocky_version}/isos/x86_64/Rocky-${var.rocky_version}-latest-x86_64-minimal.iso"
  iso_checksum = "file:https://download.rockylinux.org/pub/rocky/${var.rocky_version}/isos/x86_64/Rocky-${var.rocky_version}-latest-x86_64-minimal.iso.CHECKSUM"
  
  disk_size    = "10G"
  output_directory = "output/rockylinux9-amd64"
  vm_name      = "rockylinux9-amd64.qcow2"
  format       = "qcow2"
  accelerator  = "kvm"
  headless     = var.headless
  
  # QEMU Configuration
  #qemuargs = [
  #  ["-m", "2048M"],
  #  ["-smp", "2"],
  #  ["-machine", "q35"],
  #  ["-cpu", "host"]
  #]
  
  # Boot Configuration
  boot_wait = "5s"
  boot_command = [
    "<up><wait>",
    "e<wait>",
    "<down><down><end><wait>",
    " inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/rocky9.ks<wait>",
    "<F10>"
  ]
  
  # SSH Configuration
  ssh_username     = "root"
  ssh_password     = "packer"
  ssh_timeout      = "30m"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  
  #http_directory   = "http"
  http_content = {
    "/rocky9.ks" = templatefile("${path.root}/http/rocky9.ks",
      {
        KS_PROXY           = "",
        KS_OS_REPOS        = "https://mirrors.rockylinux.org/mirrorlist?arch=x86_64&repo=BaseOS-9",
        KS_APPSTREAM_REPOS = "https://mirrors.rockylinux.org/mirrorlist?arch=x86_64&release=9&repo=AppStream-9",
        KS_EXTRAS_REPOS    = "https://mirrors.rockylinux.org/mirrorlist?arch=x86_64&repo=extras-9"
      }
    )
  }  
}

source "qemu" "rockylinux9-arm64" {
  iso_url      = "https://download.rockylinux.org/pub/rocky/${var.rocky_version}/isos/aarch64/Rocky-${var.rocky_version}-latest-aarch64-boot.iso"
  iso_checksum = "file:https://download.rockylinux.org/pub/rocky/${var.rocky_version}/isos/aarch64/Rocky-${var.rocky_version}-latest-aarch64-boot.iso.CHECKSUM"
  
  disk_size    = "10G"
  output_directory = "output/rockylinux9-arm64"
  vm_name      = "rockylinux9-arm64.qcow2"
  format       = "qcow2"
  accelerator  = "tcg"
  headless     = var.headless

  # QEMU Configuration
  qemu_binary    = "qemu-system-aarch64"
  qemuargs       = [
    ["-serial", "stdio"], 
    ["-bios", "/usr/share/qemu-efi-aarch64/QEMU_EFI.fd"],
    ["-boot", "strict=off"],
    ["-machine", "type=virt"],
    ["-device", "qemu-xhci"],
    ["-device", "usb-kbd"],
    ["-device", "usb-mouse"],
    ["-cpu", "cortex-a57"],
    ["-device", "virtio-gpu-pci"],
  ]

  # Boot Configuration
  boot_wait = "10s"
  boot_command = [
    "<up><wait>",
    "e<wait>",
    "<down><down><end><wait>",
    " inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/rocky9.ks<wait>",
    "<F10>"
  ]
  
  # SSH Configuration
  ssh_username     = "root"
  ssh_password     = "packer"
  ssh_timeout      = "30m"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  
  #http_directory   = "http"
  http_content = {
    "/rocky9.ks" = templatefile("${path.root}/http/rocky9.ks",
      {
        KS_PROXY           = "",
        KS_OS_REPOS        = "https://mirrors.rockylinux.org/mirrorlist?arch=aarch64&repo=BaseOS-9",
        KS_APPSTREAM_REPOS = "https://mirrors.rockylinux.org/mirrorlist?arch=aarch64&release=9&repo=AppStream-9",
        KS_EXTRAS_REPOS    = "https://mirrors.rockylinux.org/mirrorlist?arch=aarch64&repo=extras-9"
      }
    )
  }
}

# Build Configuration
build {
  sources = [
    "source.qemu.rockylinux9-amd64",
    "source.qemu.rockylinux9-arm64"
  ]

  provisioner "shell" {
    scripts = [
      "scripts/base.sh",
      "scripts/cleanup.sh"
    ]
  }

  post-processor "vagrant" {
    keep_input_artifact = true
    output              = "rockylinux9-{{.Provider}}.box"
  }
}
