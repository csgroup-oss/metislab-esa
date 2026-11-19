#!/bin/bash
# Copyright 2024 CS GROUP - France, http://www.c-s.fr
# All rights reserved

# R 4.5 (required by SNAP 12) and its Jupyter kernel.
# The CRAN repository for Ubuntu only has one suite per Ubuntu release
# (<codename>-cran40) holding every R version: R is pinned to 4.5.x.
# See https://cloud.r-project.org/bin/linux/ubuntu/
set -e

R_VERSION_PIN="4.5.*"

install -d -m 0755 /etc/apt/keyrings
wget -q https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc -O /etc/apt/keyrings/cran_ubuntu_key.asc
cat > /etc/apt/sources.list.d/cran.sources <<SOURCES
Types: deb
URIs: https://cloud.r-project.org/bin/linux/ubuntu
Suites: $(lsb_release -cs)-cran40/
Signed-By: /etc/apt/keyrings/cran_ubuntu_key.asc
SOURCES
cat > /etc/apt/preferences.d/r-version <<PREFS
Package: r-base r-base-core r-base-dev r-base-html r-recommended r-doc-html r-doc-info r-doc-pdf
Pin: version ${R_VERSION_PIN}
Pin-Priority: 1001
PREFS

DEBIAN_FRONTEND=noninteractive apt-get update --quiet
DEBIAN_FRONTEND=noninteractive apt-get install --quiet --yes --no-install-recommends r-base r-base-dev

# Install R Kernel
R -e "install.packages('IRkernel', repos='https://cloud.r-project.org')"
R -e "IRkernel::installspec(user = FALSE)"
