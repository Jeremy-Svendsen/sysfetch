#!/bin/bash

# this script search '41' in /proc/bus/pci/devices for vendor and device id, then scrapes https://pci-ids.ucw.cz using taken id's for GPU output
while read -r line ; do
	case $line in
		*0000c*) id=$line ;;
	esac
done < /proc/bus/pci/devices
id=$(cut -f2 <<< $id)
vendor_id=${id::-4}
device_id=${id:4}

pci_data=$(curl https://pci-ids.ucw.cz/read/PC/$vendor_id 2>/dev/null)
while read -r line ; do
	case $line in
		*'="nam'*) gpu_vendor=$line ;;
	esac
done <<< $pci_data
html_strip="s|</b>|-|g;s|<[^>]*>||g"
gpu_vendor=$(sed "$html_strip" <<< $gpu_vendor)
gpu_vendor=${gpu_vendor//Name: }
gpu_vendor=${gpu_vendor//Note:*}

while read -r line ; do
	case $line in
		*$device_id*) gpu_name=$line ;;
	esac
done <<< $pci_data

gpu_name=$(sed "$html_strip" <<< $gpu_name)
gpu_name=${gpu_name:4}

gpu_strip="s/Advanced Micro Devices, Inc.//"
gpu_vendor=$(sed "$gpu_strip" <<< $gpu_vendor)
gpu="$gpu_vendor $gpu_name"
gpu=$(tr -d '[]' <<< $gpu)
echo $gpu
