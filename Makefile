# Makefile for building Packer images

# Fedora builds
build-fedora-x86_64:
	packer build -var-file=config/common.pkrvars.hcl -var-file=config/x86_64.pkrvars.hcl templates/fedora/fedora-39-x86_64.pkr.hcl

build-fedora-arm64:
	packer build -var-file=config/common.pkrvars.hcl -var-file=config/arm64.pkrvars.hcl templates/fedora/fedora-39-arm64.pkr.hcl

# Ubuntu builds
build-ubuntu-x86_64:
	packer build -var-file=config/common.pkrvars.hcl -var-file=config/x86_64.pkrvars.hcl templates/ubuntu/ubuntu-22.04-x86_64.pkr.hcl

build-ubuntu-arm64:
	packer build -var-file=config/common.pkrvars.hcl -var-file=config/arm64.pkrvars.hcl templates/ubuntu/ubuntu-22.04-arm64.pkr.hcl

# Rocky Linux builds
build-rocky-x86_64:
	packer build -var-file=config/common.pkrvars.hcl -var-file=config/x86_64.pkrvars.hcl templates/rocky/rocky-9-x86_64.pkr.hcl

build-rocky-arm64:
	packer build -var-file=config/common.pkrvars.hcl -var-file=config/arm64.pkrvars.hcl templates/rocky/rocky-9-arm64.pkr.hcl

# Build all x86_64 images
build-all-x86_64: build-fedora-x86_64 build-ubuntu-x86_64 build-rocky-x86_64

# Build all arm64 images
build-all-arm64: build-fedora-arm64 build-ubuntu-arm64 build-rocky-arm64

# Build all images
build-all: build-all-x86_64 build-all-arm64

# Clean output directories
clean:
	rmdir /s /q output 2>nul || echo "Output directory already clean"

.PHONY: build-fedora-x86_64 build-fedora-arm64 build-ubuntu-x86_64 build-ubuntu-arm64 build-rocky-x86_64 build-rocky-arm64 build-all-x86_64 build-all-arm64 build-all clean