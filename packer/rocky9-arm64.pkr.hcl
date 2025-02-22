packer {
  required_version = ">= 1.7.0"
  required_plugins {
    qemu = {
      version = "~> 1.0"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

variable "filename" {
  type        = string
  default     = "rockylinux9-{{.Provider}}.box"
  description = "The filename of the tarball to produce"
}

variable "headless" {
  type        = bool
  default     = true
  description = "Whether VNC viewer should not be launched."
}

variable "rocky_iso_url" {
  type        = string
  default     = "https://download.rockylinux.org/pub/rocky/9/isos/aarch64/Rocky-aarch64-boot.iso"
}

variable "rocky_sha256sum_url" {
  type        = string
  default     = "https://download.rockylinux.org/pub/rocky/9/isos/aarch64/CHECKSUM"
}

# use can use "--url" to specify the exact url for os repo
variable "ks_os_repos" {
  type        = string
  default     = "--url='https://download.rockylinux.org/pub/rocky/9/BaseOS/aarch64/os/'"
}

# Use --baseurl to specify the exact url for base_os repo
variable "ks_base_os_repos" {
  type        = string
  default     = "--mirrorlist='http://mirrors.rockylinux.org/mirrorlist?arch=aarch64&repo=BaseOS-9'"
}

# Use --baseurl to specify the exact url for appstream repo
variable "ks_appstream_repos" {
  type        = string
  default     = "--mirrorlist='https://mirrors.rockylinux.org/mirrorlist?arch=aarch64&release=9&repo=AppStream-9'"
}

# Use --baseurl to specify the exact url for extras repo
variable "ks_extras_repos" {
  type        = string
  default     = "--mirrorlist='https://mirrors.rockylinux.org/mirrorlist?arch=aarch64&repo=extras-9'"
}

variable ks_proxy {
  type        = string
  default     = "${env("KS_PROXY")}"
}

variable ks_mirror {
  type        = string
  default     = "${env("KS_MIRROR")}"
}

variable "timeout" {
  type        = string
  default     = "2h"
  description = "Timeout for building the image"
}

source "qemu" "rocky9" {
  boot_command = [
    "<up>",
    "e",
    "<down><down><end><wait>",
    " inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/rocky9-arm64.ks",
    " console=ttyS0 inst.cmdline",
    "<enter><wait><leftCtrlOn>x<leftCtrlOff>"
  ]
  boot_wait        = "10s"
  communicator     = "none"
  disk_size        = "20G"
  headless         = var.headless
  iso_checksum     = "file:${var.rocky_sha256sum_url}"
  iso_url          = "${var.rocky_iso_url}"
  memory           = 10240
  qemuargs         = [
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
  shutdown_timeout = var.timeout
  qemu_binary    = "qemu-system-aarch64"
  http_content = {
    "/rocky9-arm64.ks" = templatefile("${path.root}/http/rocky9-arm64.ks",
      {
        KS_PROXY           = local.ks_proxy,
        KS_BASE_OS_REPOS   = local.ks_base_os_repos,
        KS_APPSTREAM_REPOS = local.ks_appstream_repos,
        KS_EXTRAS_REPOS    = local.ks_extras_repos
      }
    )
  }
}

build {
  sources = ["source.qemu.rocky9"]

#  post-processor "shell-local" {
#    inline = [
#      "SOURCE=${source.name}",
#      "OUTPUT=${var.filename}",
#    ]
#  }
}
