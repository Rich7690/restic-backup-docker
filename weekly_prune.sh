#!/bin/ash
set -x

url=$HEALTH_CHECK_URL
curl --no-progress-meter -i --retry 3 $url/start
echo "pruning old backups"
/bin/restic -r /storage/ServerBackup --keep-within 1m forget --prune && \
/bin/restic -r /storage/ServerBackup check

retval=$?

curl --no-progress-meter -i -f --retry 3 $url/$retval
echo "done pruning old backups"
exit $retval