#!/bin/bash
# Deploy VM from cloud-init template

TEMPLATE_ID=$1
NEW_ID=$2
STORAGE="local-lvm"

if [ -z "$2" ]; then
    echo "Usage: $0 <template_id> <new_id> [storage]"
    exit 1
fi

[ -n "$3" ] && STORAGE=$3

echo "Cloning VM template $TEMPLATE_ID to new VM $NEW_ID"
qm clone "$TEMPLATE_ID" "$NEW_ID" --name "vm-$NEW_ID" --full --storage "$STORAGE"

echo "Setting cloud-init parameters"
qm set "$NEW_ID" --ciuser admin \
    --cipassword "$(openssl rand -base64 12)" \
    --sshkeys ~/.ssh/proxmox_rsa.pub \
    --ipconfig0 ip=dhcp

echo "Starting VM $NEW_ID"
qm start "$NEW_ID"

echo "VM $NEW_ID deployed successfully"
