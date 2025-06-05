# Ubuntu 24.04 LTS variables

version = "24.04"

// x86_64 specific
x86_64_iso_url = "https://releases.ubuntu.com/24.04/ubuntu-24.04.2-live-server-amd64.iso"
x86_64_iso_checksum = "sha256:d6dab0c3a657988501b4bd76f1297c053df710e06e0c3aece60dead24f270b4d"

// arm64 specific
arm64_iso_url = "https://cdimage.ubuntu.com/releases/24.04/release/ubuntu-24.04.2-live-server-arm64.iso"
arm64_iso_checksum = "sha256:9fd122eedff09dc57d66e1c29acb8d7a207e2a877e762bdf30d2c913f95f03a4"

boot_command = ["c<wait>linux /casper/vmlinuz --- autoinstall ds=\"nocloud;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/\"<enter><wait>", "initrd /casper/initrd<enter><wait>", "boot<enter><wait>"]