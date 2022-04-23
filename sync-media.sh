#!/bin/ash
set -xe
set -o pipefail

echo "Syncing Media"
/bin/rclone sync /media gcrypt:/Media
echo "Finished syncing Media"
