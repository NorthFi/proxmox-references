#!/bin/bash
# Basic Proxmox firewall setup

# Enable firewall
pve-firewall compile
pve-firewall start

# Default rules
pve-firewall add chain INPUT policy DROP
pve-firewall add chain INPUT proto tcp dport 22 -j ACCEPT -comment "SSH"
pve-firewall add chain INPUT proto tcp dport 8006 -j ACCEPT -comment "Proxmox Web UI"

# Ping protection
pve-firewall add chain INPUT proto icmp -j ACCEPT --limit 1/sec --limit-burst 5 -comment "ICMP limit"

echo "Firewall rules applied. Remember to test your connection before logging out!"
