#!/bin/bash
# Copyright 2024 CS GROUP - France, http://www.c-s.fr
# All rights reserved

# QGIS and GRASS from the official QGIS APT repository.
# Long Term Release repository: it is the most recent one available for Ubuntu 24.04 (noble).
# See https://qgis.org/resources/installation-guide/#debian--ubuntu
set -e

install -d -m 0755 /etc/apt/keyrings
wget -q https://download.qgis.org/downloads/qgis-archive-keyring.gpg -O /etc/apt/keyrings/qgis-archive-keyring.gpg
cat > /etc/apt/sources.list.d/qgis.sources <<SOURCES
Types: deb
URIs: https://qgis.org/ubuntu-ltr
Suites: $(lsb_release -cs)
Architectures: amd64
Components: main
Signed-By: /etc/apt/keyrings/qgis-archive-keyring.gpg
SOURCES

apt-get update --quiet
DEBIAN_FRONTEND=noninteractive apt-get install --quiet --yes --no-install-recommends \
    qgis \
    qgis-plugin-grass \
    grass
