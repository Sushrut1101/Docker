#!/usr/bin/env bash

# Copyright (C) 2018 Harsh 'MSF Jarvis' Shandilya
# Copyright (C) 2018 Akhil Narang
# SPDX-License-Identifier: GPL-3.0-only

# Script to setup an AOSP Build environment on Ubuntu and Linux Mint

tput reset 2>/dev/null || clear

# Ubuntu/Debian Based Distros
if [[ "$(command -v apt)" != "" ]]; then

    echo "Debian/Ubuntu Based Distro Detected"
    sleep 1

    LATEST_MAKE_VERSION="4.3"
    UBUNTU_16_PACKAGES="libesd0-dev"
    UBUNTU_20_PACKAGES="libncurses5 curl python-is-python3"
    DEBIAN_10_PACKAGES="libncurses5"
    DEBIAN_11_PACKAGES="libncurses5"
    PACKAGES=""

    sudo apt install software-properties-common -y
    sudo apt update

    # Install lsb-core packages
    sudo apt install lsb-core -y

    LSB_RELEASE="$(lsb_release -d | cut -d ':' -f 2 | sed -e 's/^[[:space:]]*//')"

    if [[ ${LSB_RELEASE} =~ "Mint 18" || ${LSB_RELEASE} =~ "Ubuntu 16" ]]; then
        PACKAGES="${UBUNTU_16_PACKAGES}"
    elif [[ ${LSB_RELEASE} =~ "Ubuntu 20" || ${LSB_RELEASE} =~ "Ubuntu 21" || ${LSB_RELEASE} =~ "Ubuntu 22" ]]; then
        PACKAGES="${UBUNTU_20_PACKAGES}"
    elif [[ ${LSB_RELEASE} =~ "Debian GNU/Linux 10" ]]; then
        PACKAGES="${DEBIAN_10_PACKAGES}"
    elif [[ ${LSB_RELEASE} =~ "Debian GNU/Linux 11" ]]; then
        PACKAGES="${DEBIAN_11_PACKAGES}"
    fi

    sudo DEBIAN_FRONTEND=noninteractive \
        apt install \
        adb autoconf automake axel bc bison build-essential \
        ccache clang cmake curl expat fastboot flex g++ \
        g++-multilib gawk gcc gcc-multilib git gnupg gperf \
        htop imagemagick lib32ncurses5-dev lib32z1-dev libtinfo5 libc6-dev libcap-dev \
        libexpat1-dev libgmp-dev '^liblz4-.*' '^liblzma.*' libmpc-dev libmpfr-dev libncurses5-dev \
        libsdl1.2-dev libssl-dev libtool libxml2 libxml2-utils '^lzma.*' lzop \
        maven ncftp ncurses-dev patch patchelf pkg-config pngcrush \
        pngquant python2.7 python-all-dev re2c schedtool squashfs-tools subversion \
        texinfo unzip w3m xsltproc zip zlib1g-dev lzip \
        libxml-simple-perl libswitch-perl apt-utils \
        ${PACKAGES} -y

    echo -e "Installing GitHub CLI"
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install -y gh

    echo -e "Setting up udev rules for adb!"
    sudo curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules -O -L https://raw.githubusercontent.com/M0Rf30/android-udev-rules/master/51-android.rules
    sudo chmod 644 /etc/udev/rules.d/51-android.rules
    sudo chown root /etc/udev/rules.d/51-android.rules
    sudo systemctl restart udev

    if [[ "$(command -v make)" ]]; then
        makeversion="$(make -v | head -1 | awk '{print $3}')"
        if [[ ${makeversion} != "${LATEST_MAKE_VERSION}" ]]; then
            echo "Installing make ${LATEST_MAKE_VERSION} instead of ${makeversion}"
            bash "$(dirname "$0")"/make.sh "${LATEST_MAKE_VERSION}"
        fi
    fi

    echo "Installing repo"
    sudo curl --create-dirs -L -o /usr/local/bin/repo -O -L https://storage.googleapis.com/git-repo-downloads/repo
    sudo chmod a+rx /usr/local/bin/repo

    echo 'Setup completed, enjoy'
    exit 0

