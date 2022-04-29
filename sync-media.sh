#!/bin/ash
set -xe
set -o pipefail

echo "Syncing Media"
rsync -a /media/ /backup/Media/
echo "Finished syncing Media"
