#!/bin/bash

source /home/pi/scripts/rclone_script/rclone_script-fns.sh

########
# MAIN #
########

sleep 10; # put in a sleep to allow emulationstation to finish loading
echo "startup sync" >> /home/pi/scripts/rclone_script/startup.log
doDownSync | tee -a /home/pi/scripts/rclone_script/startup.log
