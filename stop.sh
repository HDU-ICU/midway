#!/bin/zsh

source header.sh

item=$1

current_data_dir=${DATA_DIR}/${item}
conig_file=${CONFIG_DIR}/${item}.sh
source $conig_file

current_status=`cat ${current_data_dir}/status`

if [[ ${current_status} == "synced" ]]; then
	return
fi

echo "[ERROR] Failed ${item}"
echo "failed" > ${current_data_dir}/status
