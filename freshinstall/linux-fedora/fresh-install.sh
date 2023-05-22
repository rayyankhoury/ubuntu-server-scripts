
sudo dnf update

# Installs Librewolf
sudo dnf config-manager --add-repo https://rpm.librewolf.net/librewolf-repo.repo
sudo dnf install librewolf
sudo dnf remove firefox
