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
dnf install --skip-unavailable -y \
	sudo git nano tmate aria2 rsync rclone \
	python zip unzip jq neovim pipx \
	unrar python3-pip tmate make cmake clang glibc \
	bc ag unace sharutils uudeview arj cabextract \
	file-roller dtc brotli axel detox cpio lz4 \
	python3-devel xz-devel speedtest-cli zsh \
	util-linux-user wget fastfetch

# Install 7zz
URL_7ZZ="$(curl -sL https://api.github.com/repos/ip7z/7zip/releases/latest | grep -oP '(?<="browser_download_url": ")[^"]*linux-x64\.tar\.xz')"
wget "${URL_7ZZ}" -O 7zz.tar.xz
tar -xJf 7zz.tar.xz -C /usr/local/bin 7zz 7zzs
rm 7zz.tar.xz

# Use pipx instead of pip
ln -sf /usr/bin/pipx /usr/local/bin/pip
ln -sf /usr/bin/pipx /usr/local/bin/pip3

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

# Speedtest
ln -sf /usr/bin/speedtest{-cli,}

# Replace vim with neovim
ln -sf /usr/bin/{n,}vim

# Exit
exit 0
