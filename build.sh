#!/bin/sh

# Get wine version
LATEST=$(curl -L "https://api.github.com/repos/mmtrt/WINE_AppImage/releases/latest" | jq -r .assets[0].browser_download_url)

# Download wine
curl -L $LATEST -o AppDir/wine.AppImage
chmod +x AppDir/wine.AppImage

# Download WinBox
curl -L https://mt.lv/winbox64 -o AppDir/winbox64.exe
