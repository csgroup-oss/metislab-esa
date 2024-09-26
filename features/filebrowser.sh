#!/bin/sh -e

chmod -R +rX /opt/filebrowser
echo "Installing Filebrowser. Please wait..."
RESOURCES_PATH=/opt/filebrowser
FILEBROWSER_VERSION="2.15.0"
mkdir -p $RESOURCES_PATH/filebrowser
cd $RESOURCES_PATH/filebrowser
wget -q https://github.com/filebrowser/filebrowser/releases/download/v$FILEBROWSER_VERSION/linux-amd64-filebrowser.tar.gz -O ./filebrowser.tar.gz
tar -xzf ./filebrowser.tar.gz
chmod +x "./filebrowser"
mv "./filebrowser" "/usr/local/bin/filebrowser"
cd $RESOURCES_PATH
rm -r $RESOURCES_PATH/filebrowser
wget -q https://github.com/filebrowser/filebrowser/raw/master/frontend/public/img/logo.svg -O /usr/share/icons/hicolor/scalable/apps/filebrowser.svg
pip install /opt/filebrowser
