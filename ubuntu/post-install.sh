#!/bin/bash

# Author: James Ussery <James@Ussery.me>
# Date Created: 20210217
# Date Updated: 20210219


dlpath="~/Downloads"
cd $dlpath
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.desktop.screensaver lock-enabled false
echo "Upgrade system"
sudo apt -y upgrade
sudo apt -y install python
sudo apt -y install snapd
sudo systemctl start snapd
sudo systemctl enable snapd

echo "== REPOS =="
sudo add-apt-repository -y universe
sudo add-apt-repository -y multiverse
sudo apt config-manager -y --add-repo=http://negativo17.org/repos/fedora-spotify.repo
sudo apt -y update

echo "== MEDIA =="
sudo apt -y install vlc
sudo apt -y install clementine
sudo apt -y install gstreamer1
sudo apt -y install gstreamer1-plugins-bad-free
sudo apt -y install gstreamer1-plugins-bad-free-gtk
sudo apt -y install gstreamer1-plugins-base
sudo apt -y install gstreamer1-plugins-good
sudo apt -y install gstreamer1-plugins-ugly
sudo apt -y install gstreamer1-plugins-ugly-free
sudo apt -y install kodi
sudo apt -y install youtube-dl

# Spotify
sudo apt config-manager --add-repo=http://negativo17.org/repos/fedora-spotify.repo
sudo apt -y install spotify-client

# Signal Desktop
curl -s https://updates.signal.org/desktop/sudo apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/sudo apt xenial main" | sudo tee -a /etc/sudo apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt -y install signal-desktop

echo "== BROWSERS =="
echo "Vivaldi"
vivaldi="$dlpath/vivaldi.deb"
wget -O $vivaldi https://downloads.vivaldi.com/stable/vivaldi-stable_3.6.2165.36-1_amd64.deb
dpkg -i $vivaldi

echo "== PRODUCTIVITY =="
sudo apt -y install focuswriter
sudo apt -y install thunderbird
sudo apt -y install libreoffice

echo "== GRAPHICS =="
# sudo apt -y install inkscape
sudo apt -y install digikam
sudo apt -y install krita

echo "== SECURITY =="

# Hamachi
echo "Checking for Hamachi..."
echo "=="
hamachi="$dlpath/hamachi.deb"
if [ -f "$hamachi" ]
then
	echo "$hamachi found. Skipping Download."
else
	echo "$hamachi not found."
  echo "== Downloading Hamachi =="
	wget -O hamachi.deb https://vpn.net/installers/logmein-hamachi_2.1.0.198-1_amd64.deb
fi
echo "=="
sudo apt -y install $hamachi
echo "=="

# Haguichi (Hamachi gui)
add-sudo apt-repository -y ppa:webupd8team/haguichi
sudo apt update
sudo apt -y install haguichi

echo "== UTILITIES =="
sudo apt -y install exfat-utils fuse-exfat fuse
sudo apt -y install guake
sudo apt -y install gnome-disk-utility
sudo apt -y install gnome-tweak-tool
sudo apt -y install krename
sudo apt -y install remmina
sudo apt -y install nextcloud-desktop
sudo apt -y install solaar
sudo apt -y install speedtest-cli
sudo apt -y install rsync
sudo apt -y install unrar
sudo apt -y install unzip
sudo apt -y install wget
sudo apt -y install htop
sudo apt -y install ffmpeg
sudo apt -y install jpegoptim
sudo apt -y install jhead

echo "=== SECURITY ==="

echo "== Bitwarden =="
sudo snap install bitwarden

echo "== SPEEDIFY =="
wget -qO- https://get.speedify.com | sudo -E bash -

# S3 Tools
# sudo apt -y install s3cmd

# DragonDisk
# wget http://download.dragondisk.com/dragondisk_1.0.5-0ubuntu_amd64.deb
# sudo apt-get install libqt4-dbus libqt4-network libqt4-xml libqtcore4 libqtgui4
# dpkg -i dragondisk_1.0.5-0ubuntu_amd64.deb

# NoMachine
sudo apt -y install nomachine


echo "== DEVELOPMENT =="
sudo apt -y install kernel-devel kernel-headers

sudo apt -y install filezilla
sudo apt -y install git
# vscode could be run from snap, but could everthing else as well?

# == Database ==
# = MYSQL =
sudo apt -y install mariadb-server
systemctl enable mariadb
systemctl start mariadb
# = MYSQL Client =
wget https://dev.mysql.com/get/mysql-sudo apt-config_0.8.13-1_all.deb
dpkg -i mysql-sudo apt-config_0.8.13-1_all.deb
sudo apt-get update
sudo apt-get install mysql-workbench-community
sudo apt-get install libmysqlclient18

# = MongoDB =
# sudo apt -y install mongodb mongodb-server
# service mongod start

# = Node.js =
sudo apt -y install nodejs npm

# = WebServices =
# NGINX web server
sudo apt -y install nginx
sudo apt -y install php
sudo apt -y install php-fpm

systemctl enable nginx
systemctl start nginx

# VirtualBox
sudo apt -y install virtualbox
sudo apt -y install virtualbox-dkms
sudo apt -y install virtualbox-ext-pack
sudo apt -y install virtualbox-guest-additions-iso

echo "== SETTINGS =="
# Add global git values
git config --global user.name "First Last"
git config --global user.email "your@email.com"

# Secure mariadb
mysql_secure_installation

echo "=== Desktop Environments ==="
# echo "== Budgie Desktop - Origin: Solus OS =="
# sudo apt -y update && sudo apt upgrade
# sudo apt -y install ubuntu-budgie-desktop

# echo "== KDE =="
# sudo apt -y install kde-full

# echo "== Pantheon - Origin: Elementary =="
# sudo add-apt-repository -y ppa:elementary-os/daily
# sudo add-apt-repository -y ppa:elementary-os/os-patches
# sudo add-apt-repository -y ppa:elementary-os/testing
# sudo add-apt-repository -y ppa:mpstark/elementary-tweaks-daily
# sudo apt update
# sudo apt -y install elementary-theme elementary-icon-theme elementary-default-settings elementary-desktop elementary-tweaks

# echo "== LXQT =="
# sudo apt -y install lxqt sddm

# echo "== Deepin - Origin: Deepin Linux =="
# sudo add-apt-repository -y ppa:ubuntudde-dev/stable
# sudo apt -y install ubuntudde-dde
# sudo dpkg-reconfigure lightdm

echo "== CINNAMON DESKTOP=="
sudo apt -y install cinnamon

sudo apt upgrade -y
reboot