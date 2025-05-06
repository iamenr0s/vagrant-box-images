# Packer KVM/QEMU Templates

This repository contains Packer templates for building KVM/QEMU images for various Linux distributions. The templates support both x86_64 and arm64 architectures.

## Supported Distributions

- Ubuntu 22.04 LTS (x86_64, arm64)
- Rocky Linux 9 (x86_64, arm64)

## Prerequisites

- Packer >= 1.8.0
- QEMU/KVM
- Internet connection

## Usage

1. Clone this repository
2. Navigate to the desired distribution directory
3. Run packer build command:

For x86_64:
```bash
packer build -var="arch=x86_64" ubuntu/22.04/ubuntu-22.04.pkr.hcl
```

