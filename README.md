# Vagrant Box Images

This repository contains Packer templates to build Vagrant box images for various Linux distributions and architectures.

## Supported Distributions

- Fedora 40, 41, 42 (x86_64, arm64)
- AlmaLinux 8, 9, 10 (x86_64, arm64)
- Rocky Linux 8, 9 (x86_64, arm64)
- Debian 11, 12 (x86_64, arm64)
- Ubuntu 22.04, 24.04 (x86_64, arm64)

## Requirements

- [Packer](https://www.packer.io/) (v1.8.0+)
- [QEMU/KVM](https://www.qemu.org/)
- [Vagrant](https://www.vagrantup.com/)

## Directory Structure

- `common/`: Common Ansible playbooks shared across all distributions (system update, Vagrant setup, cleanup)
- `distributions/`: Per-distribution Packer templates, variables, HTTP/install configs, and setup playbooks

## Building Images

```bash
make fedora-42-x86_64        # any <distro>-<version>-<arch> target (see Makefile)
make all                     # build every distro/version/arch combination
```

Or invoke Packer directly for a single target:

```bash
packer init distributions/fedora/common/fedora.pkr.hcl
packer build \
  -var-file=distributions/fedora/variables/common.pkrvars.hcl \
  -var-file=distributions/fedora/variables/arch-x86_64.pkrvars.hcl \
  -var-file=distributions/fedora/variables/fedora-42.pkrvars.hcl \
  distributions/fedora/common/fedora.pkr.hcl
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). This project follows the [Code of Conduct](CODE_OF_CONDUCT.md); report vulnerabilities per [SECURITY.md](SECURITY.md).

