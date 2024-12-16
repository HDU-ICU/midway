#!/bin/zsh 

image_lists=(archlinux archlinuxcn debian debian-cd docker-ce golang nodejs-release proxmox rustup ubuntu ubuntu-cdimage debian-security)
wait_sync=()
timestamp=$(date +%s)

MIRROR_DIR=/mirrors/
DATA_DIR=/opt/mirror-syncer/data/
CONFIG_DIR=/opt/mirror-syncer/config/
STATUS_JSON_FILE=/mirrors/status.json
MAX_SYNC=2
