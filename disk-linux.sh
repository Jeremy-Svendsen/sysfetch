#!/bin/bash


# We need a proper regex to strip this in case disk block path is like sda, sdb, sdc, nvme0n1p1, or some other. Current strip will break for nvme drives 
disk_strip="s/SSD//;s/[0-9$]*GB//;s/ *$//"
disk_path=$(df / | awk -F ' ' 'FNR==2 {print $1}')
disk_model=$(lsblk $disk_path -io MODEL | sed -n 2p | sed "$disk_strip")
