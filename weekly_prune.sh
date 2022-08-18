#!/bin/ash
set -xe
set -o pipefail

echo "pruning old backups"
/bin/restic -r /backup/ServerBackup --keep-within 1m --password-file /secrets/pass_file.txt forget --prune
/bin/restic -r /backup/ServerBackup --password-file /secrets/pass_file.txt check
echo "done pruning"