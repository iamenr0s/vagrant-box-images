# Vagrant Box Images Makefile

.PHONY: all clean fedora-40-x86_64 fedora-40-arm64 fedora-41-x86_64 fedora-41-arm64 fedora-42-x86_64 fedora-42-arm64 almalinux-8-x86_64 almalinux-8-arm64 almalinux-9-x86_64 almalinux-9-arm64 almalinux-10-x86_64 almalinux-10-arm64 rockylinux-8-x86_64 rockylinux-8-arm64 rockylinux-9-x86_64 rockylinux-9-arm64 ubuntu-20.04-x86_64 ubuntu-20.04-arm64 ubuntu-22.04-x86_64 ubuntu-22.04-arm64 ubuntu-24.04-x86_64 ubuntu-24.04-arm64 debian-11-x86_64 debian-11-arm64 debian-12-x86_64 debian-12-arm64

all: fedora-40-x86_64 fedora-40-arm64 fedora-41-x86_64 fedora-41-arm64 fedora-42-x86_64 fedora-42-arm64 almalinux-8-x86_64 almalinux-8-arm64 almalinux-9-x86_64 almalinux-9-arm64 almalinux-10-x86_64 almalinux-10-arm64 rockylinux-8-x86_64 rockylinux-8-arm64 rockylinux-9-x86_64 rockylinux-9-arm64 ubuntu-20.04-x86_64 ubuntu-20.04-arm64 ubuntu-22.04-x86_64 ubuntu-22.04-arm64 ubuntu-24.04-x86_64 ubuntu-24.04-arm64 debian-11-x86_64 debian-11-arm64 debian-12-x86_64 debian-12-arm64

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
	packer build \
		-var-file=distributions/rockylinux/variables/common.pkrvars.hcl \
		-var-file=distributions/rockylinux/variables/arch-x86_64.pkrvars.hcl \
		-var-file=distributions/rockylinux/variables/rockylinux-8.pkrvars.hcl \
		distributions/rockylinux/common/rockylinux.pkr.hcl

rockylinux-8-arm64:
	packer build \
		-var-file=distributions/rockylinux/variables/common.pkrvars.hcl \
		-var-file=distributions/rockylinux/variables/arch-arm64.pkrvars.hcl \
		-var-file=distributions/rockylinux/variables/rockylinux-8.pkrvars.hcl \
		distributions/rockylinux/common/rockylinux.pkr.hcl

# RockyLinux 9
rockylinux-9-x86_64:
	packer build \
		-var-file=distributions/rockylinux/variables/common.pkrvars.hcl \
		-var-file=distributions/rockylinux/variables/arch-x86_64.pkrvars.hcl \
		-var-file=distributions/rockylinux/variables/rockylinux-9.pkrvars.hcl \
		distributions/rockylinux/common/rockylinux.pkr.hcl

rockylinux-9-arm64:
	packer build \
		-var-file=distributions/rockylinux/variables/common.pkrvars.hcl \
		-var-file=distributions/rockylinux/variables/arch-arm64.pkrvars.hcl \
		-var-file=distributions/rockylinux/variables/rockylinux-9.pkrvars.hcl \
		distributions/rockylinux/common/rockylinux.pkr.hcl

# Ubuntu 22.04 LTS
ubuntu-22.04-x86_64:
	packer build \
		-var-file=distributions/ubuntu/variables/common.pkrvars.hcl \
		-var-file=distributions/ubuntu/variables/arch-x86_64.pkrvars.hcl \
		-var-file=distributions/ubuntu/variables/ubuntu-22.04.pkrvars.hcl \
		distributions/ubuntu/common/ubuntu.pkr.hcl

ubuntu-22.04-arm64:
	packer build \
		-var-file=distributions/ubuntu/variables/common.pkrvars.hcl \
		-var-file=distributions/ubuntu/variables/arch-arm64.pkrvars.hcl \
		-var-file=distributions/ubuntu/variables/ubuntu-22.04.pkrvars.hcl \
		distributions/ubuntu/common/ubuntu.pkr.hcl

# Ubuntu 24.04 LTS
ubuntu-24.04-x86_64:
	packer build \
		-var-file=distributions/ubuntu/variables/common.pkrvars.hcl \
		-var-file=distributions/ubuntu/variables/arch-x86_64.pkrvars.hcl \
		-var-file=distributions/ubuntu/variables/ubuntu-24.04.pkrvars.hcl \
		distributions/ubuntu/common/ubuntu.pkr.hcl

ubuntu-24.04-arm64:
	packer build \
		-var-file=distributions/ubuntu/variables/common.pkrvars.hcl \
		-var-file=distributions/ubuntu/variables/arch-arm64.pkrvars.hcl \
		-var-file=distributions/ubuntu/variables/ubuntu-24.04.pkrvars.hcl \
		distributions/ubuntu/common/ubuntu.pkr.hcl

# Debian 11 (Bullseye)
debian-11-x86_64:
	packer build \
		-var-file=distributions/debian/variables/common.pkrvars.hcl \
		-var-file=distributions/debian/variables/arch-x86_64.pkrvars.hcl \
		-var-file=distributions/debian/variables/debian-11.pkrvars.hcl \
		distributions/debian/common/debian.pkr.hcl

debian-11-arm64:
	packer build \
		-var-file=distributions/debian/variables/common.pkrvars.hcl \
		-var-file=distributions/debian/variables/arch-arm64.pkrvars.hcl \
		-var-file=distributions/debian/variables/debian-11.pkrvars.hcl \
		distributions/debian/common/debian.pkr.hcl

# Debian 12 (Bookworm)
debian-12-x86_64:
	packer build \
		-var-file=distributions/debian/variables/common.pkrvars.hcl \
		-var-file=distributions/debian/variables/arch-x86_64.pkrvars.hcl \
		-var-file=distributions/debian/variables/debian-12.pkrvars.hcl \
		distributions/debian/common/debian.pkr.hcl

debian-12-arm64:
	packer build \
		-var-file=distributions/debian/variables/common.pkrvars.hcl \
		-var-file=distributions/debian/variables/arch-arm64.pkrvars.hcl \
		-var-file=distributions/debian/variables/debian-12.pkrvars.hcl \
		distributions/debian/common/debian.pkr.hcl

clean:
	rm -rf output/*
