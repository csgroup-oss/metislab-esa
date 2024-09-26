#!/bin/sh -e

# Install CLAMAV
DEBIAN_FRONTEND=noninteractive apt-get update --quiet
apt-get install --quiet --yes --no-install-recommends clamdscan
echo "TCPSocket 3310\nTCPAddr clamav" > /etc/clamav/clamd.conf
echo "alias clamdscan=\"clamdscan -m\"" >> /etc/bash.bashrc
