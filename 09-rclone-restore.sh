# launch our autostart apps (if we are on the correct tty)
if [ "`tty`" = "/dev/tty1" ] && [ "$USER" = "pi" ]; then
    /home/pi/scripts/rclone_script/rclone_script-startup.sh &
fi
