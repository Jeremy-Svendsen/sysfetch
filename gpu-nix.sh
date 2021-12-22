#!/bin/bash

# this script search '41' in /proc/bus/pci/devices for vendor and device id, then scrapes https://pci-ids.ucw.cz using taken id's for GPU output

html_strip="s|</b>|-|g;s|<[^>]*>||g"
while read -r line ; do
	case $line in
		*41*) id=${line:4} ;;
	esac
done < /proc/bus/pci/devices
id=$(cut -f2 <<< $id)
vendor_id=${id::-4}
device_id=${id:4}

while read -r line ; do
	case $line in
		*$device_id*) gpu=$line ;;
	esac
done < <(curl https://pci-ids.ucw.cz/read/PC/$vendor_id)

gpu=$(sed "$html_strip" <<< $gpu)
gpu=${gpu:4}
echo $gpu
