#!/bin/bash

#
# Hide Syncthing emblems and restore shortcut emblems (on Nemo)
#
# github.com/lu0
#

# Restore emblems
homedirs=($(ls -d ~/*/))
echo -e "Emblems of\n"
for folder in "${homedirs[@]}"; do
  gio set -t unset "$folder" metadata::emblems;
  echo "$folder"
done
echo -e "\nrestored to default"

# Rename shortcut emblems
for i in $(find /usr/share/icons/ -name 'emblem-symbolic-link*_DISABLED'); do sudo mv -i "$i" "${i%?????????}"; done

echo -e "\nemblem-symbolic-link icons renamed to:\n"
find /usr/share/icons/Papirus/ -type f -name 'emblem-symbolic-link*'


