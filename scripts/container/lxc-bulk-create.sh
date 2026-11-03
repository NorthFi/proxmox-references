#!/usr/bin/env bash
# root/scripts/container/lxc-bulk-create.sh
# Create a bounded range of LXC containers, refusing collisions and partial preflight.
set -Eeuo pipefail

usage() {
  printf 'Usage: %s <template> <start_id> <count> [storage] [--execute]\n' "$0" >&2
  printf 'Dry-run by default; --execute performs container creation.\n' >&2
}

if (( $# < 3 || $# > 5 )); then usage; exit 2; fi
template=$1
start_id=$2
count=$3
storage=local-lvm
execute=false
if (( $# >= 4 )); then
  if [[ $4 == --execute ]]; then execute=true; else storage=$4; fi
fi
if (( $# == 5 )); then
  if [[ $5 != --execute ]]; then usage; exit 2; fi
  execute=true
fi
if [[ ! $start_id =~ ^[0-9]+$ || ! $count =~ ^[0-9]+$ ]]; then
  printf 'Error: start_id and count must be positive integers.\n' >&2
  exit 2
fi
# Force decimal parsing for IDs with leading zeros.
start_id=$((10#$start_id))
count=$((10#$count))
if (( start_id < 100 || start_id > 999999 || count < 1 || count > 100 || start_id + count - 1 > 999999 )); then
  printf 'Error: VMIDs must be 100..999999 and count must be 1..100.\n' >&2
  exit 2
fi
if [[ -z $template || -z $storage || $template == -* || $storage == -* ]]; then
  printf 'Error: invalid template or storage.\n' >&2
  exit 2
fi
if ! command -v pct >/dev/null 2>&1; then
  printf 'Error: pct is not installed; run this on a Proxmox node.\n' >&2
  exit 1
fi
# Preflight every ID before creating anything, including stopped containers.
for ((i=start_id; i<start_id+count; i++)); do
  if pct config "$i" >/dev/null 2>&1; then
    printf 'Error: container ID %s already exists. Nothing created.\n' "$i" >&2
    exit 1
  fi
done
for ((i=start_id; i<start_id+count; i++)); do
  cmd=(pct create "$i" "$template" --storage "$storage" --rootfs 8 --hostname "ct-$i" --memory 1024 --cores 1 --net0 "name=eth0,bridge=vmbr0,ip=dhcp")
  if [[ $execute == true ]]; then
    printf 'Creating CT %s\n' "$i"
    "${cmd[@]}"
  else
    printf 'DRY RUN: '
    printf '%q ' "${cmd[@]}"
    printf '\n'
  fi
done
