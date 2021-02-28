#!/bin/sh

# Author: James Ussery <James@Ussery.me>
# Date Created: 20180314
# Date Updated: 20210227
# Description: Solus Budgie Post install.
# As always, read through each item use the hash symbol "#" to stop a package from installing.
# I've used individual eopkg entries because I've found in the past apps get skipped if there's an error.
#
# References: 
#
# Solus Third Party page: https://getsol.us/articles/software/third-party/en/
#-------------------------------------------------------------------------------------

dlpath="~/Downloads/"
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.desktop.screensaver lock-enabled false

sudo eopkg -y install snapd
sudo systemctl start snapd
sudo systemctl enable snapd
sudo snap install core
sudo systemctl restart snapd
sudo apparmor_parser -r /var/lib/snapd/apparmor/profiles/
sudo usysconf run apparmor -f

echo "Remove programs I don't like"
sudo eopkg -y remove amarok dragon

echo "Upgrade system"
sudo eopkg -y upgrade

echo "== GAMING =="
# sudo eopkg -y install steam
sudo eopkg -y install minetest
sudo eopkg -y install supertuxkart
sudo snap install mc-installer

echo "== MEDIA =="
sudo eopkg -y install vlc
sudo eopkg -y install kodi
sudo eopkg -y install youtube-dl

echo "== CHAT =="
# sudo eopkg -y install discord
sudo eopkg -y install discord
sudo eopkg -y install signal-desktop

echo "== BROWSERS =="
# VIVALDI
sudo eopkg -y install vivaldi-stable

echo "== PRODUCTIVITY =="
sudo eopkg -y install focuswriter
sudo snap install typora

echo "== UTILITIES =="
sudo eopkg -y install guake
sudo eopkg -y install krename
sudo eopkg -y install remmina
sudo eopkg -y install solaar
sudo eopkg -y install speedtest-cli
sudo eopkg -y install rsync
sudo eopkg -y install unrar
sudo eopkg -y install unzip
sudo eopkg -y install wget
sudo eopkg -y install htop
sudo eopkg -y install vim
sudo eopkg -y install curl
sudo eopkg -y install fish
sudo eopkg -y install nextcloud-client

echo "== DEVELOPMENT =="
sudo eopkg -y install filezilla
sudo eopkg -y install git
sudo eopkg -y install vscode

echo "== Database =="
# = MYSQL =
sudo eopkg -y install mariadb mariadb-server
sudo systemctl enable mariadb
sudo systemctl start mariadb
sudo snap install mysql-workbench-community

# Secure mariadb
mysql_secure_installation

# = MongoDB =
# sudo eopkg -y install mongodb mongodb-tools
# sudo systemctl start mongod

# = Node.js =
sudo eopkg -y install nodejs

# = Apache (httpd+php) =
sudo eopkg -y install nginx
sudo eopkg -y install php
sudo systemctl enable nginx
sudo systemctl start nginx
sudo mkdir -p /etc/nginx/conf.d/
# cd /etc/nginx/conf.d
# sudo ln -s ~/websrv/nginx/conf/my.conf
groupadd webdev
useradd -g webdev $USER
useradd -g webdev nginx
useradd -g webdev www-data

sudo eopkg -y install pip
pip install --upgrade pip

# sudo eopkg -y install virtualbox
# sudo eopkg -y install virtualbox-common
# sudo eopkg -y install virtualbox-current

echo "== THIRD PARTY SOFTWARE =="

# SPOTIFY
sudo eopkg bi --ignore-safety https://raw.githubusercontent.com/getsolus/3rd-party/master/multimedia/music/spotify/pspec.xml
sudo eopkg it spotify*.eopkg;sudo rm spotify*.eopkg

# SKYPE
sudo eopkg bi --ignore-safety https://raw.githubusercontent.com/getsolus/3rd-party/master/network/im/skype/pspec.xml
sudo eopkg it skype*.eopkg;sudo rm *.eopkg

# SLACK
sudo eopkg bi --ignore-safety https://raw.githubusercontent.com/getsolus/3rd-party/master/network/im/slack-desktop/pspec.xml
sudo eopkg it slack-desktop*.eopkg;sudo rm slack-desktop*.eopkg

# TEAMVIEWER
sudo eopkg bi --ignore-safety https://raw.githubusercontent.com/getsolus/3rd-party/master/network/util/teamviewer/pspec.xml
sudo eopkg it teamviewer*.eopkg;sudo rm teamviewer*.eopkg
sudo systemctl start teamviewerd.service

# MICROSOFT CORE FONTS
sudo eopkg bi --ignore-safety https://raw.githubusercontent.com/getsolus/3rd-party/master/desktop/font/mscorefonts/pspec.xml
sudo eopkg it mscorefonts*.eopkg;sudo rm mscorefonts*.eopkg

echo "== SETTINGS =="
# Add global git values
git config --global user.name "First Last"
git config --global user.email "email@domain.com"


sudo eopkg upgrade -y
sudo eopkg clean packages -y

#REBOOT
shutdown now -r

