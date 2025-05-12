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

variable "iso_url_x86_64" {
  type    = string
  default = "https://download.fedoraproject.org/pub/fedora/linux/releases/39/Server/x86_64/iso/Fedora-Server-dvd-x86_64-39-1.5.iso"
}

variable "iso_checksum_x86_64" {
  type    = string
  default = "sha256:2755cdff6ac6365c75be60334bf1935ade838fc18de53d4c640a13d3e904f6e9"
}

variable "iso_url_arm64" {
  type    = string
  default = "https://download.fedoraproject.org/pub/fedora/linux/releases/39/Server/aarch64/iso/Fedora-Server-dvd-aarch64-39-1.5.iso"
}

variable "iso_checksum_arm64" {
  type    = string
  default = "sha256:c2a7c43c3f6c6519faa48b62a50b06e3a9f5291d9c3b15e9c4c5f5a1fc5c97f7"
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