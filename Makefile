# Makefile for building Vagrant box images

.PHONY: all clean fedora39-x86_64 fedora39-arm64

all: fedora39-x86_64 fedora39-arm64

# Fedora 39 x86_64
fedora39-x86_64:
	packer build -var-file=distributions/fedora/fedora39/x86_64/variables.pkrvars.hcl distributions/fedora/fedora39/fedora39.pkr.hcl

# Fedora 39 arm64
fedora39-arm64:
	packer build -var-file=distributions/fedora/fedora39/arm64/variables.pkrvars.hcl distributions/fedora/fedora39/fedora39.pkr.hcl

# Clean output directories
clean:
	rm -rf output/*