#!/bin/bash
# Copyright 2024 CS GROUP - France, http://www.c-s.fr
# All rights reserved

# Install SNAP and Snappy
set -e

PYTHON_EXECUTABLE=$(which python)
SITE_PACKAGES=$(python -c "import sysconfig; print(sysconfig.get_paths()['purelib'])")

# Install SNAP
snap_installer_url=https://download.esa.int/step/snap/12.0/installers/esa-snap_all_linux-12.0.0.sh
printf "downloading SNAP..." && wget --quiet ${snap_installer_url} -O esa-snap_sentinel_unix.sh && echo "[done]"
printf "installing SNAP..." && sh esa-snap_sentinel_unix.sh -q -varfile resources/snap/esa_snap_response.varfile && echo "[done]" && rm ./esa-snap_sentinel_unix.sh
echo 'snap.log.level = "ALL"' >> /usr/local/snap/etc/snap.properties
# printf "Testing SNAP..." && /usr/local/snap/bin/snap --nogui --nosplash --python /usr/bin/${python_version} /usr/local/lib/${python_version}/dist-packages/ || cat /usr/local/lib/${python_version}/dist-packages/snappy/snappyutil.log

bash resources/snap/stop_updates.sh
# Install Snappy
python -m pip install --no-cache-dir esa-snappy jpy

# /usr/local/snap/bin/snap --nosplash --nogui --modules --install eu.esa.snap.esa.snappy
snappy_directory=${SITE_PACKAGES}/esa_snappy
mkdir -p $snappy_directory
printf "installing Snappy..." && cd /usr/local/snap/bin && ./snappy-conf ${PYTHON_EXECUTABLE} ${SITE_PACKAGES} && echo "[done]" && cd "$HOME"
printf "Snappy test result: \n" && cat ${snappy_directory}/snappyutil.log
printf "Testing SNAP..." && /usr/local/snap/bin/snap --nogui --nosplash --python ${PYTHON_EXECUTABLE} ${SITE_PACKAGES}
# Now usable with:
# import esa_snappy

# Tests
# https://senbox.atlassian.net/wiki/spaces/SNAP/pages/2499051521/Configure+Python+to+use+the+new+SNAP-Python+esa_snappy+interface+SNAP+version+10
cp resources/snap/snap_tests.py /opt/vre/tests/
