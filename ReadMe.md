# rclone_script for Retroflag GPi

Setup cloud synchronization for the save files on your RetroPie

## What does this do?

This script will setup different things on your RetroPie in order to automatically sync save files to a cloud service supported by [rclone](https://rclone.org/)

## What will you have to do?

Just install this via
```bash
wget -N -P ~/scripts/rclone_script https://raw.githubusercontent.com/alexandershalin/rclone_script/master/rclone_script-install.sh;
chmod 755 ~/scripts/rclone_script/rclone_script-install.sh;
~/scripts/rclone_script/rclone_script-install.sh;
```
and follow the instructions.

## What have been done to make it specific for Retroflag GPi?

1. Removed all cloud providers except Google Drive and made installation process as easy as possible
2. Menu changed to fit GPi screen
3. Notifications size changes

## What else has been done
I didn't like the additional time that it takes to start a game (emulator) with the sync enabled.  I also didn't like that I had to exit a game in order to sync a backup.  I wanted to be able to flip the off switch and go about my business.

To address this I added a feature where the system installs a startup and shutdown script that can be turned on.  The startup script downloads any new saves, and the shutdown script updloads any new ones.  This is done for all emulators.

The startup script has a delay built in.  It runs just before emulationstation is activated but bakes in a 10s sleep.  This allows ES to complete loading without any additional drag on the system and so startup time is unaffected.  After the 10s delay, the sync kicks off.  This is usally around the time that I'm browsing for a game or even loading one up.  I find it to be seamless.

I've made updates to the menu that allow for turning on and off the system start/stop sync.  I suggest that users who wish to use the system start/stop sync disable the normal emulator start/stop sync.  This is suggested during the installation if users turn on system start/stop sync.  There's nothing that prevents users from using both sync events and no troubles are expected if both are turned on.  

## Troubleshooting

Why are my saves not synced on emulator start/stop automatically?

By some reason script calls were not added to runcommand. Open /opt/retropie/configs/all/runcommand-onstart.sh and add:
```bash
~/scripts/rclone_script/rclone_script.sh "down" "$1" "$2" "$3" "$4"
```
Open /opt/retropie/configs/all/runcommand-onend.sh and add:
```bash
~/scripts/rclone_script/rclone_script.sh "up" "$1" "$2" "$3" "$4"
```
Why standalone emulators (gpsp e.g.) still use /home/pi/RetroPie/roms/[SYSTEM]/ folder to store saves?

Script reconfigures only RetroArch to store saves in /home/pi/RetroPie/saves/[SYSTEM]/ folder. You need to configure standalone emulators manually. If it is not possibe to configure saves path in emulator (gpsp e.g.), you should move your saves manually and create symlinks to them.

## Icon for ES Themes

[https://github.com/alexandershalin/rclone_script/blob/master/cloudsync.png](https://github.com/alexandershalin/rclone_script/blob/master/cloudsync.png)

`/opt/retropie/configs/all/emulationstation/gamelists/retropie/gamelist.xml`

```
<game>
        <path>./rclone_script-redirect.sh</path>
        <name>Cloud Sync</name>
        <desc>Cloud Sync powered by rclone.</desc>
        <image>/home/pi/RetroPie/retropiemenu/icons/cloudsync.png</image>
        <playcount>3</playcount>
        <lastplayed>20190809T040420</lastplayed>
    </game>
```

## All the other stuff for original rclone_script below

I ***strongly*** recommend reading this page completely before actually doing this! You can also look at these Wiki pages to better understand what this script does:

* [Step-by-step guide through the installer](../../wiki/RCLONE_SCRIPT-install)
* [RCLONE_SCRIPT in action](../../wiki/RCLONE_SCRIPT%20in%20action)
* [Guide to the RCLONE_SCRIPT menu](../../wiki/RCLONE_SCRIPT-menu)
* [How to manually move your savefiles](../../wiki/move-Savefiles)
* This also allows you to sync your progress with RetroArch on [Android](../../wiki/sync-and-play-Android) and [Windows](../../wiki/sync-and-play-Windows)!

## Again, what does this do?

Let me give you a rundown of the things this script will do:

1. The script will install the _RCLONE_ binary. It will be downloaded directly from their website as the binary installable via _apt-get_ is quite old, sadly. _RCLONE_ actually is what allows us to use a number of different cloud services, see [their website](https://rclone.org/) for a complete list. The script will then ask you to define a _remote_. That is the other side used for the synchronization. That remote **has** to be called _retropie_, the script will not continue without it. Please consult the [RCLONE documentation](https://rclone.org/) on how to configure remotes for different cloud services
2. Then, _PNGVIEW_ will be downloaded, compiled and installed. That will be used to show you notifications when up- and downloading save files.
3. _IMAGEMAGICK_ will be installed via _apt-get_, this will be used to actually create images containing the notifications which are shown by _PNGVIEW_
4. The other scripts you see here will now be downloaded. They are used to control _RCLONE_ whenever it needs to sync your save files. Notice that there's also a script to remove all of this from your RetroPie. A new menu item in the RetroPie menu will be created which let's you control some aspects of RCLONE_SCRIPTS. Then, you'll be asked to enter the desired name of the _remote SAVEFILE base directory_. All your synchronized files will go into this directory.
5. Some scripts from RetroPie will be changed so they call one of the scripts from step 4 which then calls _RCLONE_... Sounds complicated but you don't have to do anything
6. Right next to the _ROMS_ directory, a new directory _SAVES_ will be created, containing a subdirectory for each system. This is where your savefiles will have to be locally now. See [this wiki page](../../wiki/move-Savefiles) on how to move the savefiles there, that will ***not*** be done by the script
7. The setup script will now create the _remote SAVEFILE base directory_ and one subdirectory for each system RetroPie supports at the remote destination (if necessary)
8. Your RetroPie will be configured so each system uses it's own local directory for saves. Before, RetroPie looked for these files in the _ROMS_ directory (which made syncing them without accidentially uploading a ROM - ILLEGALLY - so much more difficult)
9. The settings you entered during installation are then saved for future reference

That's it, setup is complete. If you already have some save files within the _ROMS_ directory you need to move them to their subdirectory within the _SAVES_ directory now. Afterwards, reboot your RetroPie so the new menu item shows up

## What will RetroPie do after this script is installed?

Whenever you start or stop playing a game, the accompanying save files will be down- or uploaded to the configured remote:

* starting a game will trigger _RCLONE_ to download save files for the game from the remote
* stopping a game will trigger _RCLONE_ to upload save files for the game to the remote

Of course, all of this only works if your RetroPie has access to the configured cloud service.

In the RetroPie menu, there will also be a new menu item "_RCLONE_SCRIPT menu_". Starting this menu item will let you...

* start a full sync to up- and download newer files to and from the remote, so each side should have the latest save file for each game afterwards. Please note that this will also download save files even if the accompanying ROM is not on your RetroPie.
* toggle a setting to enable or disable the synchronization when starting or stopping a ROM. With this, you can temporarily disable that process. You'll get a warning, though
* toggle a setting to enable or disable showing a notification for the synchronization process

## Why do this?

Well, I have two big reasons:
1. I wanted an offsite backup of my save files. I have started _Chrono Trigger_ so many times and always lost the save by tinkering with my RetroPie...
2. I wanted to be able to seamlessly continue playing on another machine. Now I can...
   * start the game on RetroPie, play for an hour, save and automatically upload to DropBox
   * download the save file to Android via [DropSync](https://play.google.com/store/apps/details?id=com.ttxapps.dropsync&hl=de) and continue playing there via [RetroArch for Android](https://play.google.com/store/apps/details?id=com.retroarch) (don't forget to upload afterwards!)
   * continue playing on my PC which is synced automatically via the DropBox client (which also uploads again automatically)
   * then return to RetroPie, which auto-downloads the save when I start the game there

## Are there risks?

Of course! I'm a hobby programer, so this script might have errors I just haven't found yet. I'll do my best to fix them, though.
There are some things which just will not work with any sync, e. g. conflicting file changes. I strongly advice you to only change one side of each synced save file. In other words, don't play _Chrono Trigger_ on you RetroPie and on your PC simultaneously and expect to keep both save slots intact...

## This is great! How can I thank you?

First of all: You don't have to. I made this script for myself first of all. I'm happy already if someone else can use it. I only ask you to report any problems or feature requests here.

If you _really_ want to thank me, you could use this [DropBox referral link](https://db.tt/9AcbUWny) to create your account there. This will give us both 500 MiB extra (on top of the default 2 GiB) when you install the DropBox client. That will be enough for a good number of save files... ;-)

## Sources

These are the sites I used as source:
* https://rclone.org/dropbox/
* https://rclone.org/commands/rclone_copy/
* https://rclone.org/filtering/
* https://github.com/RetroPie/RetroPie-Setup/wiki/Runcommand#runcommand-onstart-and-runcommand-onend-scripts
* https://github.com/AndrewFromMelbourne/raspidmx
* https://www.zeroboy.eu/tutorial-gbzbatterymonitor/
