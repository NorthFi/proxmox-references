#!/bin/bash
# Create multiple LXC containers from a template

TEMPLATE=$1
START_ID=$2
COUNT=$3
STORAGE="local-lvm"

if [ -z "$3" ]; then
    echo "Usage: $0 <template> <start_id> <count> [storage]"
    exit 1
fi

[ -n "$4" ] && STORAGE=$4

for i in $(seq "$START_ID" $((START_ID + COUNT - 1))); do
    echo "Creating container $i from template $TEMPLATE"
    pct create "$i" "$TEMPLATE" --storage "$STORAGE" --rootfs 8G --hostname "ct-$i" --memory 1024 --cores 1 --net0 name=eth0,bridge=vmbr0,ip=dhcp
done

echo "Created $COUNT containers starting from ID $START_ID"
