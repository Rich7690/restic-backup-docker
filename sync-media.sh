#!/bin/ash
set -xe
set -o pipefail

echo "Syncing Media"
/bin/rclone sync /storage/Media gcrypt:/Media
echo "Finished syncing Media"
