#!/bin/sh
#
# Download wine
LATEST_WINE=$(curl -L "https://api.github.com/repos/mmtrt/WINE_AppImage/releases/latest" | jq -r .assets[0].browser_download_url)
curl -L $LATEST_WINE -o AppDir/wine.AppImage
chmod +x AppDir/wine.AppImage
#
# Download appimagetool
LATEST_TOOL=$(curl -L "https://api.github.com/repos/AppImage/AppImageKit/releases/latest" | jq -r '.assets[] | select(.name | test("appimagetool-x86_64.AppImage$")) | .browser_download_url')
curl -L $LATEST_TOOL -o appimagetool.AppImage
chmod +x appimagetool.AppImage
#
# Download winbox
curl -L https://mt.lv/winbox64 -o AppDir/winbox64.exe
#
# Build
ARCH=x86_64 appimagetool.AppImage -v AppDir
