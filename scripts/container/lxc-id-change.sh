#!/bin/bash
# Change LXC container ID and associated storage

set -e

OLD_ID=$1
NEW_ID=$2
VG_NAME="pve"  # Default volume group

if [ -z "$OLD_ID" ] || [ -z "$NEW_ID" ]; then
    echo "Usage: $0 <old_id> <new_id>"
    exit 1
fi

# Find the volume
VOLUME_INFO=$(lvs | grep "vm-${OLD_ID}-disk-0" || true)
if [ -z "$VOLUME_INFO" ]; then
    echo "Error: No volume found for container $OLD_ID"
    exit 1
fi

echo "Renaming LXC container $OLD_ID to $NEW_ID"

# Rename the logical volume
lvrename "$VG_NAME" "vm-${OLD_ID}-disk-0" "vm-${NEW_ID}-disk-0"

# Update config file
if [ -f "/etc/pve/lxc/${OLD_ID}.conf" ]; then
    mv "/etc/pve/lxc/${OLD_ID}.conf" "/etc/pve/lxc/${NEW_ID}.conf"
    sed -i "s/vm-${OLD_ID}-disk-0/vm-${NEW_ID}-disk-0/g" "/etc/pve/lxc/${NEW_ID}.conf"
else
    echo "Warning: Config file /etc/pve/lxc/${OLD_ID}.conf not found"
fi

echo "Successfully renamed container. You can start it with: pct start $NEW_ID"
