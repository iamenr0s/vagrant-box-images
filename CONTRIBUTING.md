# Contributing

Thanks for taking the time to contribute to `vagrant-box-images`!

## Getting started

1. Fork the repository and create your branch from `main`.
2. Install the development dependencies:

   ```bash
   # Packer, QEMU/KVM, Vagrant — see README.md for install instructions
   pip3 install yamllint ansible-lint
   ```

## Making changes

- Keep changes small and focused — one topic per pull request.
- Follow the existing HCL/YAML style; lint rules live in `.yamllint` and `.ansible-lint`.
- This repo has no shared Packer template — each `distributions/<distro>/common/<distro>.pkr.hcl`
  is a self-contained clone of the same pattern. If you're fixing a bug that isn't
  distro-specific (e.g. an SSH timeout, a boot-command issue), check whether the
  same defect exists in the sibling files for the other distros before opening the PR.
- If you add or change a Packer variable, document it in the relevant `variables/*.pkrvars.hcl`
  file's inline description.

## Testing

Before opening a pull request, make sure lint and validation pass:

```bash
yamllint .
ansible-lint

# Validate the templates you touched, e.g.:
packer init distributions/<distro>/common/<distro>.pkr.hcl
packer validate \
  -var-file=distributions/<distro>/variables/common.pkrvars.hcl \
  -var-file=distributions/<distro>/variables/arch-<arch>.pkrvars.hcl \
  -var-file=distributions/<distro>/variables/<distro>-<version>.pkrvars.hcl \
  distributions/<distro>/common/<distro>.pkr.hcl
```

If you have QEMU/KVM available, run a full build with `make <distro>-<version>-<arch>`
for the combination(s) you changed. CI runs `packer validate` across every
distro/version/arch combination on every pull request; the full box build
(`build-vagrant-boxes.yml`) currently only builds `fedora` on `arm64` by default.

## Submitting a pull request

1. Ensure lint and validation pass locally.
2. Fill in the pull request template.
3. A maintainer will review your PR; CI must be green before merge.

## Reporting bugs and requesting features

Use the issue templates — they ask for the details (distro, version, architecture,
Packer/QEMU version) needed to reproduce a problem.

## Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating you agree to abide by it.
