#!/bin/bash

source /home/pi/scripts/rclone_script/rclone_script.ini
source /home/pi/scripts/rclone_script/rclone_script-fns.sh

########
# MAIN #
########

if [ "${syncOnSystemStartStop}" == "TRUE" ]
then
	printf "$(date +%FT%T%:z):syncOnSystemStartStop is enabled, uploading savegames\n" >> "${logfile}"
	doUpSync >> "${logfile}" 2>&1
else
	printf "$(date +%FT%T%:z):syncOnSystemStartStop is disabled, skipping savegame upload\n" >> "${logfile}"
fi
