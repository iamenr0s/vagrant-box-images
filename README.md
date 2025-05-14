# Vagrant Box Images

This repository contains Packer templates to build Vagrant box images for various Linux distributions and architectures.

## Supported Distributions

- Fedora 40 (x86_64, arm64)
- Ubuntu (planned)
- AlmaLinux (planned)

## Requirements

- [Packer](https://www.packer.io/) (v1.8.0+)
- [QEMU/KVM](https://www.qemu.org/)
- [Vagrant](https://www.vagrantup.com/)

## Directory Structure

- `common/`: Common scripts and configurations shared across distributions
- `distributions/`: Distribution-specific configurations and scripts
- `packer/`: Common Packer configuration files

## Building Images

### Building Fedora 39 for x86_64

```bash
cd vagrant-box-images
packer build -var-file=distributions/fedora/fedora40/x86_64/variables.pkrvars.hcl distributions/fedora/fedora40/fedora40.pkr.hcl
```

