# Copyright 2020 CS GROUP - France, http://www.c-s.fr
# All rights reserved

"""
Return config on servers

See https://jupyter-server-proxy.readthedocs.io/en/latest/server-process.html
for more information.
"""
import os


def setup_filebrowser():

    def _get_filebrowser_cmd(port):

        return [
            "/opt/filebrowser/run.sh",
            "-p" + str(port),
        ]

    return {
        "command": _get_filebrowser_cmd,
        "launcher_entry": {
            "title": "FileBrowser",
            "icon_path": os.path.join(
                "/usr/share", "icons", "hicolor/scalable/apps",
                "filebrowser.svg")
        },
        "new_browser_tab": True,
    }
