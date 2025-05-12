# Variables for Rocky Linux builds

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
  default = "https://download.rockylinux.org/pub/rocky/9/isos/x86_64/Rocky-9.3-x86_64-minimal.iso"
}

variable "iso_checksum_x86_64" {
  type    = string
  default = "sha256:76a5dcc5d5d7a92edae0a33116ab52d9b9c32bf37d4a9e2b7a09c0bc08768a70"
}

variable "iso_url_arm64" {
  type    = string
  default = "https://download.rockylinux.org/pub/rocky/9/isos/aarch64/Rocky-9.3-aarch64-minimal.iso"
}

variable "iso_checksum_arm64" {
  type    = string
  default = "sha256:c9e5a8a92db4c7dfc95418a6662c3f9a85a9195a4e2a846b5f5e49c8c7ebe6a1"
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