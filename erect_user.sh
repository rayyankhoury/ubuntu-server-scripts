#!/bin/bash

export GIT_USERNAME="metalconker"
export GIT_EMAIL="2914720+metalconker@users.noreply.github.com"
export CURRENT_USER=$(whoami)

#region intro text

# Script to set personal preferences across a Linux server.
# Uses bash.bashrc for global settings, and bashrc for user specific
# settings.

#  ___________
# |           |
# |   HELLO   |
# |___________|
#        \   ^__^
#         \  (oo)\_______
#            (__)\       )\/\
#                ||----w |
#                ||     ||

#endregion
function developer_banner() {
    cat <<"EOF"








oooooooooo.                              .oooooo.               
`888'   `Y8b                            d8P'  `Y8b              
 888      888  .ooooo.  oooo    ooo    888      888 ooo. .oo.   
 888      888 d88' `88b  `88.  .8'     888      888 `888P"Y88b  
 888      888 888ooo888   `88..8'      888      888  888   888  
 888     d88' 888    .o    `888'       `88b    d88'  888   888  
o888bood8P'   `Y8bod8P'     `8'         `Y8bood8P'  o888o o888o 
                                                                                                                                
                                                                
oooooo   oooooo     oooo oooo                            oooo           
 `888.    `888.     .8'  `888                            `888           
  `888.   .8888.   .8'    888 .oo.    .ooooo.   .ooooo.   888   .oooo.o 
   `888  .8'`888. .8'     888P"Y88b  d88' `88b d88' `88b  888  d88(  "8 
    `888.8'  `888.8'      888   888  888ooo888 888ooo888  888  `"Y88b.  
     `888'    `888'       888   888  888    .o 888    .o  888  o.  )88b 
      `8'      `8'       o888o o888o `Y8bod8P' `Y8bod8P' o888o 8""888P' 
                                                                                                                                                
EOF
}

#region
#===========================================================================
# SETUP_ENVIRONMENT
#===========================================================================
#
# Description:
#   Defines colors and sets variables for logging and SSH configuration.
#
# Arguments:
#   None
#===========================================================================
#endregion
function setup_environment() {

    # Check if user is root
    if [[ $EUID -eq 0 ]] && [[ $SUDO_USER == "" ]]; then
        echo "Please run as user, not root or sudo"
        exit
    fi
    ### define colors ###
    lightred=$'\033[1;31m'    # light red
    red=$'\033[0;31m'         # red
    lightgreen=$'\033[1;32m'  # light green
    green=$'\033[0;32m'       # green
    lightblue=$'\033[1;34m'   # light blue
    blue=$'\033[0;34m'        # blue
    lightpurple=$'\033[1;35m' # light purple
    purple=$'\033[0;35m'      # purple
    lightcyan=$'\033[1;36m'   # light cyan
    cyan=$'\033[0;36m'        # cyan
    lightgray=$'\033[0;37m'   # light gray
    white=$'\033[1;37m'       # white
    brown=$'\033[0;33m'       # brown
    yellow=$'\033[1;33m'      # yellow
    darkgray=$'\033[1;30m'    # dark gray
    black=$'\033[0;30m'       # black
    nocolor=$'\e[0m'          # no color

    echo -e -n "${lightred}"
    echo -e -n "${red}"
    echo -e -n "${lightgreen}"
    echo -e -n "${green}"
    echo -e -n "${lightblue}"
    echo -e -n "${blue}"
    echo -e -n "${lightpurple}"
    echo -e -n "${purple}"
    echo -e -n "${lightcyan}"
    echo -e -n "${cyan}"
    echo -e -n "${lightgray}"
    echo -e -n "${white}"
    echo -e -n "${brown}"
    echo -e -n "${yellow}"
    echo -e -n "${darkgray}"
    echo -e -n "${black}"
    echo -e -n "${nocolor}"

    start="$lightcyan"
    end="$darkgray"
    check="$darkgray"
    neutral="$darkgray"
    success="$lightgreen"
    failure="$lightred"
    positive="$lightgreen"
    negative="$lightred"
    action="$yellow"

    echo -e -n "${start}"
    echo -e -n "${end}"
    echo -e -n "${check}"
    echo -e -n "${neutral}"
    echo -e -n "${success}"
    echo -e -n "${failure}"
    echo -e -n "${action}"

    # Set Vars
    LOGFILE='/var/log/personal_preferences.log'
    SSHDFILE='/etc/ssh/sshd_config'
    BASHFILE='/etc/bash.bashrc'
}

#region
#===========================================================================
# CHECK DISTRO
#===========================================================================
#
# Description:
#   Checks the current distribution to ensure that it is Ubuntu 20.04
#
# Arguments:
#   None
#===========================================================================
#endregion
function check_distro() {
    # Check the current distribution to ensure that it is Ubuntu 22.04
    distro=$(lsb_release -a | grep Release | awk '{print $2}')
    if [ $distro = "22.04" ]; then
        echo
    else
        echo "Error: Distribution is not Ubuntu 22.04"
        echo "You can override the exiting of this script by removing \
        the exit 0 line below"
        exit 0
    fi
}

#region
#===========================================================================
# BEGIN LOG
#===========================================================================
#
# Description:
#   Creates log file and prints a banner with the current date and time.
#
# Arguments:
#   None
#===========================================================================
#endregion
function begin_log() {
    # Create Log File and Begin
    sudo touch $LOGFILE
    #sudo >|"$LOGFILE"
    sudo chown $CURRENT_USER "$LOGFILE"
    chmod 755 "$LOGFILE"
    echo -e -n "$lightpurple"
    echo | developer_banner | tee -a "$LOGFILE"
    sleep 3

    end_time=$((SECONDS + 2))

    while [ $SECONDS -lt $end_time ]; do
        for color in $blue $red; do
            echo -e -n "$color"
            echo -e "
            ######                                                                        
            #     # ###### #####   ####   ####  #    #   ##   #                           
            #     # #      #    # #      #    # ##   #  #  #  #                           
            ######  #####  #    #  ####  #    # # #  # #    # #                           
            #       #      #####       # #    # #  # # ###### #                           
            #       #      #   #  #    # #    # #   ## #    # #                           
            #       ###### #    #  ####   ####  #    # #    # ######                      
                                                                                        
            ######                                                                        
            #     # #####  ###### ###### ###### #####  ###### #    #  ####  ######  ####  
            #     # #    # #      #      #      #    # #      ##   # #    # #      #      
            ######  #    # #####  #####  #####  #    # #####  # #  # #      #####   ####  
            #       #####  #      #      #      #####  #      #  # # #      #           # 
            #       #   #  #      #      #      #   #  #      #   ## #    # #      #    # 
            #       #    # ###### #      ###### #    # ###### #    #  ####  ######  ####  
                                                                                        
             #####                                                                        
            #     #  ####  #####  # #####  #####                                          
            #       #    # #    # # #    #   #                                            
             #####  #      #    # # #    #   #                                            
                  # #      #####  # #####    #                                            
            #     # #    # #   #  # #        #                                            
             #####   ####  #    # # #        #                                            
            "
            sleep 0.1
        done
    done
    pca $success $'Script Started Successfully'
}

#region
#===========================================================================
# SET MOTD
#===========================================================================
#
# Description:
#   Sets the MOTD with customization options.
#
# Arguments:
#   None
#===========================================================================
#endregion
function set_motd() {
    pca $start $'Starting MOTD creation...'
    pca $action $'Setting MOTD'

    ## @TODO
    pca $action $'Enabling MOTD'
    ########
    pca $success $'MOTD succesfully enabled!'

    ########
    # Add legal banner to /etc/motd
    if [ -f /etc/motd ]; then
        pca $action $'Adding MOTD to /etc/motd'
        leca $"sudo touch /etc/motd"
        leca $"sudo chmod 755 /etc/motd"
        leca $"sudo sh -c \">| /etc/motd\""
        leca $"sudo sh -c \"echo \"\" >> /etc/motd\""
        leca $"sudo sh -c 'echo \"Use alias to see custom commands\"
         >> /etc/motd'"
        leca $"sudo sh -c \"echo \"\" >> /etc/motd\""
        pca $success $'MOTD added to /etc/motd'
    fi

    # @TODO
    grep -qxF 'cat /etc/motd' ~/.bashrc || echo 'cat /etc/motd' >>~/.bashrc

    pca $success $'MOTD successfully set!'
    pca $end $'MOTD created!'
}

#region
#===========================================================================
# INSTALL_UNOFFICIAL_PACKAGES
#===========================================================================
#
# Description:
#   Installs unofficial packages.
#
# Arguments:
#   None
#===========================================================================
#endregion
function install_unofficial_packages() {

    pca $start $'Installing unofficial packages!'

    # #Removes
    # remove_helper $'docker'
    # remove_helper $'docker-engine'
    # remove_helper $'docker.io'
    # remove_helper $'containerd'
    # remove_helper $'runc'

    pca $action $'Creating etc/apt/keyrings'
    leca $"sudo mkdir -p /etc/apt/keyrings"
    pca $success $'etc/apt/keyrings created'

    # This script will check for an update for the Lynis security tool
    pca $action $'Downloading cisofy-key.asc'
    leca $"sudo wget -qO /etc/apt/trusted.gpg.d/cisofy-key.asc 
        https://packages.cisofy.com/keys/cisofy-software-public.key"
    pca $success $'cisofy-key.asc downloaded'

    pca $action $'Disabling translations for lynis'
    leca $"sudo echo 'Acquire::Languages \"none\";' 
        | sudo tee /etc/apt/apt.conf.d/99disable-translations"
    pca $success $'99disable-translations created'

    pca $action $'Creating cisofy-lynis.list'
    leca $"sudo echo 
        'deb https://packages.cisofy.com/community/lynis/deb/ stable main'
        | sudo tee /etc/apt/sources.list.d/cisofy-lynis.list"
    pca $success $'cisofy-lynis.list created'

    # Docker pre steps
    pca $action $'Downloading docker.gpg'
    leca $"sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg 
        | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg --yes"
    pca $success $'docker.gpg downloaded'

    pca $action $'Creating docker.list'
    leca $"sudo echo 
        \"deb [arch=$(dpkg --print-architecture) 
        signed-by=/etc/apt/keyrings/docker.gpg] 
        https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" 
        | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null"
    pca $success $"docker.list created"

    pca $action $'Setting permissions for docker.gpg'
    leca $"sudo chmod a+r /etc/apt/keyrings/docker.gpg"
    pca $success $'Permissions for docker.gpg set'

    # Github pre steps
    pca $action $'Downloading githubcli-archive-keyring.gpg'
    leca $"sudo curl -fsSL 
        https://cli.github.com/packages/githubcli-archive-keyring.gpg 
        | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg"
    pca $success $'githubcli-archive-keyring.gpg downloaded'

    pca $action $'Setting permissions for githubcli-archive-keyring.gpg'
    leca $"sudo chmod go+r 
        /usr/share/keyrings/githubcli-archive-keyring.gpg"
    pca $success $'Permissions for githubcli-archive-keyring.gpg set'

    pca $action $'Creating github-cli.list'
    leca $"sudo echo \"deb [arch=$(dpkg --print-architecture) 
        signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] 
        https://cli.github.com/packages stable main\" 
        | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null"
    pca $success $'github-cli.list created'

    #Installs
    install_helper $'lynis'
    install_helper $'aide'
    install_helper $'git'
    install_helper $'curl'
    install_helper $'ca-certificates'
    install_helper $'gnupg'
    install_helper $'lsb-release'
    install_helper $'docker-ce'
    install_helper $'docker-ce-cli'
    install_helper $'containerd.io'
    install_helper $'docker-compose-plugin'
    install_helper $'gh'
    install_helper $'bash-completion'
    install_helper $'wireguard'

    # GIT CONFIGS
    git_configs
    docker_configs

    pca $end $'Unofficial packages installed and configured for use!'
}

#region
#===========================================================================
# GIT CONFIGS
#===========================================================================
#
# Description:
#   This function will configure the git user and email
#
# Arguments:
#   None
#===========================================================================
#endregion
function git_configs() {
    pca $start $'Starting git configs process'
    pca $action $'Configuring git user and email'
    leca $"git config --global user.name $GIT_USERNAME"
    leca $"sudo git config --global user.name $GIT_USERNAME"
    if [ $? -eq 0 ]; then
        pca $success $'Git user configured successfully'
    else
        pca $failure $'Git user configuration failed'
    fi
    leca $"git config --global user.email $GIT_EMAIL"
    leca $"sudo git config --global user.email $GIT_EMAIL"
    if [ $? -eq 0 ]; then
        pca $success $'Git email configured successfully'
    else
        pca $failure'Git email configuration failed'
    fi
    pca $end $'Ending git configs process'
}

#region
#===========================================================================
# FUNCTION: docker_configs
#===========================================================================
#
# Description:
#   This function configures docker
#
# Arguments:
#   None
#===========================================================================
#endregion
function docker_configs() {
    pca $start $'Starting Docker Configs'
    pca $action $'Adding docker group'
    leca $"sudo groupadd docker > /dev/null"

    pca $action $'Adding user to docker group'
    leca $"sudo usermod -aG docker $CURRENT_USER"
    if [ $? -eq 0 ]; then
        pca $success $'User added to docker group successfully'
    else
        pca $failure $'Failed to add user to docker group'
    fi

    pca $action $'Enabling docker service'
    leca $"sudo systemctl enable docker.service"
    if [ $? -eq 0 ]; then
        pca $success $'Docker service enabled successfully'
    else
        pca $failure $'Failed to enable docker service'
    fi

    pca $action $'Enabling containerd service'
    leca $"sudo systemctl enable containerd.service"
    if [ $? -eq 0 ]; then
        pca $success $'Containerd service enabled successfully'
    else
        pca $failure $'Failed to enable containerd service'
    fi

    pca $end $'Ending Docker Configs'
}

#  ___________
# |           |
# |  HELPERS  |
# |___________|
#        \   ^__^
#         \  (oo)\_______
#            (__)\       )\/\
#                ||----w |
#                ||     ||

#region
#===========================================================================
# PRINT CURRENT ACTION
#===========================================================================
#
# Description:
#   Prints the passed in action in the terminal and to the log file.
#
# Arguments:
#   $1 - color of the text to be printed
#   $2 - action to be printed
#===========================================================================
#endregion
function pca() {

    hyphens=76
    echo -e -n "$1"
    printf '%*s\n' "$hyphens" | tr ' ' '=' | tee -a "$LOGFILE"
    char_limit_helper " $(date +%m.%d.%Y_%H:%M:%S) : $2 "
    printf '%*s\n' "$hyphens" | tr ' ' '=' | tee -a "$LOGFILE"
    echo -e -n "${nocolor}"
}

#region
#===========================================================================
# LOG AND EXECUTE CURRENT COMMAND
#===========================================================================
#
# Description:
#   Prints the passed in action in the terminal and to the log file.
#
# Arguments:
#   $1 - command
#===========================================================================
#endregion
function leca() {
    echo -e -n "${white}"

    # Trims newlines and indentation
    trimmed=$(echo "$1" | sed -e 's/^[ \t]*//' | tr -d '\n')

    # Prints to logfile
    leca_print_to_log "$trimmed"

    #sleep 0.2
    echo -e -n "${nocolor}"
    eval "$trimmed" >/dev/null
    return $?
}

#endregion
function leca_print_to_log() {
    local string="$1"
    local limit=76
    i=0

    # Check if the line is already short enough
    if [[ ${#string} -le $limit ]]; then
        echo "$string" | tee -a "$LOGFILE"
        return
    fi

    while [ "${#string}" -gt $limit ]; do
        # Find the last whitespace before the limit
        last_space=${string:0:$limit}
        last_space=${last_space##* }

        # Split the string at the last whitespace before the limit
        sub_string=${string:0:$((limit - ${#last_space}))}
        string=${string:$((limit - ${#last_space}))}

        echo "$sub_string" | tee -a "$LOGFILE"
        i=$((i + 1))
        # Add 4 whitespace indentations for substrings after the first substring
        if [ "$i" -gt 0 ]; then
            string="    ${string}"
            limit=$((limit - 4))
        fi
    done
    echo "$string" | tee -a "$LOGFILE"
    return 0
}

#region
#===========================================================================
# CHAR LIMIT HELPER
#===========================================================================
#
# Description:
#   Helper for printing strings that exceed the character limit
#
# Arguments:
#   $1 - Line to be printed
#===========================================================================
#endregion
function char_limit_helper() {
    local -r LINE="$1"
    local -i MAX_LEN=76
    time_length=$((("$(echo -n $(date +%m.%d.%Y_%H:%M:%S) : | wc -m)") + 2))

    # Check if the line is already short enough
    if [[ ${#LINE} -le $MAX_LEN ]]; then
        echo -e "$LINE" | tee -a "$LOGFILE"
        return
    fi

    words=$(echo $LINE | tr " " "\n")
    newLine=" "

    for word in $words; do
        # Check if the length of the line plus the length of the next word
        # is greater than the character limit
        if [ $((${#newLine} + ${#word})) -gt $MAX_LEN ]; then
            #Print the line and add a new line
            echo -e "$newLine" | tee -a "$LOGFILE"
            newLine="$(printf '%*s' "$time_length")""$word "
        else
            #Add the word to the lin
            newLine=""$newLine"$word "
        fi
    done
    #Print the last line
    echo -e "$newLine" | tee -a "$LOGFILE"

}

#region
#===========================================================================
# VERIFY HELPER
#===========================================================================
#
# Description:
#   Verifies the success of an action
#
# Arguments:
#   $1 - The exit code of the action to verify
#===========================================================================
#endregion
function verify_helper() {
    if [ $1 -eq 0 ]; then
        pca $success $"$1 succeeded"
    else
        pca $failure $"$1 failed"
    fi
}

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

#region
#===========================================================================
# ENABLE SERVICE HELPER
#===========================================================================
#
# Description:
#   Enable a service if it is disabled
#
# Arguments: @TODO
#   $1 - Name of service to enable
#===========================================================================
#endregion
function enable_service_helper() {
    service=$1
    # Enables, if disabled
    pca $check $"Checking if $service is enabled"
    if [ $(sudo systemctl is-enabled $service) = "disabled" ]; then
        pca $action $"Enabling $service"
        leca $"sudo systemctl enable $service"
        # Check if sysstat is enabled
        if [ $(sudo systemctl is-enabled $service) = "enabled" ]; then
            pca $success $"$service enabled successfully"
        else
            pca $failure $"Failed to enable $service"
        fi
    else
        pca $positive $"$service is already enabled!"
    fi
}

#region call methods
#  ___________
# |           |
# |   SETUP   |
# |___________|
#        \   ^__^
#         \  (oo)\_______
#            (__)\       )\/\
#                ||----w |
#                ||     ||
setup_environment
check_distro
begin_log
update_ubuntu
set_motd
#  ___________
# |           |
# |  PACKAGES |
# |___________|
#        \   ^__^
#         \  (oo)\_______
#            (__)\       )\/\
#                ||----w |
#                ||     ||
install_unofficial_packages
#  ___________
# |           |
# |    MISC   |
# |___________|
#        \   ^__^
#         \  (oo)\_______
#            (__)\       )\/\
#                ||----w |
#                ||     ||
add_legal_warnings
remove_information_disclosure_smtp_banner
change_umask_value
# change_systemd_journal_max_file_size
# change_login_defs
# disable_core_dump
# disable_allow_url_fopen
disable_ip_protocols
# disable_usb
#endregion

#sudo reboot
