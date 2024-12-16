#!/bin/zsh

# I know this script is stupid, but it works.

source header.sh

echo "[" > ${STATUS_JSON_FILE}

not_first_item=false
for item in $image_lists; do
	if $not_first_item; then
		echo "," >> ${STATUS_JSON_FILE}
	fi
	not_first_item=true
	echo "{" >> ${STATUS_JSON_FILE}
	echo "\"name\": \"${item}\"," >> ${STATUS_JSON_FILE}
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
	echo "\"time\": ${current_time}," >> ${STATUS_JSON_FILE}
	echo "\"status\": \"${current_status}\"" >> ${STATUS_JSON_FILE}
	echo -n "}" >> ${STATUS_JSON_FILE}
done

echo "]" >> ${STATUS_JSON_FILE}
