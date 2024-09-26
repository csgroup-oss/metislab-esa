#!/bin/sh -e

# Install R
DEBIAN_FRONTEND=noninteractive apt-get update --quiet
apt-get install --quiet --yes --no-install-recommends software-properties-common dirmngr

wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# add the R 4.0 repo from CRAN
add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

# Install R Kernel
DEBIAN_FRONTEND=noninteractive apt-get install --quiet --yes --no-install-recommends r-base gdebi-core
R -e "install.packages('IRkernel')"
R -e "IRkernel::installspec(user = FALSE)"
