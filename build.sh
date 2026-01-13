#!/bin/sh
chmod +x AppDir/AppRun

echo "Download wine..."
LATEST_WINE=$(curl -L "https://api.github.com/repos/mmtrt/WINE_AppImage/releases/latest" | jq -r .assets[0].browser_download_url)
curl -L $LATEST_WINE -o AppDir/wine.AppImage
chmod +x AppDir/wine.AppImage

if ! command -v appimagetool.AppImage >/dev/null 2>&1
then
    echo "Download AppImage tool..."
    LATEST_TOOL=$(curl -L "https://api.github.com/repos/AppImage/AppImageKit/releases/latest" | jq -r '.assets[] | select(.name | test("appimagetool-x86_64.AppImage$")) | .browser_download_url')
    curl -L $LATEST_TOOL -o appimagetool.AppImage
    chmod +x appimagetool.AppImage
fi

echo "Download winbox..."
curl -L https://download.mikrotik.com/routeros/winbox/3.42/winbox64.exe -o AppDir/winbox64.exe

echo "Build AppImage..."
if command -v appimagetool.AppImage >/dev/null 2>&1
then ARCH=x86_64 appimagetool.AppImage -v AppDir
else
    ARCH=x86_64 ./appimagetool.AppImage --appimage-extract-and-run -v AppDir
    rm ./appimagetool.AppImage
fi
