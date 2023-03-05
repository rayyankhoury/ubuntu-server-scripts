//##Copy all the files in to the main docker directory.

//##For cryptpad to work properly, you must make both owner and group 4001 4001

sudo chown metalconker /var/lib/docker/
cd /var/lib/docker/
sudo cp -r /usr/local/scripts/docker/. .
sudo chown 4001:4001 -R volumes/cryptpad