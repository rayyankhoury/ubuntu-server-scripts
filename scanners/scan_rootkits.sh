# Once installation is complete, perform a scan and report any
# suspicious activity
echo "Scanning for suspicious activity..."
sudo rkhunter -C --enable all --disable none
chkrootkit
/var/ossec/bin/rootcheck

echo "Installation and scan complete."

# # Set rkhunter to run automatically
echo "Setting rkhunter to run automatically..."
sudo crontab -e
# add the following line to the crontab file
0 0 * * * rkhunter --update && rkhunter -C --enable all --disable none
