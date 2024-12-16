#!/bin/zsh

source header.sh

item=$1

current_data_dir=${DATA_DIR}/${item}
conig_file=${CONFIG_DIR}/${item}.sh
source $conig_file

echo "[INFO] Pull ${item}"
echo "syncing" > ${current_data_dir}/status
rsync -ah --info=progress2 $RSYNC_URL ${MIRROR_DIR}/${item}
