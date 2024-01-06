#!/bin/sh

URL="https://github.com/GloriousEggroll/wine-ge-custom/releases/download/GE-Proton8-25/wine-lutris-GE-Proton8-25-x86_64.tar.xz"
HASH="466f5d77d7b9821f1023859a5e467b9344afd25cb3018b04ac0e89c9d25fd8c0"

echo "Downloading the file..."
curl -L $URL -o wine-lutris.tar.xz

echo "Validating the hash..."
DOWNLOADED_HASH=$(sha256sum wine-lutris.tar.xz | awk '{ print $1 }')

if [ "$DOWNLOADED_HASH" != "$HASH" ]; then
    echo "Hash mismatch. Exiting."
    exit 1
fi

echo "Extracting the archive..."
tar -xvf wine-lutris.tar.xz
cp -r lutris*/* usr/

echo "Performing cleanup..."
rm -rf *.tar.xz \
       lutris* \
       AppDir/usr/bin/msidb \
       AppDir/usr/bin/wineconsole \
       AppDir/usr/bin/msiexec \
       AppDir/usr/bin/notepad \
       AppDir/usr/bin/regedit \
       AppDir/usr/bin/regsvr32 \
       AppDir/usr/bin/wine-preloader \
       AppDir/usr/bin/wine64-preloader \
       AppDir/usr/bin/wineconsole \
       AppDir/usr/bin/winedbg \
       AppDir/usr/bin/winefile \
       AppDir/usr/bin/winemine \
       AppDir/usr/bin/winepath \
       AppDir/usr/share/man \
       AppDir/usr/share/applications/wine.desktop

echo "Done"
mkdir -p $(pwd)/AppDir/var/data/wine
