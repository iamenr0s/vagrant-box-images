# Makefile for building Vagrant box images

.PHONY: all clean fedora-40-x86_64 fedora-40-arm64 fedora-41-x86_64 fedora-41-arm64 fedora-42-x86_64 fedora-42-arm64 almalinux-8-x86_64 almalinux-8-arm64 almalinux-9-x86_64 almalinux-9-arm64 almalinux-10-x86_64 almalinux-10-arm64 rockylinux-8-x86_64 rockylinux-8-arm64 rockylinux-9-x86_64 rockylinux-9-arm64

all: fedora-40-x86_64 fedora-40-arm64 fedora-41-x86_64 fedora-41-arm64 fedora-42-x86_64 fedora-42-arm64 almalinux-8-x86_64 almalinux-8-arm64 almalinux-9-x86_64 almalinux-9-arm64 almalinux-10-x86_64 almalinux-10-arm64 rockylinux-8-x86_64 rockylinux-8-arm64 rockylinux-9-x86_64 rockylinux-9-arm64

# Fedora 40
fedora-40-x86_64:
	packer build \
		-var-file=distributions/fedora/variables/common.pkrvars.hcl \
		-var-file=distributions/fedora/variables/arch-x86_64.pkrvars.hcl \
		-var-file=distributions/fedora/variables/fedora-40.pkrvars.hcl \
		distributions/fedora/common/fedora.pkr.hcl

fedora-40-arm64:
	packer build \
		-var-file=distributions/fedora/variables/common.pkrvars.hcl \
		-var-file=distributions/fedora/variables/arch-arm64.pkrvars.hcl \
		-var-file=distributions/fedora/variables/fedora-40.pkrvars.hcl \
		distributions/fedora/common/fedora.pkr.hcl

# Fedora 41
fedora-41-x86_64:
	packer build \
		-var-file=distributions/fedora/variables/common.pkrvars.hcl \
		-var-file=distributions/fedora/variables/arch-x86_64.pkrvars.hcl \
		-var-file=distributions/fedora/variables/fedora-41.pkrvars.hcl \
		distributions/fedora/common/fedora.pkr.hcl

fedora-41-arm64:
	packer build \
		-var-file=distributions/fedora/variables/common.pkrvars.hcl \
		-var-file=distributions/fedora/variables/arch-arm64.pkrvars.hcl \
		-var-file=distributions/fedora/variables/fedora-41.pkrvars.hcl \
		distributions/fedora/common/fedora.pkr.hcl

# Fedora 42
fedora-42-x86_64:
	packer build \
		-var-file=distributions/fedora/variables/common.pkrvars.hcl \
		-var-file=distributions/fedora/variables/arch-x86_64.pkrvars.hcl \
		-var-file=distributions/fedora/variables/fedora-42.pkrvars.hcl \
		distributions/fedora/common/fedora.pkr.hcl

fedora-42-arm64:
	packer build \
		-var-file=distributions/fedora/variables/common.pkrvars.hcl \
		-var-file=distributions/fedora/variables/arch-arm64.pkrvars.hcl \
		-var-file=distributions/fedora/variables/fedora-42.pkrvars.hcl \
		distributions/fedora/common/fedora.pkr.hcl

# AlmaLinux 8
almalinux-8-x86_64:
	packer build \
		-var-file=distributions/almalinux/variables/common.pkrvars.hcl \
		-var-file=distributions/almalinux/variables/arch-x86_64.pkrvars.hcl \
		-var-file=distributions/almalinux/variables/almalinux-8.pkrvars.hcl \
		distributions/almalinux/common/almalinux.pkr.hcl

almalinux-8-arm64:
	packer build \
		-var-file=distributions/almalinux/variables/common.pkrvars.hcl \
		-var-file=distributions/almalinux/variables/arch-arm64.pkrvars.hcl \
		-var-file=distributions/almalinux/variables/almalinux-8.pkrvars.hcl \
		distributions/almalinux/common/almalinux.pkr.hcl

# AlmaLinux 9
almalinux-9-x86_64:
	packer build \
		-var-file=distributions/almalinux/variables/common.pkrvars.hcl \
		-var-file=distributions/almalinux/variables/arch-x86_64.pkrvars.hcl \
		-var-file=distributions/almalinux/variables/almalinux-9.pkrvars.hcl \
		distributions/almalinux/common/almalinux.pkr.hcl

almalinux-9-arm64:
	packer build \
		-var-file=distributions/almalinux/variables/common.pkrvars.hcl \
		-var-file=distributions/almalinux/variables/arch-arm64.pkrvars.hcl \
		-var-file=distributions/almalinux/variables/almalinux-9.pkrvars.hcl \
		distributions/almalinux/common/almalinux.pkr.hcl

# AlmaLinux 10
almalinux-10-x86_64:
	packer build \
		-var-file=distributions/almalinux/variables/common.pkrvars.hcl \
		-var-file=distributions/almalinux/variables/arch-x86_64.pkrvars.hcl \
		-var-file=distributions/almalinux/variables/almalinux-10.pkrvars.hcl \
		distributions/almalinux/common/almalinux.pkr.hcl

almalinux-10-arm64:
	packer build \
		-var-file=distributions/almalinux/variables/common.pkrvars.hcl \
		-var-file=distributions/almalinux/variables/arch-arm64.pkrvars.hcl \
		-var-file=distributions/almalinux/variables/almalinux-10.pkrvars.hcl \
		distributions/almalinux/common/almalinux.pkr.hcl

# RockyLinux 8
rockylinux-8-x86_64:
	packer build \\
		-var-file=distributions/rockylinux/variables/common.pkrvars.hcl \\
		-var-file=distributions/rockylinux/variables/arch-x86_64.pkrvars.hcl \\
		-var-file=distributions/rockylinux/variables/rockylinux-8.pkrvars.hcl \\
		distributions/rockylinux/common/rockylinux.pkr.hcl

rockylinux-8-arm64:
	packer build \\
		-var-file=distributions/rockylinux/variables/common.pkrvars.hcl \\
		-var-file=distributions/rockylinux/variables/arch-arm64.pkrvars.hcl \\
		-var-file=distributions/rockylinux/variables/rockylinux-8.pkrvars.hcl \\
		distributions/rockylinux/common/rockylinux.pkr.hcl

# RockyLinux 9
rockylinux-9-x86_64:
	packer build \\
		-var-file=distributions/rockylinux/variables/common.pkrvars.hcl \\
		-var-file=distributions/rockylinux/variables/arch-x86_64.pkrvars.hcl \\
		-var-file=distributions/rockylinux/variables/rockylinux-9.pkrvars.hcl \\
		distributions/rockylinux/common/rockylinux.pkr.hcl

rockylinux-9-arm64:
	packer build \\
		-var-file=distributions/rockylinux/variables/common.pkrvars.hcl \\
		-var-file=distributions/rockylinux/variables/arch-arm64.pkrvars.hcl \\
		-var-file=distributions/rockylinux/variables/rockylinux-9.pkrvars.hcl \\
		distributions/rockylinux/common/rockylinux.pkr.hcl

clean:
	rm -rf output/*