# Arch Based Distros
elif [[ "$(command -v pacman)" != "" ]]; then

    echo "Arch Based Distro Detected"
    sleep 1

    echo 'Starting Arch-based Android build setup'

    # Sync, update, and prepare system
    echo '[1/3] Syncing repositories and updating system packages'
    sudo pacman -Syyu --noconfirm --needed multilib-devel

    # Install android build prerequisites
    echo '[2/3] Installing Android building prerequisites'
    yay -S --noconfirm --mflags "--skippgpcheck" ncurses5-compat-libs lib32-ncurses5-compat-libs aosp-devel xml2 lineageos-devel

    # Install adb and associated udev rules
    echo '[3/3] Installing adb convenience tools'
    sudo pacman -S --noconfirm --needed android-tools android-udev

    echo 'Setup completed, enjoy'
    exit 0

# Fedora/RHEL Based Distros
elif [[ "$(command -v dnf)" != "" ]]; then

    echo "Fedora Based Distro Detected"
    sleep 1

    # Packages
    sudo dnf install --skip-unavailable -y \
        android-tools autoconf213 bison bzip2 ccache curl patch \
        flex gawk gcc-c++ git glibc-devel glibc-static libstdc++-static \
        libX11-devel make mesa-libGL-devel ncurses-devel openssl \
        zlib-devel ncurses-devel.i686 readline-devel.i686 vim lzip \
        libX11-devel.i686 mesa-libGL-devel.i686 glibc-devel.i686 \
        libstdc++.i686 libXrandr.i686 zip perl-Digest-SHA wget \
        lzop openssl-devel ImageMagick schedtool vboot-utils \
        openssl-devel-engine

    # The package libncurses5 is not available, so we need to hack our way by symlinking the required library.
    sudo ln -s /usr/lib/libncurses.so.6 /usr/lib/libncurses.so.5
    sudo ln -s /usr/lib/libncurses.so.6 /usr/lib/libtinfo.so.5

    # Repo
    echo "Installing Git Repository Tool"
    sudo curl --create-dirs -L -o /usr/local/bin/repo -O -L https://storage.googleapis.com/git-repo-downloads/repo
    sudo chmod a+rx /usr/local/bin/repo

    echo 'Setup completed, enjoy'
    exit 0

# Solus
elif [[ "$(command -v eopkg)" != "" ]]; then

    echo "Solus Detected"
    sleep 1

    sudo eopkg it -c system.devel
    sudo eopkg it openjdk-8-devel curl-devel git gnupg gperf libgcc-32bit libxslt-devel lzop ncurses-32bit-devel ncurses-devel readline-32bit-devel rsync schedtool sdl1-devel squashfs-tools unzip wxwidgets-devel zip zlib-32bit-devel lzip

    # ADB/Fastboot
    sudo eopkg bi --ignore-safety https://raw.githubusercontent.com/solus-project/3rd-party/master/programming/tools/android-tools/pspec.xml
    sudo eopkg it android-tools*.eopkg
    sudo rm android-tools*.eopkg

    # udev rules
    echo "Setting up udev rules for adb!"
    sudo curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules -O -L https://raw.githubusercontent.com/M0Rf30/android-udev-rules/master/51-android.rules
    sudo chmod 644 /etc/udev/rules.d/51-android.rules
    sudo chown root /etc/udev/rules.d/51-android.rules
    sudo usysconf run -f

    echo "Installing repo"
    sudo curl --create-dirs -L -o /usr/local/bin/repo -O -L https://storage.googleapis.com/git-repo-downloads/repo
    sudo chmod a+x /usr/local/bin/repo

    echo "You are now ready to build Android!"
    exit 0

# Other Distros (Unsupported)
else

    echo "Sorry, your distro is not Supported!"
    exit 1

fi
