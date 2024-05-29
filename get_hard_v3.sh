#!/bin/bash

# Permission denied errors: sh -c

export GIT_USERNAME="metalconker"
export GIT_EMAIL="2914720+metalconker@users.noreply.github.com"
export CURRENT_USER=$(whoami)

#region intro text
# NOTES
# NOTE 1 : can be changed to no for better security

# Script to Harden Security on Ubuntu 20.04 LTS (untested on anything else)
# This VPS Server Hardening script is designed to be run on new VPS
# deployments to simplify a lot of the basic hardening that can be done to
# protect your server.
# A large chunk is rewritten, while the simpler funcs are kept intact.
# Credits: akcryptoguy, AMega

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

    echo "Setting up environment..."
    echo "Defining colors..."
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
    LOGFILE='/var/log/server_hardening.log'
    SSHDFILE='/etc/ssh/sshd_config'
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
    echo "Checking distribution..."
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
    sudo >|"$LOGFILE"
    sudo chown $CURRENT_USER "$LOGFILE"
    echo $CURRENT_USER
    chmod 755 "$LOGFILE"
    echo -e -n "$lightpurple"
    echo | developer_banner | tee -a "$LOGFILE"
    sleep 2

    echo -e -n "$lightgray"
    echo -e "\
    \
    \
                        _  _ ___  ____    \n\
                        |  | |__] [__     \n\
                         \\/  |    ___]    \n\
                                           \n\
           _  _ ____ ____ ___  ____ _  _ _ _  _ ____    \n\
           |__| |__| |__/ |  \\ |___ |\\ | | |\\ | | __    \n\
           |  | |  | |  \\ |__/ |___ | \\| | | \\| |__]    \n\
                                                       \n\
                    ____ ____ ____ _ ___  ___ \n\
                    [__  |    |__/ | |__]  |  \n\
                    ___] |___ |  \\ | |     |  \
                    \
                    " | tee -a "$LOGFILE"

    pca $success $'Script Started Successfully'
    sleep 2
}

#region
#===========================================================================
# UPDATE UBUNTU
#===========================================================================
#
# Description:
#   Updates and upgrades Ubuntu system packages with the apt-get command
#
# Arguments:
#   None
#===========================================================================
#endregion
function update_ubuntu() {
    pca $start $'Starting system update...'
    pca $action $'Updating Ubuntu 22.04'

    leca $"sudo apt-get install language-pack-en-base"
    leca $"sudo locale-gen en_US.UTF-8"
    leca $"sudo update-locale LANG=en_US.UTF-8"

    leca $"sudo apt-get -qqy update 2>/dev/null"
    leca $'sudo apt-get full-upgrade -y -o Acquire::ForceIPv4=true -qq'

    pca $success $'Ubuntu Successfully Updated!'
    pca $end $'System updated!'
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
        leca $"sudo sh -c 'echo \"Custom Commands:\" >> /etc/motd'"
        leca $"sudo sh -c 'echo \"1) cd_docker: navigate to the location 
            where docker should be initiated\" >> /etc/motd'"
        leca $"sudo sh -c \"echo \"\" >> /etc/motd\""
        pca $success $'Warnings added to /etc/motd'
    fi

    # @TODO

    pca $success $'MOTD successfully set!'
    pca $end $'MOTD created!'
}

