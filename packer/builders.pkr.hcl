// Common builder configurations

source "qemu" "base" {
  headless         = var.headless
  memory           = var.memory
  cpus             = var.cpus
  disk_size        = var.disk_size
  ssh_username     = var.ssh_username
  ssh_password     = var.ssh_password
  ssh_timeout      = var.ssh_timeout
  shutdown_command = "echo '${var.ssh_password}' | sudo -S shutdown -P now"
  output_directory = "${var.output_directory}/${var.distribution}/${var.version}/${var.architecture}"
  vm_name          = "${var.distribution}-${var.version}-${var.architecture}.qcow2"
  
  // These will be overridden by distribution-specific configurations
  iso_url          = var.iso_url
  iso_checksum     = var.iso_checksum
  http_directory   = var.http_directory
  boot_command     = var.boot_command
  
  // Common QEMU settings
  qemu_binary      = var.qemu_binary
  qemuargs         = [["-m", "${var.memory}M"], ["-smp", "${var.cpus}"], ["-cpu", "host"]] 
  accelerator      = "kvm"
  format           = "qcow2"
  disk_interface   = "virtio"
  disk_cache       = "none"
  disk_compression = true
  disk_discard     = "unmap"
  net_device       = "virtio-net"
}