#!/usr/bin/env bash

# Update
dnf update -y

# Install basic packages
dnf install -y \
	sudo git nano neofetch tmate aria2 rsync rclone \
	python python2 zip unzip p7zip p7zip-plugins jq \
	unrar python3-pip tmate make cmake clang glibc \
	bc ag unace sharutils uudeview arj cabextract \
	file-roller dtc brotli axel detox cpio lz4 \
	python3-devel xz-devel

# Android build Environment
bash /tmp/scripts/fedora-aosp-env-setup.sh

# Use python2 by default
ln -sf /usr/bin/python{2,}

# Exit
exit 0
