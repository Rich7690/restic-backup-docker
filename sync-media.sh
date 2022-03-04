#!/bin/ash
set -x
url=$HEALTH_CHECK_URL
curl --retry 3 $url/start
echo "Syncing Media"

/bin/rclone sync /storage/Media gcrypt:/Media

set -e
retval=$?
echo $retval

curl -f --retry 3 $url/$retval

echo "Finished syncing Media"
exit $retval