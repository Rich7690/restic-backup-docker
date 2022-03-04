#!/bin/ash
set -e 
set -o pipefail

curl --retry 3 $HEALTH_CHECK_URL/start

echo "Backing up storage drive"
test -e /bin/excludes.txt
/bin/restic --exclude-file=/bin/excludes.txt -r /storage/ServerBackup backup /storage
echo "Syncing to b2"
/bin/rclone sync /storage/ServerBackup b2:Backup-rt/restic
echo "Syncing to gdrive"
/bin/rclone sync /storage/ServerBackup gcache:/ServerBackup
echo "calling ping service"
curl -f --retry 3 $HEALTH_CHECK_URL



