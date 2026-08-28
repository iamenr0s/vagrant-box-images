# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Packer templates that build Vagrant boxes for multiple Linux distributions/versions/architectures via QEMU/KVM, provision them with Ansible, and publish to the HCP Vagrant Registry (`iamenr0s` org).

## Commands

Build a specific box locally (requires Packer, QEMU/KVM, Vagrant, and `/dev/kvm` access):

```bash
make fedora-42-x86_64        # any <distro>-<version>-<arch> target defined in the Makefile
make all                     # build every distro/version/arch combination
make clean                   # rm -rf output/*
```

Equivalent raw Packer invocation (what each Makefile target wraps), useful when iterating on a single template without going through make:

```bash
packer init distributions/<distro>/common/<distro>.pkr.hcl
packer validate \
  -var-file=distributions/<distro>/variables/common.pkrvars.hcl \
  -var-file=distributions/<distro>/variables/arch-<arch>.pkrvars.hcl \
  -var-file=distributions/<distro>/variables/<distro>-<version>.pkrvars.hcl \
  distributions/<distro>/common/<distro>.pkr.hcl
packer build \
  -var-file=distributions/<distro>/variables/common.pkrvars.hcl \
  -var-file=distributions/<distro>/variables/arch-<arch>.pkrvars.hcl \
  -var-file=distributions/<distro>/variables/<distro>-<version>.pkrvars.hcl \
  distributions/<distro>/common/<distro>.pkr.hcl
```

There is no test suite; `packer validate` is the correctness check for template/variable changes.

## Architecture

Each distribution under `distributions/<distro>/` is a self-contained clone of the same pattern — there is no shared `.pkr.hcl` include, so a fix (e.g. a boot-command bug, an SSH timeout change) usually needs to be **applied once per distro directory**, not just to the one that was reported broken. When changing one distro's `common/<distro>.pkr.hcl`, check whether the same defect exists in the sibling files for the other four distros.

Per-distro layout (`distributions/<distro>/`):
- `common/<distro>.pkr.hcl` — the Packer template: declares variables, a `qemu` source, and a `build` block. Distros differ mainly in: package manager bootstrap command (`dnf` vs `apt`), the installer config format (Fedora/AlmaLinux/RockyLinux use `ks.cfg` kickstart; Debian uses `preseed.cfg`; Ubuntu uses cloud-init `user-data`/`meta-data`), and default `ssh_timeout`.
- `common/http/*.pkrtpl.hcl` — templated installer config served to the VM during automated install (kickstart/preseed/cloud-init), interpolated with `version` and `install_url`.
- `common/scripts/setup.yml` — distro-specific Ansible playbook (packages, `qemu-guest-agent`, `cloud-init`, `NetworkManager`, etc.), run first via `ansible-local` as root.
- `variables/common.pkrvars.hcl` — shared per-distro defaults (ssh creds, disk size, `hcp_username`).
- `variables/arch-{x86_64,arm64}.pkrvars.hcl` — architecture-specific `qemu_binary`/`qemu_args`.
- `variables/<distro>-<version>.pkrvars.hcl` — per-version ISO URLs/checksums and install URLs, split into `x86_64_*` and `arm64_*` variants (with generic `iso_url`/`iso_checksum`/`install_url` as fallback via `coalesce()`).

`common/scripts/` (top-level, not per-distro) holds Ansible playbooks run **after** the distro-specific `setup.yml`, in this order, across every build regardless of distro:
1. `update.yml`
2. `setup_vagrant.yml` — installs the vagrant insecure keypair, passwordless sudo for `vagrant`, and kernel headers/build tools (branches on `ansible_distribution`/`ansible_os_family`)
3. `cleanup.yml` — clears package caches and zero-fills free space for smaller box images

Build output: `output/<distro>-<version>-<arch>/<distro>-<version>-<arch>.box`, produced by chaining the `vagrant` post-processor into `vagrant-registry` (publishes to HCP using `hcp_client_id`/`hcp_client_secret`, passed as `-var` at build time — never hardcode these).

## CI (`.github/workflows/build-vagrant-boxes.yml`)

- Matrix is generated dynamically from a `DISTRIBUTIONS`/`VERSIONS_<distro>`/`ARCHITECTURES` bash block in the `build-matrix` job — currently hardcoded to only `fedora` × `arm64` (other distros/architectures are commented out, not deleted). `workflow_dispatch` inputs (`distribution`, `architecture`) filter this matrix.
- Runs `packer validate` before `packer build` for each matrix entry; per-build timeout is 180 minutes.
- Publishes to the HCP Vagrant Registry automatically on push to `main`, on the weekly Sunday cron, or when `workflow_dispatch` sets `publish_to_cloud: true`.
- Tag pushes matching `v*` trigger a separate `release` job that gathers all build artifacts into a GitHub Release.
