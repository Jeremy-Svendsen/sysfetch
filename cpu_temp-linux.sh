#!/bin/bash


# Trying to make CPU temperature live update inline interactively. So far can only output to a less-style view. Maybe something like ncurses?
overwrite() { echo -ne "\e[1A\e[K"; }

while :; do
	sensors -f | awk -F+ '{print $2}' | sed -n 3p
	sleep .1
	overwrite
done

watch 'sensors -f | awk -F+ "{print $2}" | sed -n 3p'
