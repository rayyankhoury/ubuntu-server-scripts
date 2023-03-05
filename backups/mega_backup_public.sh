sudo mega-logout
sudo mega-login $$PUT_EMAIL_HERE$$ $$PUT_PASSWORD_HERE$$

sudo mega-mkdir /etc
sudo mega-mkdir /home
sudo mega-mkdir /root
sudo mega-mkdir /var
sudo mega-mkdir /var/lib
sudo mega-mkdir /var/lib/docker
sudo mega-mkdir /var/lib/docker/volumes
sudo mega-mkdir /usr
sudo mega-mkdir /usr/local
sudo mega-mkdir /usr/local/bin
sudo mega-mkdir /usr/local/sbin
sudo mega-mkdir /usr/local/scripts
sudo mega-mkdir /srv
sudo mega-mkdir /opt

sudo mega-backup /etc /etc --period="0 0 4 * * *" --num-backups=10
sudo mega-backup /home /home --period="0 0 4 * * *" --num-backups=10
sudo mega-backup /root /root --period="0 0 4 * * *" --num-backups=10
sudo mega-backup /var/lib/docker/volumes /var/lib/docker/volumes --period="0 0 4 * * *" --num-backups=10
sudo mega-backup /usr/local/bin /usr/local/bin --period="0 0 4 * * *" --num-backups=10
sudo mega-backup /usr/local/sbin /usr/local/sbin --period="0 0 4 * * *" --num-backups=10
sudo mega-backup /usr/local/scripts /usr/local/scripts --period="0 0 4 * * *" --num-backups=10
sudo mega-backup /srv /srv --period="0 0 4 * * *" --num-backups=10
sudo mega-backup /opt /opt --period="0 0 4 * * *" --num-backups=10