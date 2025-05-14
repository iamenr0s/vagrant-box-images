# Makefile for building Vagrant box images

.PHONY: all clean fedora40-x86_64 fedora40-arm64

all: fedora40-x86_64 fedora40-arm64

# Fedora 39 x86_64
fedora40-x86_64:
	packer build -var-file=distributions/fedora/fedora40/x86_64/variables.pkrvars.hcl distributions/fedora/fedora40/fedora40.pkr.hcl

# Fedora 39 arm64
fedora40-arm64:
	packer build -var-file=distributions/fedora/fedora40/arm64/variables.pkrvars.hcl distributions/fedora/fedora40/fedora40.pkr.hcl

# Clean output directories
clean:
	rm -rf output/*