#!/bin/ash
set -xe
set -o pipefail

echo "Backing up storage drive"
test -e /config/excludes.txt
/bin/restic --exclude-file=/config/excludes.txt -r /backup/ServerBackup/ backup /storage
echo "Syncing to b2"
/bin/rclone sync --b2-hard-delete /backup/ServerBackup/ b2:Backup-rt/restic