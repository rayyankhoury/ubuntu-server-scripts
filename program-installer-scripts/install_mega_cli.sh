# Update and install
dir=$(pwd)
sudo apt-get update
# sudo apt-get install autoconf libtool g++ libcrypto++-dev libz-dev libsqlite3-dev libssl-dev libcurl4-gnutls-dev libreadline-dev libpcre++-dev libsodium-dev libc-ares-dev libfreeimage-dev libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libmediainfo-dev libzen-dev libuv1-dev\
wget https://mega.nz/linux/repo/xUbuntu_22.10/amd64/megacmd-xUbuntu_22.10_amd64.deb
sudo apt install $dir/megacmd-xUbuntu_22.10_amd64.deb
rm $dir/megacmd-xUbuntu_22.10_amd64.deb
