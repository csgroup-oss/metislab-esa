# Copyright 2024 CS GROUP - France, http://www.c-s.fr
# All rights reserved

ARG OCI_REGISTRY_PREFIX
FROM ${OCI_REGISTRY_PREFIX}metislab-core:latest
LABEL maintainer="CS GROUP"

USER root

WORKDIR /

# Add permission for `runAsUser: 65534` default securityContext used in the PrePuller hook and continous.
# It also can be overrided with https://z2jh.jupyter.org/en/stable/resources/reference.html#prepuller-hook-containersecuritycontext
# Otherwise, the chdir to the home directory will fail with an error like:
# Error response from daemon: OCI runtime create failed: container_linux.go:367: starting 
RUN chmod o+x /home/vreuser

# Feature: install gdal
RUN --mount=type=bind,source=features,target=features \
    sh features/gdal.sh && layer-cleanup.sh

# Feature: use LTR version of QGIS
RUN --mount=type=bind,source=features,target=features \
    sh features/qgis-ltr.sh && layer-cleanup.sh

## Feature: install SNAP and Snappy
RUN --mount=type=bind,source=features,target=features \
    --mount=type=bind,source=resources/snap,target=resources/snap \
    features/snap.sh && layer-cleanup.sh
ENV PATH=/usr/local/snap/bin/:$PATH

# Feature: install Filebrowser
COPY resources/filebrowser /opt/filebrowser
RUN --mount=type=bind,source=features,target=features \
    sh features/filebrowser.sh && layer-cleanup.sh

# Feature: install R
RUN --mount=type=bind,source=features,target=features \
    sh features/r.sh && layer-cleanup.sh

# Feature: install CLAMAV
RUN --mount=type=bind,source=features,target=features \
    sh features/clamav.sh && layer-cleanup.sh

# Feature: install additionnal ESA python libraries
RUN --mount=type=bind,source=requirements.txt,target=requirements.txt \
    pip install --no-cache-dir -r requirements.txt && layer-cleanup.sh

## Define standard user
USER vreuser

WORKDIR /home/vreuser

# Put tests resources
COPY resources/tests/* /opt/vre/tests/
