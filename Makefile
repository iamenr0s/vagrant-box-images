# Makefile for building Vagrant box images

.PHONY: all clean fedora-40-x86_64 fedora-40-arm64 fedora-41-x86_64 fedora-41-arm64 fedora-42-x86_64 fedora-42-arm64

all: fedora-40-x86_64 fedora-40-arm64 fedora-41-x86_64 fedora-41-arm64 fedora-42-x86_64 fedora-42-arm64

# Fedora 40
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

# Clean output directories
clean:
	rm -rf output/*