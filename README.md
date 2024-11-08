# Vagrant Box Images 

This repository contains configurations to build and test custom Vagrant boxes for various Linux distributions using Packer, Vagrant, and GitHub Actions.

## Supported OS Versions

- AlmaLinux 8
- Fedora 38
- Ubuntu 22.04

## Setup

### Prerequisites

- [Packer](https://www.packer.io/)
- [Vagrant](https://www.vagrantup.com/)
- [Libvirt](https://libvirt.org/)

### Build and Test Locally

To build a Vagrant box locally with Packer, run:

```bash
cd packer
packer init ubuntu-22.04.pkr.hcl
packer build ubuntu-22.04.pkr.hcl
```
## Dependencies

None

## License

This project is licensed under the MIT License.

## Author Information

