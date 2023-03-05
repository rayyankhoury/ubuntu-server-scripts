# dpkg --get-selections > ~/Package.list
# sudo cp -R /etc/apt/sources.list* ~/
# sudo apt-key exportall > ~/Repo.keys

dpkg --get-selections > data/Package.list
sudo cp -R /etc/apt/sources.list* data
sudo apt-key exportall > data/Repo.keys

#rsync --progress /home/`whoami` /path/to/user/profile/backup/here

#For example, to backup a $HOME directory to another box,

#EXCLUDE=“—exclude-symbolic-links —exclude /.gnupg
#TARGET=“romulus::media/Lap-Backup/xubuntu/${LOGNAME}”
#/usr/bin/rdiff-backup $EXCLUDE ${HOME}  “$TARGET”
#/usr/bin/rdiff-backup —remove-older-than 90D —force “$TARGET”