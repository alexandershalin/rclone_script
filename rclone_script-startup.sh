#!/bin/bash

logfile=/home/pi/scripts/rclone_script/startup.log
source /home/pi/scripts/rclone_script/rclone_script.ini
source /home/pi/scripts/rclone_script/rclone_script-fns.sh

########
# MAIN #
########

if [ "${syncOnSystemStartStop}" == "TRUE" ]
then
	printf "$(date +%FT%T%:z):syncOnSystemStartStop is enabled, downloading savegames" >> "${logfile}"
	printf "$(date +%FT%T%:z):sleep for 10s to allow load to complete" >> "${logfile}"
	sleep 10; # put in a sleep to allow emulationstation to finish loading
	doDownSync >> "${logfile}" 2>&1
else
	printf "$(date +%FT%T%:z):syncOnSystemStartStop is disabled, skipping savegame download" >> "${logfile}"
fi
