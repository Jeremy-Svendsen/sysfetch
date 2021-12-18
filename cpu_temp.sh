#!/bin/bash

overwrite() { echo -ne "\e[1A\e[K"; }

while :; do
	sensors -f | awk -F+ '{print $2}' | sed -n 3p
	sleep .1
	overwrite
done
