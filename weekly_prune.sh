#!/bin/ash
set -xe
set -o pipefail

echo "pruning old backups"
/bin/restic -r /backup/ServerBackup --keep-within 1m forget --prune && /bin/restic -r /backup/ServerBackup check
echo "done pruning"