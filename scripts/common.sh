#!/usr/bin/env bash

# Install uv
UV_INSTALL_DIR="/usr/local/bin" bash -c "$(curl -LsSf https://astral.sh/uv/install.sh)"
rm -rf /usr/local/bin/env{,.fish}

# Download apktool
wget $(curl -sL https://api.github.com/repos/iBotPeaches/Apktool/releases/latest | grep "browser_download_url" | grep ".jar" | cut -d : -f 2,3 | tr -d '"') -O /usr/local/bin/apktool.jar

# Download transfer
bash -c "$(curl -sL https://git.io/file-transfer)"
mv transfer /usr/local/bin/transfer
chmod +x /usr/local/bin/transfer

# Setup Oh My Zsh
chsh -s /bin/zsh root
bash -c "$(curl -sL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

sed -i 's|plugins=(git)|plugins=(git zsh-autosuggestions zsh-syntax-highlighting)|g' ~/.zshrc

# Create 7zz symlink
ln -sf /usr/local/bin/7z{z,}
