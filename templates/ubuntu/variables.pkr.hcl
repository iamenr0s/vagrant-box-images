# Variables for Ubuntu builds

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

variable "iso_url_x86_64" {
  type    = string
  default = "https://releases.ubuntu.com/22.04/ubuntu-22.04.3-live-server-amd64.iso"
}

variable "iso_checksum_x86_64" {
  type    = string
  default = "sha256:a4acfda10b18da50e2ec50ccaf860d7f20421d6cab61c1ebb5e56d6d54b8e39d"
}

variable "iso_url_arm64" {
  type    = string
  default = "https://cdimage.ubuntu.com/releases/22.04/release/ubuntu-22.04.3-live-server-arm64.iso"
}

variable "iso_checksum_arm64" {
  type    = string
  default = "sha256:db9f18e3fcc3e65ea0ea6e0eff0c8d39d4f0a2f9f5c4b43f50f56e64cee2e9ff"
}

variable "arch" {
  type    = string
  default = "x86_64"
  description = "Architecture type: x86_64 or arm64"
}

variable "ssh_username" {
  type    = string
  default = "packer"
}

variable "ssh_password" {
  type    = string
  default = "packer"
}

variable "ssh_timeout" {
  type    = string
  default = "30m"
}

variable "ssh_port" {
  type    = number
  default = 22
}