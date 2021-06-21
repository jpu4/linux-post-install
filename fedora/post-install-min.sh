#!/bin/bash

# Author: James Ussery <James@Ussery.me>
# Date Created: 20171110
# Date Updated: 20210217
# Description: Fedora Post install (should work for future versions as well).
# As always, read through each item use the hash symbol "#" to stop a package from installing.
# I've used individual sudo dnf entries because I've found in the past apps get skipped if there's an error.
#-------------------------------------------------------------------------------------
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.desktop.screensaver lock-enabled false
dlpath="~/Downloads"
cd $dlpath

echo "Remove programs I don't like"
sudo dnf -y remove amarok dragon

echo "Upgrade system"
sudo dnf -y upgrade
sudo dnf -y install python

echo "== REPOS =="
sudo dnf -y install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

echo "== Package Installers =="

echo "=== Snap ==="
sudo dnf -y install snapd
sudo systemctl enable snapd
sudo systemctl start snapd

echo "=== Flatpak ==="
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "=== PIP ==="
sudo pip install --upgrade pip

echo "== TeamViewer =="
sudo dnf -y install https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm

echo "== MEDIA =="
echo "=== Spotify ==="
wget https://dl.flathub.org/repo/appstream/com.spotify.Client.flatpakref
flatpak install flathub com.spotify.Client

sudo dnf -y install vlc
sudo dnf -y install clementine
sudo dnf -y install gstreamer1
sudo dnf -y install gstreamer1-plugins-bad-free
sudo dnf -y install gstreamer1-plugins-bad-free-gtk
sudo dnf -y install gstreamer1-plugins-base
sudo dnf -y install gstreamer1-plugins-good
sudo dnf -y install gstreamer1-plugins-ugly
sudo dnf -y install gstreamer1-plugins-ugly-free
sudo dnf -y install kodi
sudo dnf -y install youtube-dl

echo "== CHAT =="
sudo curl -o /etc/yum.repos.d/skype-stable.repo https://repo.skype.com/rpm/stable/skype-stable.repo
sudo dnf -y install skypeforlinux

echo "=== Signal Desktop for Fedora ==="
# https://copr.fedorainfracloud.org/coprs/luminoso/Signal-Desktop/
sudo dnf copr enable luminoso/Signal-Desktop -y
sudo dnf install -y signal-desktop

echo "=== Discord ==="
wget https://dl.flathub.org/repo/appstream/com.discordapp.Discord.flatpakref
flatpak install flathub com.discordapp.Discord


echo "== BROWSERS =="
echo "=== Vivaldi Browser ==="
sudo dnf -y install https://downloads.vivaldi.com/stable/vivaldi-stable-3.6.2165.36-1.x86_64.rpm

echo "== PRODUCTIVITY =="
sudo dnf -y install focuswriter
sudo dnf -y install thunderbird
sudo dnf -y install libreoffice
sudo dnf -y install hamster-time-tracker
echo "=== Typora ==="
# https://github.com/RPM-Outpost/typora
git clone https://github.com/RPM-Outpost/typora.git
cd typora
./create-package.sh x64

echo "== GRAPHICS =="
sudo dnf -y install digikam
sudo dnf -y install krita

echo "== UTILITIES =="
sudo dnf -y install exfat-utils fuse-exfat fuse
sudo dnf -y install guake
sudo dnf -y install gnome-disk-utility
sudo dnf -y install gnome-tweak-tool
sudo dnf -y install krename
sudo dnf -y install remmina
sudo dnf -y install nextcloud-client
sudo dnf -y install solaar
sudo dnf -y install speedtest-cli
sudo dnf -y install rsync
sudo dnf -y install unrar
sudo dnf -y install unzip
sudo dnf -y install wget
sudo dnf -y install htop
sudo dnf -y install ffmpeg
sudo dnf -y install jpegoptim
sudo dnf -y install jhead
sudo dnf -y install ark
sudo dnf -y install fish
sudo dnf -y install ksnip
sudo dnf -y install filezilla

echo "== Security =="
echo "=== Bitwarden ==="
sudo snap install bitwarden

# anydesk
cat > /etc/yum.repos.d/AnyDesk-Fedora.repo << "EOF" 
[anydesk]
name=AnyDesk Fedora - stable
baseurl=http://rpm.anydesk.com/fedora/$basearch/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY
EOF
sudo dnf install -y http://springdale.princeton.edu/data/springdale/7/x86_64/os/Addons/Packages/pangox-compat-0.0.2-2.sdl7.x86_64.rpm
sudo dnf install -y anydesk

sudo dnf upgrade -y
sudo dnf clean packages -y
reboot
