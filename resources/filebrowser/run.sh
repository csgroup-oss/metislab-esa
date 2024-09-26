#!/bin/bash

DB_FILE=$(mktemp /tmp/filebrowser-XXXX.db)
USER=$(whoami)

# list of arguments expected in the input
optstring=":p:"

while getopts ${optstring} arg; do
    case ${arg} in
        p)
            PORT=$OPTARG
            ;;
        :)
            echo "$0: Must supply an argument to -$OPTARG." >&2
            exit 1
            ;;
        ?)
            echo "Invalid option: -${OPTARG}."
            exit 2
            ;;
    esac
done

# Configure filebrowser
touch ${DB_FILE}

# Init filebrowser configuration
filebrowser config init --database=${DB_FILE} > /dev/null
# Add admin user
# filebrowser users add admin ${FILEBROWSER_ADMIN_PWD} --perm.admin=true --database=${DB_FILE} > /dev/null

# Configure filebrowser
# As Filebrowser is secured behind Jupyter Server Proxy, authentication is disable in Filebrowser
filebrowser config set --root="${HOME}" --baseurl="${JUPYTERHUB_SERVICE_PREFIX%%/}/filebrowser" --auth.method=noauth --branding.name="Filebrowser" --branding.disableExternal --signup=false --perm.admin=false --perm.create=false --perm.delete=false --perm.download=true --perm.execute=false --perm.admin=false --perm.create=false --perm.delete=false --perm.modify=false --perm.rename=false --perm.share=false  --database=${DB_FILE} > /dev/null

# Add new user with the given permissions and scope
filebrowser users add "${USER}" "" --perm.admin=false --perm.create=true --perm.delete=true --perm.download=true --perm.execute=false --perm.modify=true --perm.rename=true --perm.share=false --lockPassword=true --database=${DB_FILE} --scope="${HOME}" > /dev/null

# Start filebrowser
/usr/local/bin/filebrowser --port=$PORT --database=${DB_FILE}