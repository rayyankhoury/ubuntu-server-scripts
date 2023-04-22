// Installing WINE on UBUNTU based machine

sudo dpkg --add-architecture i386
wget -nc https://dl.winehq.org/wine-builds/Release.key 
sudo apt-key add Release.key
sudo apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/
sudo apt-get update
sudo apt-get install --install-recommends wine-stable

// Install GROMIT-MPX (an epic pen variant)
sudo apt-get install gromit-mpx

// Install qBittorrent
sudo apt-get install qbittorrent

// Install VLC
sudo apt-get install vlc

// Reddit Wallpaper Changer
sudo apt-get install python3-dev python3-setuptools libjpeg8-dev zlib1g-dev libfreetype6-dev
cd ~
git clone https://github.com/ChrisTitusTech/wallpaper-reddit.git
cd wallpaper-reddit
sudo python3 setup.py install

//////////// Add these lines to the bottom of /etc/profile
/usr/local/bin/wallpaper-reddit --save
/usr/local/bin/wallpaper-reddit --startup
///////////////////////

// Install HTOP
sudo apt-get install htop

// Install GNOME SYSTEM MONITOR
sudo apt-get install gnome-system-monitor

// Installing SSH
sudo apt-get install ssh
sudo systemctl enable ssh

// Matrix hilarious terminal fun
sudo apt-get install cmatrix

//Installing ZSH as an alternative to bash
//zsh - ZSH Shell
//zsh-syntax-highlighting - syntax highlighting for ZSH in standard repos
//autojump - jump to directories with j or jc for child or jo to open in file 
//zsh-autosuggestions - Suggestions based on your history
sudo apt-get install zsh
sudo apt-get install zsh-syntax-highlighting
sudo apt-get install autojump
sudo apt-get install zsh-autosuggestions
// Get Chris Titus settings
wget https://github.com/ChrisTitusTech/zsh/raw/master/.zshrc -O ~/.zshrc
mkdir -p "$HOME/.zsh"
wget https://raw.githubusercontent.com/ChrisTitusTech/zsh/master/aliasrc -O ~/.zsh/aliasrc
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
// Use ZSH exclusively
sudo nano /etc/passwd






sudo mount -t '\\10.0.1.1\Data' /mnt/share
