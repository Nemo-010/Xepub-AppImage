#!/bin/sh
set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export DESKTOP=/usr/share/applications/xepub.desktop
export ICON=/usr/share/icons/hicolor/scalable/apps/xepub.svg
export DEPLOY_PYTHON=1
export APPNAME=Xepub
export USE_HOST_DRIVERS_EXPERIMENTAL=1

# Deploy dependencies
quick-sharun \
  /usr/bin/xepub \
  /usr/share/xepub \
  /usr/lib/libgtk-3.so* \
  /usr/lib/libwebkit2gtk-4.1.so* \
  /usr/lib/libxapp.so*

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the AppImage
quick-sharun --simple-test ./dist/*.AppImage
