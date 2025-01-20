#!/usr/bin/env bash

# Download apktool
wget $(curl -sL https://api.github.com/repos/iBotPeaches/Apktool/releases/latest | grep "browser_download_url" | grep ".jar" | cut -d : -f 2,3 | tr -d '"') -O /usr/local/bin/apktool.jar

# Download transfer
bash -c "$(curl -sL https://git.io/file-transfer)"
mv transfer /usr/local/bin/transfer
chmod +x /usr/local/bin/transfer

# Extra zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

sed -i 's|plugins=(git)|plugins=(git zsh-autosuggestions zsh-syntax-highlighting)|g' ~/.zshrc

# Install 7zz
URL_7ZZ="$(curl -sL https://api.github.com/repos/ip7z/7zip/releases/latest | grep -oP '(?<="browser_download_url": ")[^"]*linux-x64\.tar\.xz')"
wget "${URL_7ZZ}" -O 7zz.tar.xz
tar -xJf 7zz.tar.xz -C /usr/local/bin 7zz 7zzs
rm 7zz.tar.xz
ln -sf /usr/local/bin/7z{z,}
