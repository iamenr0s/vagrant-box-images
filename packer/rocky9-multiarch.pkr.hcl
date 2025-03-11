# Description: Packer configuration file for Rocky Linux 9 (x86_64 and ARM64)
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
  type        = string
  default     = "9"
  description = "The version of Rocky Linux to install."
}

variable "headless" {
  type        = bool
  default     = true
  description = "Whether VNC viewer should not be launched."
}

# QEMU Builders for ARM64
source "qemu" "rockylinux9-arm64" {
  iso_url      = "https://download.rockylinux.org/pub/rocky/${var.rocky_version}/isos/aarch64/Rocky-${var.rocky_version}-latest-aarch64-boot.iso"
  iso_checksum = "file:https://download.rockylinux.org/pub/rocky/${var.rocky_version}/isos/aarch64/Rocky-${var.rocky_version}-latest-aarch64-boot.iso.CHECKSUM"
  
  disk_size         = "10G"
  output_directory  = "output/rockylinux9-arm64"
  vm_name           = "rockylinux9-arm64.qcow2"
  format            = "qcow2"
  accelerator       = "tcg"
  headless          = var.headless

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

# QEMU Builders for x86_64
source "qemu" "rockylinux9-x86_64" {
  iso_url      = "https://download.rockylinux.org/pub/rocky/${var.rocky_version}/isos/x86_64/Rocky-${var.rocky_version}-latest-x86_64-dvd.iso"
  iso_checksum = "file:https://download.rockylinux.org/pub/rocky/${var.rocky_version}/isos/x86_64/Rocky-${var.rocky_version}-latest-x86_64-dvd.iso.CHECKSUM"
  
  disk_size         = "10G"
  output_directory  = "output/rockylinux9-x86_64"
  vm_name           = "rockylinux9-x86_64.qcow2"
  format            = "qcow2"
  accelerator       = "tcg"  # Changed from kvm to tcg
  headless          = var.headless

  # QEMU Configuration for x86_64
  qemuargs = [
    ["-m", "2048M"],
    ["-smp", "2"],
    ["-cpu", "max"],  # Changed from host to max
    ["-boot", "strict=off"],
    ["-serial", "stdio"],
    ["-machine", "type=q35,accel=tcg"],  # Added machine type
    ["-device", "virtio-net-pci,netdev=user.0"],
    ["-netdev", "user,id=user.0"]
  ]

  # Boot Configuration
  boot_wait = "10s"
  boot_command = [
    "<up><wait>",
    "e<wait>",
    "<down><down><end><wait>",
    " inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/rocky9.ks<wait>",
    " console=tty0 console=ttyS0,115200n8<wait>",
    " inst.repo=cdrom<wait>",
    " rd.driver.blacklist=nouveau<wait>",
    "<f10><wait>"
  ]
  
  # SSH Configuration
  ssh_username     = "root"
  ssh_password     = "packer"
  ssh_timeout      = "30m"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  
  http_content = {
    "/rocky9-x86_64.ks" = templatefile("${path.root}/http/rocky9.ks",
      {
        KS_PROXY           = "",
        KS_OS_REPOS        = "cdrom",
        KS_APPSTREAM_REPOS = "cdrom",
        KS_EXTRAS_REPOS    = "https://mirrors.rockylinux.org/mirrorlist?arch=x86_64&repo=extras-9"
      }
    )
  }
}

# Build Configuration
build {
  name = "rocky9-arm64"
  sources = [
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
    output              = "rockylinux9-arm64-{{.Provider}}.box"
  }
}

build {
  name = "rocky9-x86_64"
  sources = [
    "source.qemu.rockylinux9-x86_64"
  ]

  provisioner "shell" {
    scripts = [
      "scripts/base.sh",
      "scripts/cleanup.sh"
    ]
  }

  post-processor "vagrant" {
    keep_input_artifact = true
    output              = "rockylinux9-x86_64-{{.Provider}}.box"
  }
}