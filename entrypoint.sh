#!/bin/bash
# Docker entrypoint
#

set -eu

# 初期ユーザー作成
USERS=(${DEFAULT_USERS//,/ })
for USER in ${USERS[@]}; do
  /dovecot_useradd.sh $USER
done

# start services
echo "Starting services..."
/etc/init.d/dovecot start
/etc/init.d/cron start

exec "$@"