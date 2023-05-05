!_master_fresh_install.ps1iwr -useb https://christitus.com/win | iex | Out-Null

###############
# Development #
###############
choco install python -y #Python is a popular programming language that is used to create a wide range of applications.
choco install putty -y #Putty is a free, open source SSH client used to remotely connect to a server.
choco install winscp -y #WinSCP is a free file transfer tool used to securely move files between a local and remote computer.
choco install notepadplusplus -y #Notepad++ is a text editor used for coding and web development.
choco install git -y #Git is a version control system used for tracking changes in source code during development.
choco install github-desktop -y #GitHub Desktop is a program used to connect to GitHub repositories and manage them.
choco install dotnet-runtime -y #The .NET Runtime is a library used to run applications written in the .NET Framework.
choco install microsoft-windows-terminal -y #The Windows Terminal is a command line interface used to run various programs and commands.
choco install autohotkey -y #AutoHotKey is a scripting language used to automate tasks and create macros.
choco install vcredist140 -y #The VCRedist140 is a redistributable package used to install the Visual C++ libraries.
choco install vscodium -y #VSCodium is a free and open-source text editor similar to Visual Studio Code.
choco install notesnook -y #Notesnook is a note-taking application used to capture ideas, notes, and tasks.

##########
# Gaming #
##########
choco install steam -y #Steam is a digital distribution platform used to purchase and download video games.
choco install epicgameslauncher -y #The Epic Games Launcher is a program used to download and manage Epic Games titles.

###########
# Utility #
###########
choco install thunderbird -y #Thunderbird is an email client used to manage and send emails.
choco install sumatrapdf -y #SumatraPDF is a free and open-source PDF viewer used to open and read PDFs.
choco install libreoffice-still -y #LibreOffice is a free and open-source office suite used for word processing, spreadsheets, presentations and more.
choco install windirstat -y #WinDirStat is a disk usage analyzer used to view the size of files on a hard drive.
choco install wiztree -y #WizTree is a file search tool used to quickly scan a hard drive and find files.
choco install 7zip -y #7-Zip is a file compression utility used to create and extract archives in various formats.
choco install revo-uninstaller -y #Revo Uninstaller is a program used to completely uninstall applications.
choco install hwinfo -y #HWiNFO is a system information tool used to view hardware components and their performance.
choco install sdio -y #SDI-O is a disk imaging tool used to create and restore disk images.
choco install ddu -y #Display Driver Uninstaller (DDU) is a tool used to completely uninstall graphics card drivers.
choco install rufus -y #Rufus is a bootable USB creator used to create bootable Windows or Linux USB drives.
choco install qbittorrent -y #qBittorrent is a cross-platform BitTorrent client used to download and share files.
choco install f.lux -y #f.lux is a screen dimming application used to adjust the color temperature of a display.
choco install librefox-firefox -y #Librefox (Firefox) is a web browser used to access the internet.
choco install launchy -y #Launchy is a program launcher used to quickly open applications.
choco install winaero-tweaker -y #Winaero Tweaker is a utility used to customize the Windows user interface.
choco install smartty3 -y #Smartty3 is a command line tool used to manage Windows processes.
choco install putty -y #Putty is a free, open source SSH client used to remotely connect to a server.
choco install nextcloud-client -y #The Nextcloud Client is a program used to sync files between a local and remote computer.

##############
# Multimedia #
##############
choco install amazon-music -y #Amazon Music is a music streaming service and digital music store.
choco install spotify -y #Spotify is a digital music streaming service used to listen to and discover music.
choco install vlc -y #VLC Media Player is a free and open-source media player used to play digital media files.
choco install k-litecodecpackfull -y #K-Lite Codec Pack is a collection of audio and video codecs used to play various media formats.

############
# Security #
############
choco install protonvpn -y #ProtonVPN is a virtual private network (VPN) service used to secure internet connections.
choco install protonmailbridge -y #ProtonMail Bridge is an application used to securely access ProtonMail accounts.
choco install yubico-authenticator -y #Yubico Authenticator is a two-factor authentication app used to add an extra layer of security.
choco install cryptomator -y #Cryptomator is an encryption tool used to secure files stored in the cloud.
choco install veracrypt -y #VeraCrypt is a disk encryption tool used to protect files and folders.
choco install malwarebytes -y #Malwarebytes is an anti-malware program used to detect and remove malicious software.

##########
# Social #
##########
choco install discord -y #Discord is a voice and text chat platform used to communicate with others.
choco install signal -y #Signal is a secure messaging application used to send text messages, voice calls and video calls.

################
# Productivity #
################
#ColdTurkey is an application that stops certain applications at certain times.
Start-BitsTransfer -Source "https://getcoldturkey.com/files/Cold_Turkey_Installer.exe" -Destination "C:\Temp\Cold_Turkey_Installer.exe" -Asynchronous; Wait-Job; Start-Process -FilePath "C:\Temp\Cold_Turkey_Installer.exe" -Wait; Read-Host -Prompt "Press any key to continue..."
