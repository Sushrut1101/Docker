#!/bin/bash

# Uncomment community [multilib] repository
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# Update
pacman -Syyu --needed --noconfirm

# Install Basic Packages
pacman -S --needed --noconfirm \
	sudo nano git curl wget rsync aria2 rclone \
	python2 python3 python-pip zip unzip cmake \
	make neofetch speedtest-cli inetutils cpio \
	jdk8-openjdk lzip dpkg openssl ccache repo \
	libelf base-devel openssh lz4 jq go ncurses \
	bison flex ninja uboot-tools z3 glibc dpkg \
	multilib-devel bc htop python-setuptools

# More Packages
pacman -S --needed --noconfirm \
	tmate tmux screen mlocate unace unrar p7zip \
	sharutils uudeview arj cabextract file-roller \
	dtc brotli axel gawk detox clang gcc gcc-libs

# pip version
pip --version

# Install Some pip packages
pip install \
	twrpdtgen telegram-send backports.lzma docopt \
	extract-dtb protobuf pycrypto docopt zstandard \
	setuptools

# Create a non-root user for AUR
useradd -m -G wheel -s /bin/bash testuser
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# AUR Packages
sudo -u testuser yay -S --needed --noconfirm \
	rename

# Setup the Android Build Environment
cd /tmp/scripts
sudo chmod -R a+rwx .
sudo -u testuser bash ./aosp-build-env.sh
cd -

# Use python2 by default
ln -sf /usr/bin/python2 /usr/bin/python
