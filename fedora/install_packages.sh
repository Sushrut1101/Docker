#!/usr/bin/env bash

# Make dnf faster
echo "max_parallel_downloads=20" >> /etc/dnf/dnf.conf
echo "fastestmirror=True" >> /etc/dnf/dnf.conf

# dnf: Set "Y" as the default option
echo "defaultyes=True" >> /etc/dnf/dnf.conf

# Enable RPM Fusion Repos
dnf install -y \
	https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
	https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Update
dnf update -y
dnf upgrade -y

# Install basic packages
dnf install -y \
	sudo git nano neofetch tmate aria2 rsync rclone \
	python python2 zip unzip p7zip p7zip-plugins jq \
	unrar python3-pip tmate make cmake clang glibc \
	bc ag unace sharutils uudeview arj cabextract \
	file-roller dtc brotli axel detox cpio lz4 \
	python3-devel xz-devel speedtest-cli zsh \
	util-linux-user

# git configuration
git config --global user.name Sushrut1101
git config --global user.email guptasushrut@gmail.com
git config --global color.ui auto

# zsh
chsh -s /bin/zsh root
curl -sL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

# Android build Environment
bash /tmp/scripts/android_build_env.sh

# Setup android_tools
bash /tmp/scripts/android_tools_setup.sh

# Use python2 by default
ln -sf /usr/bin/python{2,}

# Speedtest
ln -sf /usr/bin/speedtest{-cli,}

# Exit
exit 0
