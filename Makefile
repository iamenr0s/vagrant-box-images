# Makefile for building Vagrant box images

.PHONY: all clean fedora40-x86_64 fedora40-arm64

all: fedora40-x86_64 fedora40-arm64

# Fedora 40 x86_64
fedora40-x86_64:
	packer build -var-file=distributions/fedora/40/variables-x86_64.pkrvars.hcl distributions/fedora/40/fedora-x86_64.pkr.hcl

# Fedora 40 arm64
fedora40-arm64:
	packer build -var-file=distributions/fedora/40/variables-arm64.pkrvars.hcl distributions/fedora/40/fedora-arm64.pkr.hcl

# Clean output directories
clean:
	rm -rf output/*