#!/bin/bash

# Enable Parallel Downloading
printf "\nParallelDownloads = 20\n" >> /etc/pacman.conf

# Enable the community [multilib] repository
printf "\n[multilib]\n%s\n" 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf

# Enable the archlinuxcn repo
printf "\n[archlinuxcn]\n%s\n" 'Server = https://repo.archlinuxcn.org/$arch' >> /etc/pacman.conf

# Generate pacman keys
pacman-key --init

# Sign archlinuxcn keys
pacman-key --lsign-key "farseerfc@archlinux.org"

# Install archlinuxcn keys
pacman -Sy --noconfirm archlinuxcn-keyring

# Upgrade
pacman -Syyu --needed --noconfirm 2>&1 | grep -v "warning: could not get file information"

# Install Basic Packages
pacman -Sy --needed --noconfirm \
	sudo nano git curl wget rsync aria2 rclone \
	python3 python-pip zip systemd cmake make \
	fastfetch speedtest-cli inetutils cpio repo \
	jdk8-openjdk lzip dpkg openssl ccache dbus \
	libelf base-devel openssh lz4 jq go ncurses \
	bison flex ninja uboot-tools z3 glibc dpkg \
	multilib-devel bc htop python-setuptools   \
	util-linux man-pages zsh dbus neovim python-pipx \
	less perl-rename

# More Packages
pacman -Sy --needed --noconfirm \
	tmate tmux screen mlocate unace unrar 7zip \
	sharutils uudeview arj cabextract file-roller \
	dtc brotli axel gawk detox clang gcc gcc-libs \
	flatpak libxcrypt-compat hyfetch

# Downgrade `unzip` - from archlinuxcn
yes | pacman -S archlinuxcn/unzip

# archlinuxcn packages
pacman -S --needed --noconfirm \
    python2 yay

# Use pipx instead of pip
ln -sf /usr/bin/pipx /usr/local/bin/pip
ln -sf /usr/bin/pipx /usr/local/bin/pip3

# python and pip version
python --version; pip --version

# Install Some pip packages
pip install \
	twrpdtgen telegram-send backports.lzma docopt \
	extract-dtb protobuf pycrypto docopt zstandard \
	setuptools future requests humanize clint lz4 \
	pycryptodome

# pip git packages
pip install \
	git+https://github.com/samloader/samloader.git

# Use perl-rename by default
ln -sf /usr/bin/perl-rename /usr/local/bin/rename

# Create a non-root user for AUR
useradd -m -G wheel -s /bin/bash testuser
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Try to update yay
sudo -u testuser yay -S --noconfirm yay

# Setup systemd
find /etc/systemd/system /lib/systemd/system -path '*.wants/*' -not -name '*dbus*' -not -name '*journald*' -not -name '*systemd-tmpfiles*' -not -name '*systemd-user-sessions*' -exec rm -rf {} \;
systemctl set-default multi-user.target

# Setup the Android Build Environment
cd /tmp/scripts
sudo chmod -R a+rwx .
sudo -u testuser bash ./android_build_env.sh
cd -

# Setup Android Tools
sudo bash /tmp/scripts/android_tools_setup.sh

# Replace vim with neovim
ln -sf /usr/bin/{n,}vim
