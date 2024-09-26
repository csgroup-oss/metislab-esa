#!/usr/bin/env bash
set -e

## Install SNAP and Snappy
python_version=$(readlink /usr/bin/python3)
# Install SNAP
snap_installer_url=https://step.esa.int/downloads/10.0/installers/esa-snap_all_linux-10.0.0.sh
printf "downloading SNAP..." && wget --quiet ${snap_installer_url} -O esa-snap_sentinel_unix.sh && echo "[done]"
printf "installing SNAP..." && sh esa-snap_sentinel_unix.sh -q -varfile resources/snap/esa_snap_response.varfile && echo "[done]" && rm ./esa-snap_sentinel_unix.sh
echo 'snap.log.level = "ALL"' >> /usr/local/snap/etc/snap.properties
# printf "Testing SNAP..." && /usr/local/snap/bin/snap --nogui --nosplash --python /usr/bin/${python_version} /usr/local/lib/${python_version}/dist-packages/ || cat /usr/local/lib/${python_version}/dist-packages/snappy/snappyutil.log

resources/snap/stop_updates.sh
# Install Snappy
snappy_directory=/usr/local/lib/${python_version}/dist-packages/esa_snappy
mkdir -p $snappy_directory
printf "installing Snappy..." && cd /usr/local/snap/bin && ./snappy-conf $(which python) /usr/local/lib/${python_version}/dist-packages && echo "[done]" && cd /
printf "Snappy test result: \n" && cat ${snappy_directory}/snappyutil.log
printf "Testing SNAP..." && /usr/local/snap/bin/snap --nogui --nosplash --python /usr/bin/${python_version} /usr/local/lib/${python_version}/dist-packages/
# Now usable with:
# import esa_snappy

# Tests
# https://senbox.atlassian.net/wiki/spaces/SNAP/pages/2499051521/Configure+Python+to+use+the+new+SNAP-Python+esa_snappy+interface+SNAP+version+10
cp resources/snap/snap_tests.py /opt/vre/tests/
