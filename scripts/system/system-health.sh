#!/bin/bash
# Check Proxmox system health

echo "=== System Health Check ==="
echo -e "\n[Cluster Status]"
pvecm status

echo -e "\n[Resource Usage]"
pvesh get /cluster/resources | jq -r '.[] | select(.type=="node") | {node: .node, cpu: .cpu, memory: .mem, disk: .disk}'

echo -e "\n[Storage Status]"
pvesm status

echo -e "\n[Network Connectivity]"
ping -c 3 8.8.8.8 | grep "packet loss"

echo -e "\n[Load Average]"
uptime

echo -e "\n[Disk Health]"
smartctl -a /dev/sda | grep -E "Model|Reallocated|Pending|Temperature"
