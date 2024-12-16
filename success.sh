#!/bin/zsh

source header.sh

item=$1

current_data_dir=${DATA_DIR}/${item}
conig_file=${CONFIG_DIR}/${item}.sh
source $conig_file

echo "[INFO] Synced ${item}"
echo "synced" > ${current_data_dir}/status
echo "${timestamp}" > ${current_data_dir}/last_time
