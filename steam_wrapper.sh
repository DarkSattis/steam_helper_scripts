#!/bin/bash
#script to wrap steam for actual physical cores only

# Ubuntu 22.04

PROC_NAME="bash /home/$USER/.steam/debian-installation/steam.sh -nominidumps -nobreakpad"

/usr/games/steam %U &>/dev/null &
while ! pgrep -f "$PROC_NAME"; do
    #echo \"not yet started\";
    sleep 1;
done
# steam started, so set to physical cores only
taskset -apc "$(cut -d, -f1 /sys/devices/system/cpu/cpu*/topology/thread_siblings_list | sort -un |paste -s -d,)" "$(pgrep -f "$PROC_NAME")"