#region
#===========================================================================
# SET FIREWALL USING UFW (UNCOMPLICATED FIREWALL)
#===========================================================================
#
# Description:
#   UFW (Uncomplicated Firewall) is a user-friendly front-end to iptables,
#   the Linux kernel's built-in firewall facility.
#   This script will set up a basic firewall using UFW.
#
# Arguments:
#   None
#
#===========================================================================
#endregion
function set_firewall_ufw() {

    declare -A loopbacks=(
        ["allow_loopback_in"]="allow in on lo"
        ["deny_ipv4_local"]="deny in from 127.0.0.0/8"
        ["deny_ipv6_local"]="deny in from ::1"
    )

    declare -A ports=(
        ['SSH']='allow 22 tcp'
        ['http']='allow 80 tcp'
        ['http_udp']='allow 80 udp'
        ['https']='allow 443 tcp'
        ['https_udp']='allow 443 udp'
        ['proxy']='allow 8080 tcp'
        ['proxy_udp']='allow 8080 udp'
        ['dns']='allow 53 tcp'
        ['dns_udp']='allow 53 udp'
    )

    declare -A defaults=(
        ["default_incoming"]="default deny incoming"
        ["default_outgoing"]="default allow outgoing"
        ["default_routed"]="default deny routed"
    )

    declare -A logging=(
        ["enable_logging"]="logging on"
        ["logging_level"]="logging medium"
    )

    pca $start $'Setting firewall...'

    # Clear out iptables and ufw rules
    pca $action $'Clearing out iptables and ufw rules...'
    leca $"sudo ufw -f reset && sudo ufw allow 22/tcp && sudo ufw -f enable"
    pca $success $'ufw rules cleared successfully!'

    # Disable ufw
    pca $action $'Disabling ufw...'
    leca $'sudo ufw disable'

    pca $neutral $'Setting loopbacks...'
    # Loopbacks
    for loopback in "${!loopbacks[@]}"; do
        pca $action $"Applying ${loopbacks[$loopback]}"
        leca $"sudo ufw ${loopbacks[$loopback]}"
    done

    # Set ports
    for port in "${!ports[@]}"; do
        add_rule_to_ufw ${ports[$port]}
    done

    pca $neutral $'Setting default policies'
    # Sets the default policies
    for default in "${!defaults[@]}"; do
        pca $action $"Applying ${defaults[$default]}"
        leca $"sudo ufw ${defaults[$default]}"
    done

    pca $neutral $'Setting logging policies'
    # Sets the default policies
    for logging in "${!loggings[@]}"; do
        pca $action $"Applying ${loggings[$logging]}"
        leca $"sudo ufw ${loggings[$logging]}"
    done

    # Enable ufw
    pca $action $'Enabling ufw...'
    leca $"sudo ufw enable"
    pca $end $'Firewall set!'

}

#region
#===========================================================================
# INSTALL SYSTEM PACKAGES
#===========================================================================
#
# Description:
#   Installs useful system packages
#
# Arguments:
#   None
#===========================================================================
#endregion
function install_system_packages() {
    pca $start $'Installing useful system packages...'

    install_helper $'ufw'
    install_helper $'aptitude'
    install_helper $'lsb-core'
    install_helper $'debsums'
    install_helper $'apt-show-versions'

    pca $end $'System packages installed!'
}

#region
#===========================================================================
# INSTALL SERVICES
#===========================================================================
#
# Description:
#   Installs and enables services
#
# Arguments:
#   None
#===========================================================================
#endregion
function install_services() {
    pca $start $'Installing and enabling services...'

    install_helper $'sysstat'
    enable_service_helper $'sysstat'

    pca $end $'Services installed and enabled!'
}

