#!/bin/sh

# Author: James Ussery <James@Ussery.me>
# Date Created: 20180314
# Description: Solus Budgie Post install.
# As always, read through each item use the hash symbol "#" to stop a package from installing.
# I've used individual eopkg entries because I've found in the past apps get skipped if there's an error.
#
# References: 
#
# Solus Third Party page: https://solus-project.com/articles/software/third-party/en/
#-------------------------------------------------------------------------------------

dlpath="~/Downloads/"

echo "Remove programs I don't like"
eopkg -y remove amarok dragon

echo "Upgrade system"
eopkg -y upgrade

echo "== GAMING =="
# eopkg -y install steam

echo "== MEDIA =="
eopkg -y install vlc
eopkg -y install kodi
eopkg -y install youtube-dl
eopkg -y install youtube-dl-gui

# SPOTIFY
eopkg bi --ignore-safety https://raw.githubusercontent.com/solus-project/3rd-party/master/multimedia/music/spotify/pspec.xml
eopkg it spotify*.eopkg;rm spotify*.eopkg

echo "== CHAT =="
eopkg -y install pidgin
eopkg -y install signal-desktop

# SKYPE
eopkg bi --ignore-safety https://raw.githubusercontent.com/solus-project/3rd-party/master/network/im/skype/pspec.xml
eopkg it skype*.eopkg;rm *.eopkg

# SLACK
eopkg bi --ignore-safety https://raw.githubusercontent.com/solus-project/3rd-party/master/network/im/slack-desktop/pspec.xml
eopkg it slack-desktop*.eopkg;rm slack-desktop*.eopkg

echo "== BROWSERS =="
# CHROME
eopkg bi --ignore-safety https://raw.githubusercontent.com/solus-project/3rd-party/master/network/web/browser/google-chrome-stable/pspec.xml
eopkg it google-chrome-*.eopkg;rm google-chrome-*.eopkg

# VIVALDI
eopkg -y install vivaldi-stable
# VIVALDI FLASH
eopkg bi --ignore-safety https://raw.githubusercontent.com/solus-project/3rd-party/master/multimedia/video/flash-player-ppapi/pspec.xml
eopkg it flash-player-ppapi*.eopkg;rm flash-player-ppapi*.eopkg

echo "== PRODUCTIVITY =="
eopkg -y install rednotebook
eopkg -y install focuswriter
eopkg -y install thunderbird
eopkg -y install libreoffice

# WPS OFFICE
# Linux replica of MS Office
eopkg bi --ignore-safety https://raw.githubusercontent.com/solus-project/3rd-party/master/office/wps-office/pspec.xml
eopkg it wps-office*.eopkg;rm wps-office*.eopkg

echo "== GRAPHICS =="
eopkg -y install shotwell
eopkg -y install rawstudio
eopkg -y install gimp

echo "== SECURITY =="
eopkg -y install keepass
eopkg -y install tor
systemctl enable tor
systemctl start tor

echo "== UTILITIES =="
eopkg -y install guake
eopkg -y install gnome-disk-utility
eopkg -y install gnome-tweak-tool
eopkg -y install krename
eopkg -y install remmina
eopkg -y install owncloud-client
eopkg -y install solaar
eopkg -y install speedtest-cli
eopkg -y install rsync
eopkg -y install s3cmd
eopkg -y install unrar
eopkg -y install unzip
eopkg -y install wget
eopkg -y install htop

echo "== DEVELOPMENT =="
eopkg -y install filezilla
eopkg -y install subversion
eopkg -y install git
eopkg -y install atom
eopkg -y install vscode

# GITKRAKEN
eopkg bi --ignore-safety https://raw.githubusercontent.com/solus-project/3rd-party/master/programming/gitkraken/pspec.xml
eopkg it gitkraken*.eopkg;rm gitkraken*.eopkg

echo "== Database =="
# = MYSQL =
eopkg -y install mariadb mariadb-server
systemctl enable mariadb
systemctl start mariadb
eopkg -y install dbeaver

# Secure mariadb
mysql_secure_installation

# = MongoDB =
eopkg -y install mongodb mongodb-tools
systemctl start mongod

# = Node.js =
eopkg -y install nodejs npm

# = Apache (httpd+php) =
eopkg -y install httpd
eopkg -y install php
eopkg -y install php-mysqlnd
eopkg -y install php-opcache
eopkg -y install php-pecl-apcu
eopkg -y install php-cli
eopkg -y install php-pear
eopkg -y install php-pdo
eopkg -y install php-mysqlnd
eopkg -y install php-pgsql
eopkg -y install php-pecl-mongodb
eopkg -y install php-pecl-memcache
eopkg -y install php-pecl-memcached
eopkg -y install php-gd
eopkg -y install php-mbstring
eopkg -y install php-mcrypt
eopkg -y install php-xml
systemctl enable httpd
systemctl start httpd

eopkg -y install pip
pip install --upgrade pip

eopkg -y install virtualbox
eopkg -y install virtualbox-common
eopkg -y install virtualbox-current


echo "== SETTINGS =="
# Add global git values
git config --global user.name "First Last"
git config --global user.email "your@email.com"

# Autostart utilities
cp autostart/guake.desktop ~/.config/autostart
cp autostart/ownCloud.desktop ~/.config/autostart


eopkg upgrade -y
eopkg clean packages -y

#REBOOT
shutdown now -r
