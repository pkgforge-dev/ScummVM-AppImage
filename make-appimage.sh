#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q scummvm | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/org.scummvm.scummvm.svg
export DESKTOP=/usr/share/applications/org.scummvm.scummvm.desktop
export DEPLOY_OPENGL=1
export DEPLOY_GTK=1
export GTK_DIR=gtk-3.0
export DEPLOY_PIPEWIRE=1 # needed for libfluidsynth

# Deploy dependencies
quick-sharun /usr/bin/scummvm

# Turn AppDir into AppImage
quick-sharun --make-appimage
