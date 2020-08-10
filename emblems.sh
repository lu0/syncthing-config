#!/bin/bash

# 
# Hide shortcut emblems and display Syncthing emblems
# for synced folders
# 

# Restore emblems
homedirs=($(ls -d ~/*/))
for folder in "${homedirs[@]}"; do
  gio set -t unset "$folder" metadata::emblems;
done

# Restore name of shortcut emblems
for i in $(find /usr/share/icons/ -name 'emblem-symbolic-link*_DISABLED'); do sudo mv -i "$i" "${i%?????????}"; done

# Rename shortcut emblems
for i in $(find /usr/share/icons/ -name 'emblem-symbolic-link*'); do sudo mv -i "$i" "${i}_DISABLED"; done

echo -e "\nemblem-symbolic-link icons renamed to:\n"
find /usr/share/icons/Papirus/ -type f -name 'emblem-symbolic-link*'

# Synced folders
declare -a SYNCED=("artwork" "code" "documents" "loads" "music" "pictures" "templates" "videos" "mobile")

echo -e "\nSyncthing emblems applied to:\n"
for folder in "${SYNCED[@]}"; do
  gio set -t stringv "$HOME/$folder/" metadata::emblems emblem-syncthing;
  echo "$HOME/$folder/"
done
