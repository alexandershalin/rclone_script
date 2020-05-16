#!/bin/bash

source /home/pi/scripts/rclone_script/rclone_script-fns.sh

########
# MAIN #
########

echo "shutdown sync" >> /home/pi/scripts/rclone_script/shutdown.log
doUpSync | tee -a /home/pi/scripts/rclone_script/shutdown.log
