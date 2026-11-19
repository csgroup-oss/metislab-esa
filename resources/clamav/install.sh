#!/bin/bash
# Copyright 2024 CS GROUP - France, http://www.c-s.fr
# All rights reserved

# ClamAV client (clamdscan is installed from apt.txt)
set -e

printf "TCPSocket 3310\nTCPAddr clamav\n" > /etc/clamav/clamd.conf
