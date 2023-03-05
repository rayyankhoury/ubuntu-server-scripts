sudo apt-key add data/Repo.keys
sudo cp -R data/sources.list* /etc/apt/
sudo apt-get update
sudo apt-get install dselect
sudo dselect update
sudo dpkg --set-selections < data/Package.list
sudo apt-get dselect-upgrade -y
