#!/usr/bin/env bash

# Download apktool
wget $(curl -sL https://api.github.com/repos/iBotPeaches/Apktool/releases/latest | grep "browser_download_url" | grep ".jar" | cut -d : -f 2,3 | tr -d '"') -O /usr/local/bin/apktool.jar
