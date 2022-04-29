#!/bin/ash
set -xe
set -o pipefail

echo "Syncing Media"
rsync -ahu --delete /media/ /backup/Media/
echo "Finished syncing Media"
