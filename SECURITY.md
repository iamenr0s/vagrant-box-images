# Security Policy

## Supported Versions

Only the latest published box images and the `main` branch of this repository
receive security fixes.

| Version | Supported |
| ------- | --------- |
| Latest published boxes / `main` | ✅ |
| Older releases | ❌ |

## Reporting a Vulnerability

Please **do not** open a public issue for security vulnerabilities — this includes
issues in the Packer templates, the kickstart/preseed/cloud-init configs, the
Ansible provisioning scripts, or the CI/CD workflow (e.g. credential handling,
injection via untrusted build inputs).

Instead, report them privately via [GitHub private vulnerability reporting](https://github.com/iamenr0s/vagrant-box-images/security/advisories/new).

Include a description of the issue, steps to reproduce, and the affected
distribution/version/architecture if relevant.

You can expect an initial response within 7 days. Once the issue is confirmed,
a fix will be released as soon as practical and you will be credited in the
release notes unless you prefer otherwise.
