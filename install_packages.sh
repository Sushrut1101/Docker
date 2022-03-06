#!/bin/bash

# Uncomment community [multilib] repository
sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

# Update
pacman -Syyu --noconfirm

# Install Basic Packages
pacman -S --noconfirm \
        sudo nano git curl wget rsync aria2 rclone \
        python2 python3 python-pip zip unzip cmake \
        make neofetch speedtest-cli inetutils cpio \
        jdk8-openjdk lzip dpkg openssl ccache libelf

# Install Some pip packages
pip install \
    twrpdtgen telegram-send

# More Packages
pacman -S --noconfirm \
        tmate tmux screen mlocate

# Setup the Android Build Environment
git clone --depth=1 --single-branch https://github.com/akhilnarang/scripts.git /tmp/scripts
cd /tmp/scripts
sudo bash setup/arch-manjaro.sh
cd -
