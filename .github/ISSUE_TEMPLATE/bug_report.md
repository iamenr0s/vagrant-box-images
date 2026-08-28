---
name: Bug report
about: Report a problem with a box build
title: ''
labels: bug
assignees: ''
---

## Describe the bug

A clear and concise description of what the bug is.

## To reproduce

Command used to build (Makefile target or raw `packer build` invocation) and any
non-default variables:

```bash
make fedora-42-x86_64
```

## Expected behavior

What you expected to happen.

## Actual behavior

What actually happened. Include the relevant Packer/Ansible output (run with
`PACKER_LOG=1` if possible):

```
paste output here
```

## Environment

- Distribution and version (e.g. Fedora 42, Debian 12):
- Architecture (x86_64 / arm64):
- Packer version (`packer version`):
- QEMU version (`qemu-system-x86_64 --version`):
- Host OS:

## Additional context

Anything else that might help (custom ISO mirror, proxy, host virtualization setup, etc.).
