#!/bin/bash
# Copyright 2020 CS GROUP - France, http://www.c-s.fr
# All rights reserved

# Disable Check for updates
#   see https://senbox.atlassian.net/wiki/spaces/SNAP/pages/447119383/Disable+Check+for+Updates


# 1 Disable Check for Modules-Updates in SNAP Desktop

conf_file='/usr/local/snap/etc/snap.conf '

sed -i 's/default_options="/default_options="-J-Dplugin.manager.check.interval=NEVER /g' ${conf_file}

# 2 Disable Check for Updates in GPT

properties_file='/usr/local/snap/etc/snap.properties'

echo '' >> ${properties_file}
echo '#Disable Check for updates in GPT' >> ${properties_file}
echo 'snap.versionCheck.interval=NEVER'  >> ${properties_file}
echo '' >> ${properties_file}
