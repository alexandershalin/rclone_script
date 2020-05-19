#!/bin/bash

# include settings file
config=/home/pi/scripts/rclone_script/rclone_script.ini
source ${config}

source /home/pi/scripts/rclone_script/rclone_script-fns.sh

########
# MAIN #
########

if [ "${syncOnSystemStartStop}" == "TRUE" ]
then
	sleep 10; # put in a sleep to allow emulationstation to finish loading
	echo "startup sync" >> /home/pi/scripts/rclone_script/startup.log
	doDownSync | tee -a /home/pi/scripts/rclone_script/startup.log
fi
