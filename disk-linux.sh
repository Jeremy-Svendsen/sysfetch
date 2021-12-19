#!/bin/bash

disk_strip="s/SSD//;s/[0-9$]*GB//;s/ *$//"
disk_path=$(df / | awk -F ' ' 'FNR==2 {print $1}')
disk_model=$(lsblk $disk_path -io MODEL | sed -n 2p | sed "$disk_strip")
