#!/bin/ash
set -xe
set -o pipefail

echo "pruning old backups"
/bin/restic -r /storage/ServerBackup --keep-within 1m forget --prune && /bin/restic -r /storage/ServerBackup check
echo "done pruning"