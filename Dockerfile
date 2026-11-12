# Copyright 2024 CS GROUP - France, http://www.c-s.fr
# All rights reserved

# The ONBUILD instructions of cnes/base-image (Pangeo logic) are only triggered for images
# directly based on it: they are replayed here on top of metislab-core.
# apt.txt, environment.yml and requirements.txt only list what is added on top of metislab-core.
ARG OCI_REGISTRY_PREFIX=
ARG CORE_IMAGE_TAG=latest
FROM ${OCI_REGISTRY_PREFIX}metislab-core:${CORE_IMAGE_TAG}
LABEL maintainer="CS GROUP"

ENV PATH=/usr/local/snap/bin:${PATH}

USER root
WORKDIR ${HOME}

# apt packages
RUN --mount=type=bind,source=apt.txt,target=apt.txt \
    apt-get update --fix-missing \
    # Read apt.txt line by line, and execute apt-get install -y for each line in apt.txt
    && xargs -a apt.txt apt-get install -y \
    && layer-cleanup.sh

# conda environment
USER ${NB_USER}
RUN --mount=type=bind,source=environment.yml,target=environment.yml \
    mamba env update --name ${CONDA_ENV} -f environment.yml \
    && mamba clean -yaf \
    && find ${CONDA_DIR} -follow -type f -name '*.a' -delete \
    && find ${CONDA_DIR} -follow -type f -name '*.js.map' -delete

# pip packages
RUN --mount=type=bind,source=requirements.txt,target=requirements.txt \
    ${NB_PYTHON_PREFIX}/bin/pip install --no-cache -r requirements.txt

# features
USER root
RUN --mount=type=bind,source=resources,target=resources \
    for script in $(find resources -type f -name install.sh); do \
        echo "Executing $script"; \
        bash "$script" || exit 1; \
        layer-cleanup.sh; \
    done

# tests
RUN --mount=type=bind,source=resources/tests,target=resources/tests \
    mkdir -p /opt/vre/tests \
    && cp resources/tests/* /opt/vre/tests/ \
    && chmod -R +rX /opt/vre/

# Features run as root with HOME=${HOME}: give back to the user the files they created (e.g. ~/.snap, ~/.npm)
RUN chown -R ${NB_USER}:${NB_USER} ${HOME}

USER ${NB_USER}
