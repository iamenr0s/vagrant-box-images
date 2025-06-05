# Ubuntu 22.04 LTS variables

version = "22.04"

// x86_64 specific
x86_64_iso_url = "https://releases.ubuntu.com/22.04/ubuntu-22.04.5-live-server-amd64.iso"
x86_64_iso_checksum = "sha256:9bc6028870aef3f74f4e16b900008179e78b130e6b0b9a140635434a46aa98b0"

// arm64 specific
arm64_iso_url = "https://cdimage.ubuntu.com/releases/22.04.5/release/ubuntu-22.04.5-live-server-arm64.iso"
arm64_iso_checksum = "sha256:eafec62cfe760c30cac43f446463e628fada468c2de2f14e0e2bc27295187505"

boot_command = ["c<wait>linux /casper/vmlinuz --- autoinstall ds=\"nocloud;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/\"<enter><wait>", "initrd /casper/initrd<enter><wait>", "boot<enter><wait>"]
