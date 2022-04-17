#!/bin/ash
set -xe
set -o pipefail

curl --no-progress-meter -i --retry 3 $HEALTH_CHECK_URL/start

echo "Backing up storage drive"
test -e /config/excludes.txt
/bin/restic --exclude-file=/config/excludes.txt -r /storage/ServerBackup backup /storage
echo "Syncing to b2"
/bin/rclone sync /storage/ServerBackup b2:Backup-rt/restic
echo "Syncing to gdrive"
/bin/rclone sync /storage/ServerBackup gcache:/ServerBackup
echo "calling ping service"
curl --no-progress-meter -i -f --retry 3 $HEALTH_CHECK_URL



