# Copyright 2020 CS GROUP - France, http://www.c-s.fr
# All rights reserved

import setuptools

setuptools.setup(
    name="jupyter-proxy-filebrowser",
    version="0.0.1",
    url="https://github.com/jupyterhub/jupyter-server-proxy/tree/master/contrib/theia",
    author="Project Jupyter Contributors",
    description="projectjupyter@gmail.com",
    packages=setuptools.find_packages(),
    keywords=["Jupyter"],
    classifiers=["Framework :: Jupyter"],
    install_requires=["jupyter-server-proxy"],
    entry_points={
        "jupyter_serverproxy_servers": [
            "filebrowser = jupyter_proxy_filebrowser:setup_filebrowser",
        ]
    }
)
