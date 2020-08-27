# syncthing-config
This repo tracks the [Syncthing](https://github.com/syncthing/syncthing) config files of my phone and my laptops.

## What do I sync?
I sync some folders of my home directory between my laptops, and some folders of my phone.

### Home directory
Usual folders:
* Documents
* Home
* Downloads
* Music
* Pictures
* Templates
* Videos

Custom folders:
* Artwork
* Code
* Mobile

### Phone
Current Android versions only grants Syncthing read-only access to the SD card, so I store all my data in the internal storage. I set dummy folders anyways in case Android 11 allows Syncthing to write to the SD card.
* DCIM
* Pictures (created by apps)
* Downloads
* Whatsapp media
* Voice recordings
* Backup folder of syncthing

## Setup
Syncthing [overwrites the config file](https://github.com/syncthing/syncthing/issues/6628) instead of editing it, so neither symlinks nor hardlinks from the config files to the repo will work. A workaround to track those files is to mount their parent directories in folders created inside the repo, stage the config.xml files and use the .gitignore to ignore files containing sensitive data.
<br />
<br />
The following steps uses paths of my machine for sake of example.

### Desktop config
Syncthing store the config files in ```~/.config/syncthing/```, mount this folder inside the repo to track its contents. 
```zsh
mkdir -p ~/code/syncthing-config/desktop-config/
sudo mount --bind ~/.config/syncthing/ ~/code/syncthing-config/desktop-config/
```
If using Nemo, run the following script to hide "link" emblems and show Syncthing emblems on the synced folders.
```zsh
./emblems.sh
```
In case you want to restore the default emblems, run:
```zsh
./restore-emblems
```

### Run at startup
If everything works as intended, edit `/etc/fstab/` with:
```zsh
...
/home/USER/.config/syncthing/ /home/USER/code/syncthing-config/desktop-config/              none user,nodev,x-gvfs-hide,bind 0 0
...
```

### Sensitive files and folders to be ignored by git
The ```.gitignore``` contains the list of files and folders that [must not be tracked](https://docs.syncthing.net/users/security.html#protecting-your-syncthing-keys-and-identity):
* key.pem
* cert.pem
* https-key.pem
* https-cert.pem
* csrftokens.txt
* sharedpreferences.dat
* index-v0.14.0.db

Only folder and device IDs [can be tracked](https://docs.syncthing.net/users/faq.html#should-i-keep-my-device-ids-secret), those IDs are stored in the ```config.xml``` files. However, these files include API keys. What I did was commit blank ```config.xml``` files, then pasted and committed the lines with non-sensitive data and lastly I added the sensitive data to the files but didn't commit them. I mantain the repo using a pre-commit hook to avoid commiting lines with API keys:

```zsh
cp pre-commit .git/hooks/
```
Make sure to unstage lines containing sensitive data.