#region
#===========================================================================
# INSTALL_ROOTKIT_CHECKERS
#===========================================================================
#
# Description:
#   Installs rootkit checkers and scans for suspicious activity
#
# Arguments:
#   None
#===========================================================================
#endregion
function install_rootkit_checkers() {

    pca $start $'Installing rootkit checkers...'

    # Install dependencies
    install_helper $'libz-dev'
    install_helper $'libssl-dev'
    install_helper $'libpcre2-dev'
    install_helper $'build-essential'
    install_helper $'libsystemd-dev'

    #Install packages
    install_helper $'rkhunter'
    install_helper $'chkrootkit'

    # Update the rkhunter config to remove invalid scriptwhitelist errors
    pca $action $'Updating rkhunter config...'
    leca $"sudo sed -i
        \"s/SCRIPTWHITELIST=.*$/SCRIPTWHITELIST=/g\" /etc/rkhunter.conf"
    leca $"sudo sed -i '/WEB_CMD=/d' /etc/rkhunter.conf"
    leca $"sudo rkhunter --propupd"

    pca $end $'Rootkit checkers installed!'

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

#region
#===========================================================================
# aide configs
#===========================================================================
#
# Description:
#   Configures AIDE
#
# Arguments:
#   None
#===========================================================================
#endregion
# function aide_configs(){
#     pca $start $'Starting AIDE configs process'
#     pca $action $'Running aideinit'
#     leca $"sudo aideinit"
#     if [ $? -eq 0 ]; then
#         pca $success $'Aideinit successfully ran'
#     else
#         pca $failure $'Aideinit failed to run'
#     fi
#     pca $action $'Copying aide.db.new to aide.db'
#     leca $"sudo cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db"
#     if [ $? -eq 0 ]; then
#         pca $success $'Aide.db.new successfully copied to aide.db'
#     else
#         pca $failure $'Aide.db.new failed to copy to aide.db'
#     fi
#     pca $action $'Running update-aide.conf'
#     leca $"sudo update-aide.conf"
#     if [ $? -eq 0 ]; then
#         pca $success $'update-aide.conf successfully ran'
#     else
#         pca $failure $'update-aide.conf failed to run'
#     fi
#     pca $action $'Copying aide.conf.autogenerated to /etc/aide/aide.conf'
#     leca $"cp /var/lib/aide/aide.conf.autogenerated /etc/aide/aide.conf"
#     if [ $? -eq 0 ]; then
#         pca $success $'aide.conf.autogenerated successfully copied to /etc/aide/aide.conf'
#     else
#         pca $failure $'aide.conf.autogenerated failed to copy to /etc/aide/aide.conf'
#     fi
#     pca $action $'Creating cron job to run AIDE daily'
#     if ! grep -q "aide --check" /etc/crontab; then
#         leca $"echo '0 0 * * * root aide --check' >> /etc/crontab"
#         leca $"systemctl restart cron"
#         if [ $? -eq 0 ]; then
#             pca $success $'Cron job successfully created to run AIDE daily'
#         else
#             pca $failure $'Cron job failed to create to run AIDE daily'
#         fi
#     else
#         pca $success $'Cron job already exists to run AIDE daily'
#     fi
#     pca $end $'Ending AIDE configs process'
# }

#region
#===========================================================================
# HARDEN_COMPILERS
#===========================================================================
#
# Description:
#   Sets the ownership and permissions of various compilers to root.
#
# Arguments:
#   None
#===========================================================================
#endregion
# function harden_compilers() {
#     pca $start $'Hardening compilers...'
#     # Get list of compilers
#     COMPILERS=`which gcc g++ clang clang++ as`

#     # Set ownership and permissions
#     for compiler in $COMPILERS; do
#         pca $action $"Setting owner of $compiler to root"
#         leca $"sudo chown root:root $compiler"
#         leca $"sudo chmod 700 $compiler"
#     done

#     pca $end $'Compilers hardened!'
# }

#region
#===========================================================================
# HARDEN KERNEL
#===========================================================================
#
# Description:
#   Hardens the kernel settings by setting values in the
#   /etc/sysctl.d/10-kernel-hardening.conf file.
#
# Arguments:
#   None
#===========================================================================
#endregion
# function harden_kernel() {
#     pca $start $'Hardening kernel...'

#     # Variables
#     file='/etc/sysctl.d/10-kernel-hardening.conf'
#     spacing=$' = '
#     verify=0
#     declare -A values
#     values=(
#         ['kernel.dmesg_restrict']='1'
#         ['kernel.kptr_restrict']='1'
#         ['kernel.sysr']='0'
#         ['kernel.modules_disabled']='1'
#         ['kernel.perf_event_paranoid']='3'
#         ['kernel.yama.ptrace_scope']='1'
#     )

#     #Check duplicates
#     duplicate_check_helper $file

#     # # Performs changes/additions
#     for key in "${!values[@]}" ; do
#         sysctl_config_helper $key ${values[$key]} $file "$spacing"
#     done

#     # Verify the modifications have been made
#     for key in "${!values[@]}" ; do
#         if [[ $(sudo grep -E "^[^#]*$key" $file \
#         | sudo grep -Ec "${values[$key]}$") -eq 1 ]]; then continue
#         else
#             verify=1
#         fi
#     done
#     verify_helper $verify

#     pca $end $'Kernel hardened!'

# }

#region
#===========================================================================
# HARDEN IP4
#===========================================================================
#
# Description:
#   Hardens IPv4 network settings by setting/adding specified variables and
#   their values to the '/etc/sysctl.d/10-network-security.conf' file
#
# Arguments:
#   None
#===========================================================================

#endregion
# function harden_ip4() {
#     pca $start $'Starting IP4 Hardening'

#     # Variables
#     file='/etc/sysctl.d/10-network-security.conf'
#     spacing=$' = '
#     verify=0

#     declare -A values
#     values=(
#         ['net.ipv4.conf.all.forwarding']='0'
#         ['net.ipv4.conf.all.log_martians']='1'
#         ['net.ipv4.conf.default.log_martians']='1'
#         ['net.ipv4.conf.all.rp_filter']='1'
#     )

#     #Check duplicates
#     duplicate_check_helper $file

#     # # Performs changes/additions
#     for key in "${!values[@]}" ; do
#         sysctl_config_helper $key ${values[$key]} $file "$spacing"
#     done

#     # Verify the modifications have been made
#     for key in "${!values[@]}" ; do
#         if [[ $(sudo grep -E "^[^#]*$key" $file \
#         | sudo grep -Ec "${values[$key]}$") -eq 1 ]]; then continue
#         else
#             verify=1
#         fi
#     done
#     verify_helper $verify

#     pca $end $'Ending IP4 Hardening'

# }

#region
#===========================================================================
# HARDEN SSH
#===========================================================================
#
# Description:
#   Harden SSH configuration by disabling password authentication,
#   enabling public key authentication, allowing TCP forwarding, setting
#   maximum client alive count, disabling agent forwarding, setting  verbose
#   logging level, setting maximum authentication tries, setting maximum
#   sessions, disabling TCP keep alive, disabling root login and disabling
#   X11 forwarding.
#
# Arguments:
#   None
#===========================================================================
#endregion
function harden_ssh() {
    pca $start $'Hardening SSH...'

    # Variables
    file='/etc/ssh/sshd_config'
    spacing=$' '
    verify=0
    declare -A values
    values=(
        ["PasswordAuthentication"]="no"
        ["PubkeyAuthentication"]="yes"
        ["Protocol"]="2"
        ["AllowTcpForwarding"]="yes"
        ["ClientAliveCountMax"]="2"
        ["AllowAgentForwarding"]="no"
        ["LogLevel"]="VERBOSE"
        ["MaxAuthTries"]="3"
        ["MaxSessions"]="2"
        ["TCPKeepAlive"]="no"
        ["PermitRootLogin"]="no"
        ["X11Forwarding"]="no"
    )

    #Check duplicates
    duplicate_check_helper $file

    # # Performs changes/additions
    for key in "${!values[@]}"; do
        sysctl_config_helper $key ${values[$key]} $file "$spacing"
    done

    # Verify the modifications have been made
    for key in "${!values[@]}"; do
        if [[ $(sudo grep -E "^[^#]*$key" $file |
            sudo grep -Ec "${values[$key]}$") -eq 1 ]]; then
            continue
        else
            verify=1
        fi
    done
    duplicate_check_helper $file
    verify_helper $verify

    pca $end $'SSH hardened!'
}

#region harden redis commented out
#===========================================================================
# HARDEN REDIS
#===========================================================================
#
# Description:
#   Harden SSH configuration by disabling password authentication,
#   enabling public key authentication, allowing TCP forwarding, setting
#   maximum client alive count, disabling agent forwarding, setting  verbose
#   logging level, setting maximum authentication tries, setting maximum
#   sessions, disabling TCP keep alive, disabling root login and disabling
#   X11 forwarding.
#
# Arguments:
#   None
#
#===========================================================================
# function harden_redis() {
#     pca $start $'Hardening Redis...'

#     # Update Redis configuration to set the password
#     leca $"sed -i \"s/^\# requirepass/requirepass $REDIS_PASSWORD/\"
#      /etc/redis/redis.conf"

#     # Restart Redis service to apply the changes
#     systemctl restart redis
# }
#endregion

#region
#===========================================================================
# REMOVE INFORMATION DISCLOSURE IN SMTP BANNER
#===========================================================================
#
# Description:
#   Removes information disclosure in SMTP banner by adding the smtpd_banner
#   parameter to the postfix configuration file and restarting the postfix
#   service.
#
# Arguments:
#   None
#===========================================================================
#endregion
function remove_information_disclosure_smtp_banner() {
    pca $start $'Removing information disclosure in SMTP banner...'

    # Check duplicates
    duplicate_check_helper $'/etc/postfix/main.cf'
    if [ -f /etc/postfix/main.cf ]; then
        # Check if the smtp banner exists
        if sudo grep -q "smtpd_banner" /etc/postfix/main.cf; then
            # Replace the existing smtp banner
            pca $action $'Replacing existing banner...'
            leca $"sudo sed -i 's/smtpd_banner = 
                .*/smtpd_banner = \$myhostname/g' /etc/postfix/main.cf"
        else
            # Add the smtp banner
            pca $action $'Adding new banner...'
            leca $"sudo echo \"smtpd_banner = \$myhostname\" >> 
                /etc/postfix/main.cf"
        fi
    else
        pca $neutral $'Nothing to remove...'
    fi

    # Restart
    if [ -x "/usr/bin/postfix" ]; then
        pca $action $'Restarting postfix service...'
        leca $'sudo systemctl restart postfix'
        if [ $? -eq 0 ]; then
            pca $success $'Successfully restarted postfix service'
        else
            pca $failure $'Failed to restart postfix service'
        fi
    else
        pca $neutral $'Postfix not installed...'
    fi

    pca $end $'Removed information disclosure in SMTP banner'
}

#region
#===========================================================================
# DISABLE ALLOW_URL_FOPEN
#===========================================================================
#
# Description:
#   Disables allow_url_fopen in Ubuntu 20.04
#
# Arguments:
#   None
#===========================================================================s
#endregion
# function disable_allow_url_fopen(){

#     # Variables
#     file='/etc/ssh/sshd_config'
#     spacing=$' '
#     verify=0
#     if [ -f /usr/bin/php ]; then
#         pca $start $'Disabling allow_url_fopen in PHP...'
#         pca $check $'Checking allow_url_fopen...'
#         leca $'sudo php -i | grep allow_url_fopen'
#         if [ $? -eq 0 ]; then
#             pca $action $'Disabling allow_url_fopen...'
#             leca $"sudo sed -i
#                 \"s/allow_url_fopen = On/allow_url_fopen = Off/g\"
#                 /etc/php/7.4/cli/php.ini"
#             if [ $? -eq 0 ]; then
#                 pca $success $'allow_url_fopen disabled successfully!'
#             else
#                 pca $failure $'allow_url_fopen could not be disabled!'
#             fi
#         else
#             pca $positive $'allow_url_fopen is already disabled!'
#         fi
#         pca $end $'allow_url_fopen disabled!'
#     fi
# }

#region
#===========================================================================
# DISABLE CORE DUMP
#===========================================================================
#
# Description:
#   Explicitly disables of core dump in /etc/security/limits.conf file
#
# Arguments:
#   None
#===========================================================================s
# disable_core_dump() {
#     pca $start $'Explicitly disabling core dump...'
#     pca $check $'Checking /etc/security/limits.conf...'
#     # Check if the entry already exists
#     if sudo grep -q "\*\s\+hard\s\+core\s\+0" /etc/security/limits.conf;
#     then
#         pca $positive $'Core dump is already disabled!'
#     else
#         pca $action $'Disabling core dump...'
#         # Append the entry to the end of the file
#         leca $"sudo echo \"  *                hard    core            0\"
#             >> /etc/security/limits.conf"
#         pca $success $'Core dump disabled!'
#     fi
#     pca $end $'Completed explicit disabling of the core dump!'
# }

#region
#===========================================================================
# DISABLE_IP_PROTOCOLS
#===========================================================================
#
# Description:
#   Disables the given IP protocols in the system.
#
# Arguments:
#   None
#===========================================================================
#endregion
function disable_ip_protocols() {
    pca $start $'Disabling unnecessary IP protocols...'

    #check to see if dccp has been disabled
    pca $check $'Checking if dccp already disabled...'
    if [ -f /etc/modprobe.d/nodccp ]; then
        pca $positive $'dccp already disabled.'
    else
        pca $action $'Disabling dccp...'
        leca $'sudo touch /etc/modprobe.d/nodccp && 
            sudo echo "install dccp /bin/true" >> /etc/modprobe.d/nodccp'
        pca $success $'dccp disabled!'
    fi

    #check to see if sctp has been disabled
    pca $check $'Checking if sctp already disabled...'
    if [ -f /etc/modprobe.d/nosctp ]; then
        pca $positive $'sctp already disabled.'
    else
        pca $action $'Disabling sctp...'
        leca $'sudo touch /etc/modprobe.d/nosctp && 
            sudo echo "install sctp /bin/true" >> /etc/modprobe.d/nosctp'
        pca $success $'sctp disabled!'
    fi

    #check to see if rds has been disabled
    pca $check $'Checking if rds already disabled...'
    if [ -f /etc/modprobe.d/nords ]; then
        pca $positive $'rds already disabled.'
    else
        pca $action $'Disabling rds...'
        leca $'sudo touch /etc/modprobe.d/nords && 
            sudo echo "install rds /bin/true" >> /etc/modprobe.d/nords'
        pca $success $'rds disabled!'
    fi

    #check to see if tipc has been disabled
    pca $check $'Checking if tipc already disabled...'
    if [ -f /etc/modprobe.d/notipc ]; then
        pca $positive $'tipc already disabled.'
    else
        pca $action $'Disabling tipc...'
        leca $'sudo touch /etc/modprobe.d/notipc && 
            sudo echo "install tipc /bin/true" >> /etc/modprobe.d/notipc'
        pca $success $'tipc disabled!'
    fi

    #check to see if completed successfully
    if [ -f /etc/modprobe.d/nodccp ] && [ -f /etc/modprobe.d/nosctp ] &&
        [ -f /etc/modprobe.d/nords ] && [ -f /etc/modprobe.d/notipc ]; then
        pca $success $'Unnecessary IP protocols successfully disabled.'
    else
        pca $failure $'Unnecessary IP protocols not successfully disabled.'
    fi

    pca $end $'Unnecessary protocols disabled!'
}

#region
#===========================================================================
# BLACKLIST USB
#===========================================================================
#
# Description:
#   Checks if sudo nano /etc/modprobe.d/blacklist.conf contains blacklist
#   usb_storage and if not, adds it with a simple comment above, and then
#   checks if it contains blacklist uas and if not, adds it with a simple
#   comment above
#
# Arguments:
#   None
#===========================================================================
#endregion
function disable_usb() {
    pca $start $'Starting USB blacklisting...'

    # USB Storage
    pca $check $'Checking if blacklist.conf contains blacklist usb_storage'
    if sudo grep -q "blacklist usb_storage" \
        "/etc/modprobe.d/blacklist.conf"; then
        pca $positive $'Blacklist usb_storage found'
    else
        pca $negative $'Blacklist usb_storage not found'
        pca $action $'Adding Blacklist usb_storage'
        leca $"sudo echo '# Blacklist usb devices' 
            | sudo tee -a /etc/modprobe.d/blacklist.conf"
        leca $"sudo echo 'blacklist usb_storage' | 
            sudo tee -a /etc/modprobe.d/blacklist.conf"
        pca $success $'Blacklist usb_storage added'
    fi

    # USB Attached SCSI
    pca $check $'Checking if blacklist.conf contains blacklist uas'
    if sudo grep -q "blacklist uas" "/etc/modprobe.d/blacklist.conf"; then
        pca $positive $'Blacklist uas found'
    else
        pca $negative $'Blacklist uas not found'
        pca $action $'Adding Blacklist uas'
        leca $"sudo echo '# Blacklist UAS' | 
            sudo tee -a /etc/modprobe.d/blacklist.conf"
        leca $"sudo echo 'blacklist uas' | sudo 
            tee -a /etc/modprobe.d/blacklist.conf"
        pca $success $'Blacklist uas added'
    fi
    if sudo grep -q "blacklist usb_storage" \
        "/etc/modprobe.d/blacklist.conf" && grep -q "blacklist uas" \
        "/etc/modprobe.d/blacklist.conf"; then
        pca $success $'Entries added successfully!'
    else
        pca $failure $'Failed to add entries'
    fi
    pca $end $'USB Blacklisting complete!'
}

#region
#===========================================================================
# CHANGE SYSTEMD JOURNAL MAX FILE SIZE
#===========================================================================
#
# Description:
#   Changes the max file size of systemd journals to 100mb
#
# Arguments:
#   None
#===========================================================================
#endregion
# function change_systemd_journal_max_file_size(){

#     # Variables
#     file='/etc/systemd/journald.conf'
#     spacing=$'='
#     verify=0

#     pca $start $'Changing Systemd journal max file size...'

#     sysctl_config_helper $"SystemMaxUse" $"100M" "$file" "$spacing"

#     # pca $action $'Setting Systemd Journal Max File Size to 100mb'
#     # leca $"sudo sed -i
#     #     '/SystemMaxUse/s/^#//g;s/SystemMaxUse=.*/SystemMaxUse=100M/'
#     #     /etc/systemd/journald.conf"
#     leca $"sudo systemctl restart systemd-journald"

#     pca $check $'Checking new Systemd Journal Max File Size'

#     if  [ "$(sudo grep -Eo "SystemMaxUse=[0-9]+M" \
#         /etc/systemd/journald.conf | cut -d'=' -f2)" == "100M" ]; then
#         pca $success $'Successfully changed Systemd Journal
#          Max File Size to 100mb'
#     else
#         pca $failure $'Failed to change Systemd Journal
#          Max File Size to 100mb'
#     fi

#     pca $end $'Systemd journal max file size changed!'
# }

#region
#===========================================================================
# UPDATE LOGIN DEFS
#===========================================================================
#
# Description:
#   Updates the value of SHA_CRYPT_MIN_ROUNDS, SHA_CRYPT_MAX_ROUNDS,
#   PASS_MAX_DAYS, PASS_MIN_DAYS, and PASS_WARN_AGE in the login.defs file
#
# Arguments:
#   None
#===========================================================================
#endregion
# function change_login_defs(){
#     pca $start $'Starting change_login_defs process'
#     pca $action $"Updating SHA_CRYPT_MIN_ROUNDS, SHA_CRYPT_MAX_ROUNDS,
#         PASS_MAX_DAYS, PASS_MIN_DAYS, and PASS_WARN_AGE in the login.defs
#         file"
#     leca $"sudo sed -i 's/#[ ]*SHA_CRYPT_MIN_ROUNDS/SHA_CRYPT_MIN_ROUNDS/g'
#         /etc/login.defs"
#     leca $"sudo sed -i 's/#[ ]*SHA_CRYPT_MAX_ROUNDS/SHA_CRYPT_MAX_ROUNDS/g'
#         /etc/login.defs"
#     leca $"sudo sed -i 's/PASS_MAX_DAYS\s[0-9]*/PASS_MAX_DAYS 99998/g'
#         /etc/login.defs"
#     leca $"sudo sed -i 's/PASS_MIN_DAYS\s[0-9]*/PASS_MIN_DAYS 1/g'
#         /etc/login.defs"
#     leca $"sudo sed -i 's/PASS_WARN_AGE\s[0-9]*/PASS_WARN_AGE 8/g'
#         /etc/login.defs"
#     if [ $? -eq 0 ]; then
#         pca $success $'Successfully updated SHA_CRYPT_MIN_ROUNDS,
#             SHA_CRYPT_MAX_ROUNDS, PASS_MAX_DAYS, PASS_MIN_DAYS,
#             and PASS_WARN_AGE in the login.defs file'
#     else
#         pca $failure $'Failed to update SHA_CRYPT_MIN_ROUNDS,
#             SHA_CRYPT_MAX_ROUNDS, PASS_MAX_DAYS, PASS_MIN_DAYS,
#             and PASS_WARN_AGE in the login.defs file'
#     fi
#     pca $end $'Ending change_login_defs process'
# }

#region
#===========================================================================
# CHANGE UMASK VALUE
#===========================================================================
#
# Description:
#   Changes the value of umask to 027 without removing whitespace between
#   the word UMASK and the current value, in login file
#
# Arguments:
#   None
#===========================================================================
#endregion
# function change_umask_value(){
#     pca $start $'Changing default UMASK Value...'

#     # Replacement
#     pca $action $'Replacing umask value in login file'
#     leca $"sudo sed -i '/UMASK[[:blank:]]\{1,\}[0-9]\{3\}/s/[0-9]\{3\}/027/'
#         /etc/login.defs"
#     if [ $? -eq 0 ]; then
#         pca $success $'Umask value successfully replaced!'
#     else
#         pca $failure $'Umask value replacement failed!'
#     fi

#     #Checking
#     pca $check $'Checking if umask value was changed successfully'
#     leca $"sudo grep -q \"\s*UMASK\s*027\s*\" /etc/login.defs"
#     if [ $? -eq 0 ]; then
#         pca $success $'Umask value successfully changed!'
#     else
#         pca $failure $'Umask value change failed!'
#     fi
#     pca $end $'Changed default UMASK value!'
# }
# @TODO

#region
#===========================================================================
# ADD_LEGAL_WARNINGS
#===========================================================================
#
# Description:
#   Adds legal warnings to /etc/issue and /etc/issue.net
#
# Arguments:
#   None
#===========================================================================
#endregion
function add_legal_warnings() {
    pca $start $'Starting adding legal warnings...'

    # Add legal banner to /etc/issue
    if [ -f /etc/issue ]; then
        pca $action $'Adding legal warnings to /etc/issue'
        leca $"sudo touch /etc/issue"
        leca $"sudo chmod 755 /etc/issue"
        leca $"sudo sh -c \">| /etc/issue\""
        leca $"sudo sh -c \"echo \"\" >> /etc/issue\""
        leca $"sudo sh -c \"echo \"Unauthorized access to this 
            system is forbidden and will be\" >> /etc/issue\""
        leca $"sudo sh -c \"echo \"prosecuted by law. By accessing
            this system, you agree that your\" >> /etc/issue\""
        leca $"sudo sh -c \"echo \"actions may be monitored if 
            unauthorized usage is suspected.\" >> /etc/issue\""
        leca $"sudo sh -c \"echo \"\" >> /etc/issue\""
        pca $success $'Warnings added to /etc/issue'
    fi

    # Add legal banner to /etc/issue.net
    if [ -f /etc/issue.net ]; then
        pca $action $'Adding legal warnings to /etc/issue.net'
        leca $"sudo touch /etc/issue.net"
        leca $"sudo chmod 755 /etc/issue.net"
        leca $"sudo sh -c \"> /etc/issue.net\""
        leca $"sudo sh -c \"echo \"\" >> /etc/issue.net\""
        leca $"sudo sh -c \"echo \"Unauthorized access to this 
            system is prohibited and will be prosecuted by law.\" 
            >> /etc/issue.net\""
        leca $"sudo sh -c \"echo \"By accessing this system, you agree
            to the Terms and Conditions of Use.\" >> /etc/issue.net\""
        leca $"sudo sh -c \"echo \"All activities performed on this
            system may be monitored and recorded.\" >> /etc/issue.net\""
        leca $"sudo sh -c \"echo \"If you do not agree to these 
            terms, please disconnect now.\" >> /etc/issue.net\""
        leca $"sudo sh -c \"echo \"\" >> /etc/issue.net\""
        pca $success $'Warnings added to /etc/issue.net'
    fi

    pca $end $'Legal warnings added!'
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
    #sleep 0.2
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
# SYSLCTL CONFIG HELPER
#===========================================================================
#
# Description:
#   Helps with sysctl config files
#
# Arguments:
#   $1 - option - sysctl option
#   $2 - value - sysctl value
#   $3 - file - sysctl config file
#   $4 - spacing - space between option and value
#===========================================================================
#endregion
function sysctl_config_helper() {

    option="$1"
    value="$2"
    file="$3"
    spacing="$4"

    if ! [[ -f "$file" ]]; then
        echo "Error: File not found!"
        return 1
    fi

    # Check if option is commented out
    is_commented=$(grep -E "^\s*#\s*${option}\s" "$file")
    if [[ -n "$is_commented" ]]; then
        # Replace commented option with uncommented option
        leca $"sed -i 
        \"s/^\s*#\s*${option}\s.*/${option}${spacing}${value}/\" \"$file\""
    fi

    # check if there is an entry in the sshd_config file
    pca $check $"Checking if there is an entry for $option in $file..."
    if sudo grep -q "^$option" $file; then
        # if the entry is correct, continue to next entry
        pca $positive $"$option found in $file..."
        pca $check $"Checking if $option is correct..."
        if sudo grep -q "^$option$spacing$value" $file; then
            pca $positive $"$option is correct..."
        else
            # if the entry is incorrect, update entry
            pca $negative $"$option is incorrect..."
            pca $action $"Updating $option..."
            leca $"sudo sed -i 
            \"s/^\s*${option}\s.*/${option}${spacing}${value}/\" \"$file\""
            if [ $? -eq 0 ]; then
                pca $success $"$option updated..."
            else
                pca $failure $"Failed to update $option..."
            fi
        fi
    else
        # if the entry doesn't exist, add the entry with the correct value
        pca $negative $"$option not found in $file..."
        pca $action $"Adding $option with correct value..."
        leca $"sudo echo \"$option$spacing$value\" >> $file"
        if [ $? -eq 0 ]; then
            pca $success $"$option$spacing$value added..."
        else
            pca $failure $"Failed to add $option$spacing$value"
        fi
    fi
}

#region
#===========================================================================
# DUPLICATE CHECK HELPER
#===========================================================================
#
# Description:
#   Checks for duplicate entries in a file
#
# Arguments:
#   $file - The file to check for duplicates
#===========================================================================
#endregion
function duplicate_check_helper() {
    file="$1"

    pca $check $"Checking for duplicate entries in $file"
    sudo awk 'NF && $1!~/^(#|HostKey)/{print $1}' $file |
        sort | uniq -c | grep -v ' 1 ' | while read line; do
        key=$(echo $line | awk '{$1=$1;print}' | tr -d ' ')
        pca $action $"Removing duplicate $key"
        # leca $"sudo sed -i \"\/$key\/,1!d\" $file"
        leca $"sudo sed -i '/$key/,1!d' '$file'"
        # leca $"sudo sed -i \"/$key/,1!d\" \"$file\""
    done

    if [ $? -eq 0 ]; then
        pca $success $"Successfully removed duplicates from $file"
    else
        pca $failure $"Failed to remove duplicates from $file"
    fi
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

#region
#===========================================================================
# CHECK AND ADD RULE TO UFW
#===========================================================================
#
# Description:
#   Takes three inputs, checks if the first is
#   deny/allow/reject, checks if the second is a port, and checks if the
#   third is a protocol,  then checks to see if this rule already exists
#   in the ufw chain, and if not, adds to the ruleset
#
# Arguments:
#   $1 - Deny/Allow/Reject
#   $2 - Port
#   $3 - Protocol
#===========================================================================
#endregion
function add_rule_to_ufw() {

    # Check if the rule already exists in the ufw chain
    pca $check $"Checking if rule $1 $2 $3 already exists in the ufw chain"
    if [[ $(sudo ufw status numbered | sudo grep "$1 $2/$3") ]]; then
        pca $positive $'Rule already exists in the ufw chain'
    else
        pca $neutral $'Rule does not exist in the
            ufw chain, adding rule to ufw chain'
        leca $"sudo ufw $1 $2/$3"
        if [[ $? -eq 0 ]]; then
            pca $success $'Rule added to ufw chain successfully'
        else
            pca $failure $'Failed to add rule to ufw chain'
            return 1
        fi
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
developer_banner
setup_environment
check_distro
begin_log
update_ubuntu
set_motd
# preferences
#  ___________
# |           |
# |  PACKAGES |
# |___________|
#        \   ^__^
#         \  (oo)\_______
#            (__)\       )\/\
#                ||----w |
#                ||     ||
install_system_packages
install_services
install_rootkit_checkers
install_unofficial_packages
#  ___________
# |           |
# | HARDENING |
# |___________|
#        \   (\__/)
#         \  (•ㅅ•)
#            / 　 づ
#            \  ノ
set_firewall_ufw
# harden_compilers
# harden_kernel
# harden_ip4
harden_ssh
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
