#!/bin/zsh

source header.sh

sync_cnt=0

function check_wait_sync() {
	item=$1
	current_dir=${DATA_DIR}/${item}

	# Create file if not exists
	mkdir -p $current_dir
	touch $current_dir/{status,last_time}

	# Read time & status
	current_status=`cat ${current_dir}/status`
	current_time=`cat ${current_dir}/last_time`
	if [[ $current_time == "" ]]; then
		current_time='0'
	fi
	if [[ $current_status == "syncing" ]]; then
		echo "[INFO] ${item} is syncing"
		sync_cnt=`echo ${sync_cnt} + 1 | bc`
		return 0
	fi
	gap_time=`echo ${timestamp} - ${current_time} | bc`

	SYNC_GAP=43200
	source ${CONFIG_DIR}/${item}.sh
	if [[ $gap_time -ge $SYNC_GAP ]]; then
		return 1
	fi

	return 0
}

function one_shot_sync() {
	name=$1
	echo $name
}

for item in $image_lists; do
	check_wait_sync ${item}
	sync_flag=$?
	if [[ $sync_flag -ne 0 ]]; then
		echo "[INFO] $item was short on water"
		wait_sync+=${item}
	else 
		echo "[INFO] $item has enough water"
	fi
done

if [[ $sync_cnt -eq $MAX_SYNC ]]; then
	echo "[WARN] ALREADY HIT MAX SYNC"
	return 
fi
for item in ${wait_sync}; do
	sync_cnt=`echo ${sync_cnt} + 1 | bc`
	echo "[INFO] Pull ${item} to sync, ${sync_cnt}/${MAX_SYNC}"
    systemctl start mirror-sync-unit@${item}
	if [[ $sync_cnt -eq $MAX_SYNC ]]; then
		echo "[WARN] HIT MAX SYNC"
		break
	fi
done

echo "[INFO] Done"
