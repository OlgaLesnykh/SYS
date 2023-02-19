#!/bin/bash
while true; do
	date +%T
	cat /proc/loadavg
	sleep 5
done
