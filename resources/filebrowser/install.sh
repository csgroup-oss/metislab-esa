#!/bin/bash
# Copyright 2024 CS GROUP - France, http://www.c-s.fr
# All rights reserved

set -e

FILEBROWSER_VERSION="2.15.0"
RESOURCES_PATH=/opt/filebrowser

echo "Installing Filebrowser. Please wait..."
cp -r resources/filebrowser $RESOURCES_PATH
rm -f $RESOURCES_PATH/install.sh
chmod -R +rX $RESOURCES_PATH
chmod +x $RESOURCES_PATH/run.sh

mkdir -p /tmp/filebrowser
cd /tmp/filebrowser
wget -q https://github.com/filebrowser/filebrowser/releases/download/v$FILEBROWSER_VERSION/linux-amd64-filebrowser.tar.gz -O ./filebrowser.tar.gz
tar -xzf ./filebrowser.tar.gz
chmod +x ./filebrowser
mv ./filebrowser /usr/local/bin/filebrowser
cd /
rm -r /tmp/filebrowser
wget -q https://github.com/filebrowser/filebrowser/raw/master/frontend/public/img/logo.svg -O /usr/share/icons/hicolor/scalable/apps/filebrowser.svg
pip install --no-cache-dir $RESOURCES_PATH
