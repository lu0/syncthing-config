#!/bin/bash

# ----------------------------------------------------------------------
# Track the Syncthing config files of both my phone and my laptop
# Repo folder: ~/code/syncthing-config/
#
# Syncthing overwrites the config files instead of editing them,
# so symbolic and hard links (ln -s) won't work. 
# A workaround is to mount the parent folder of the configs to a folder
# inside the repo and ignore all but the config.xml in the .gitignore
# Unmount with sudo umount /path/to/folder/
# ----------------------------------------------------------------------

# Desktop config
# By default in ~/.config/syncthing/config.xml
mkdir -p ~/code/syncthing-config/desktop-config/
sudo mount --bind ~/.config/syncthing/ ~/code/syncthing-config/desktop-config/

# Android config
# I sync it in ~/mobile/ga50/int-syncthing from 
# /backups/synchting/ of the phone
mkdir -p ~/code/syncthing-config/android-config/
sudo mount --bind ~/mobile/ga50/int-syncthing/ ~/code/syncthing-config/android-config/
