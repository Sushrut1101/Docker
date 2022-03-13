#!/bin/bash

# Uncomment community [multilib] repository
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# Update
pacman -Syy --noconfirm && pacman -Syyu --noconfirm

# Install Basic Packages
pacman -S --needed --noconfirm \
        sudo nano git curl wget rsync aria2 rclone \
        python2 python3 python-pip zip unzip cmake \
        make neofetch speedtest-cli inetutils cpio \
        jdk8-openjdk lzip dpkg openssl ccache libelf \
        base-devel repo

# Install Some pip packages
pip install \
        twrpdtgen telegram-send

# More Packages
pacman -S --noconfirm \
        tmate tmux screen mlocate

# Create a non-root user for AUR
useradd -m -G wheel -s /bin/bash testuser
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Install yay
git clone https://aur.archlinux.org/yay.git /tmp/yaygit
cd /tmp/yaygit
sudo chmod -R a+rwx .
sudo -u testuser makepkg -si --needed --noconfirm
cd /root
rm -rf /tmp/yaygit

# Setup the Android Build Environment
sudo -u testuser bash /tmp/aosp-build-env.sh

# Use python2 by default
ln -sf /usr/bin/python2 /usr/bin/python
