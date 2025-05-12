# Variables for Fedora builds

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