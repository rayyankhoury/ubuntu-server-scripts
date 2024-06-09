# Update and install
dir=$(pwd)
sudo apt-get update
# sudo apt-get install autoconf libtool g++ libcrypto++-dev libz-dev libsqlite3-dev libssl-dev libcurl4-gnutls-dev libreadline-dev libpcre++-dev libsodium-dev libc-ares-dev libfreeimage-dev libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libmediainfo-dev libzen-dev libuv1-dev\
wget https://mega.nz/linux/repo/xUbuntu_22.10/amd64/megacmd-xUbuntu_22.10_amd64.deb
sudo apt install $dir/megacmd-xUbuntu_22.10_amd64.deb
rm $dir/megacmd-xUbuntu_22.10_amd64.deb

#region
#===========================================================================
# INSTALL HELPER
#===========================================================================
#
# Description:
#   Installs a package if it is not already installed
#
# Arguments:
#   $1: Package name
#===========================================================================
#endregion
function install_helper() {
    package=$1
    pca $check $"Checking if $package is installed"
    leca $"sudo dpkg -s $package
        | grep \"Status: install ok installed\" &>/dev/null"
    if [ $? -eq 0 ]; then
        pca $positive $"$package is already installed"
    else
        pca $action $"Installing $package"
        leca $"sudo apt-get install -qqy $package"
        if [ $? -eq 0 ]; then
            pca $success $"$package installed successfully"
        else
            pca $failure $"Failed to install $package"
        fi
    fi
}

#region
#===========================================================================
# PURGE HELPER
#===========================================================================
#
# Description:
#   Purges a package if it is not already purged
#
# Arguments:
#   $1: Package name
#===========================================================================
#endregion
function purge_helper() {
    package=$1
    pca $check $"Checking if $package is installed"
    leca $"sudo dpkg -s $package &>/dev/null"
    if [ $? -eq 0 ]; then
        #Remove rpm package manager
        pca $action $"Removing $package..."
        leca $"sudo apt-get purge $package -y"
    else
        pca $positive $"$package not installed on system!"
        return
    fi

    #Verify that package has been removed
    pca $check $"Verifying that $package has been removed..."
    if [ -x "$(command -v $package)" ]; then
        pca $failure $"$package still installed!"
    else
        pca $success $"$package successfully removed!"
    fi

}

#region
#===========================================================================
# REMOVE HELPER
#===========================================================================
#
# Description:
#   Removes a package if it is not already purged
#
# Arguments:
#   $1: Package name
#===========================================================================
#endregion
function remove_helper() {
    package=$1
    pca $check $"Checking if $package is installed"
    leca $"sudo dpkg -s &>/dev/null $package"
    if [ $? -eq 0 ]; then
        #Remove rpm package manager
        pca $action $"Removing $package..."
        leca $"sudo apt-get remove $package -y"
    else
        pca $positive $"$package not installed on system!"
        return
    fi

    #Verify that package has been removed
    pca $check $"Verifying that $package has been removed..."
    if [ -x "$(command -v $package)" ]; then
        pca $failure $"$package still installed!"
    else
        pca $success $"$package successfully removed!"
    fi

}
