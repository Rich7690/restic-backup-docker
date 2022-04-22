#!/bin/ash
set -xe
set -o pipefail

echo "Backing up storage drive"
test -e /config/excludes.txt
/bin/restic --exclude-file=/config/excludes.txt -r /storage/ServerBackup backup /storage
echo "Syncing to b2"
/bin/rclone sync --b2-hard-delete /storage/ServerBackup b2:Backup-rt/restic
echo "Syncing to gdrive"
/bin/rclone sync /storage/ServerBackup gcache:/ServerBackup


