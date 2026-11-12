#!/bin/sh -e

## Install QGIS LTR (v3.34) and GRASS
## Remove all QGIS packages, update qgis repository to ltr and reinstall LTR version
## en_US.UTF-8 local is installed to prevent an error message when starting up GRASS
DEBIAN_FRONTEND=noninteractive apt-get remove --quiet --yes \
    qgis \
    qgis-plugin-grass \
    python3-qgis \
    qgis-providers \
    qgis-common \
    python3-qgis-common \
    python3-qgis-common \
    qgis-providers-common
add-apt-repository --remove "deb https://qgis.org/ubuntu $(lsb_release -c -s) main"
add-apt-repository "deb https://qgis.org/ubuntu-ltr $(lsb_release -c -s) main"
apt-get update --quiet
DEBIAN_FRONTEND=noninteractive apt-get install --quiet --yes --no-install-recommends \
    qgis \
    qgis-plugin-grass \
    grass
