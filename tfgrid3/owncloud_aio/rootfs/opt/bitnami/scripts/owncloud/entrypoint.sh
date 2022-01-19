#!/bin/bash

# Run mariadb entrypoint
. /opt/bitnami/scripts/mariadb/entrypoint.sh

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purpose

# Load ownCloud environment
. /opt/bitnami/scripts/owncloud-env.sh

# Load libraries
. /opt/bitnami/scripts/libbitnami.sh
. /opt/bitnami/scripts/liblog.sh
. /opt/bitnami/scripts/libwebserver.sh

print_welcome_page


info "** Starting ownCloud setup **"
/opt/bitnami/scripts/"$(web_server_type)"/setup.sh
/opt/bitnami/scripts/php/setup.sh
/opt/bitnami/scripts/mysql-client/setup.sh
/opt/bitnami/scripts/owncloud/setup.sh
/post-init.sh
info "** ownCloud setup finished! **"


echo ""
exec "$@"