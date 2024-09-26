#!/usr/bin/env bash
set -e

# Libs
apt-get update --quiet && \
DEBIAN_FRONTEND=noninteractive apt-get install --quiet --yes --no-install-recommends \
    autoconf \
    automake \
    gdal-bin \
    libgdal-dev \
    libtool \
    python3-gdal \
    libspatialindex-dev

export GDAL_CACHEMAX=128
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal
export GDAL_NUM_THREADS=$OMP_NUM_THREADS

pip install --no-cache-dir --upgrade \
    "cython~=3.0" \
    "pygdal==3.4.1.10"

layer-cleanup.sh
