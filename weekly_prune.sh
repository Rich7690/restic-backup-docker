#!/bin/ash
set -x

url=$HEALTH_CHECK_URL
curl --retry 3 $url/start
echo "pruning old backups"
/bin/restic -r /storage/ServerBackup --keep-within 1m forget --prune && \
/bin/restic -r /storage/ServerBackup check

retval=$?

curl -f --retry 3 $url/$retval
echo "done pruning old backups"
exit $retval