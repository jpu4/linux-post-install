#!/bin/sh

# Author: James Ussery <James@Ussery.me>
# Date Created: 20180314
# Date Updated: 20200830
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
echo "Remove programs I don't like"
sudo eopkg -y remove amarok dragon

echo "Upgrade system"
sudo eopkg -y upgrade

echo "== GAMING =="
# sudo eopkg -y install steam

echo "== MEDIA =="
sudo eopkg -y install vlc
sudo eopkg -y install kodi
sudo eopkg -y install youtube-dl
sudo eopkg -y install youtube-dl-gui

echo "== CHAT =="
sudo eopkg -y install discord
sudo eopkg -y install signal-desktop

echo "== BROWSERS =="
# VIVALDI
sudo eopkg -y install vivaldi-stable

echo "== PRODUCTIVITY =="
sudo eopkg -y install focuswriter
sudo eopkg -y install thunderbird
sudo eopkg -y install libreoffice

echo "== UTILITIES =="
sudo eopkg -y install guake
sudo eopkg -y install gnome-disk-utility
sudo eopkg -y install gnome-tweak-tool
sudo eopkg -y install krename
sudo eopkg -y install remmina
sudo eopkg -y install solaar
sudo eopkg -y install speedtest-cli
sudo eopkg -y install rsync
sudo eopkg -y install s3cmd
sudo eopkg -y install unrar
sudo eopkg -y install unzip
sudo eopkg -y install wget
sudo eopkg -y install htop

echo "== DEVELOPMENT =="
sudo eopkg -y install filezilla
sudo eopkg -y install git
sudo eopkg -y install vscode

echo "== Database =="
# = MYSQL =
sudo eopkg -y install mariadb mariadb-server
systemctl enable mariadb
systemctl start mariadb
sudo eopkg -y install dbeaver

# Secure mariadb
mysql_secure_installation

# = MongoDB =
sudo eopkg -y install mongodb mongodb-tools
systemctl start mongod

# = Node.js =
sudo eopkg -y install nodejs npm

# = Apache (httpd+php) =
sudo eopkg -y install nginx
sudo eopkg -y install php
sudo eopkg -y install php-mysqlnd
sudo eopkg -y install php-opcache
sudo eopkg -y install php-pecl-apcu
sudo eopkg -y install php-cli
sudo eopkg -y install php-pear
sudo eopkg -y install php-pdo
sudo eopkg -y install php-mysqlnd
sudo eopkg -y install php-pgsql
sudo eopkg -y install php-pecl-mongodb
sudo eopkg -y install php-pecl-memcache
sudo eopkg -y install php-pecl-memcached
sudo eopkg -y install php-gd
sudo eopkg -y install php-mbstring
sudo eopkg -y install php-mcrypt
sudo eopkg -y install php-xml
systemctl enable nginx
systemctl start nginx

sudo eopkg -y install pip
pip install --upgrade pip

sudo eopkg -y install virtualbox
sudo eopkg -y install virtualbox-common
sudo eopkg -y install virtualbox-current


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

# CHROME
sudo eopkg bi --ignore-safety https://raw.githubusercontent.com/getsolus/3rd-party/master/network/web/browser/google-chrome-stable/pspec.xml
sudo eopkg it google-chrome-*.eopkg;sudo rm google-chrome-*.eopkg

# GOOGLE TALK
sudo eopkg bi --ignore-safety https://raw.githubusercontent.com/getsolus/3rd-party/master/network/im/google-talkplugin/pspec.xml
sudo eopkg it google-talkplugin*.eopkg;sudo rm google-talkplugin*.eopkg

# VIVALDI FLASH
sudo eopkg bi --ignore-safety https://raw.githubusercontent.com/solus-project/3rd-party/master/multimedia/video/flash-player-ppapi/pspec.xml
sudo eopkg it flash-player-ppapi*. eopkg;rm flash-player-ppapi*. eopkg

# TEAMVIEWER
sudo eopkg bi --ignore-safety https://raw.githubusercontent.com/getsolus/3rd-party/master/network/util/teamviewer/pspec.xml
sudo eopkg it teamviewer*.eopkg;sudo rm teamviewer*.eopkg
sudo systemctl start teamviewerd.service

# MICROSOFT CORE FONTS
sudo eopkg bi --ignore-safety https://raw.githubusercontent.com/getsolus/3rd-party/master/desktop/font/mscorefonts/pspec.xml
sudo eopkg it mscorefonts*.eopkg;sudo rm mscorefonts*.eopkg

# GITKRAKEN
sudo eopkg bi --ignore-safety https://raw.githubusercontent.com/getsolus/3rd-party/master/programming/gitkraken/pspec.xml
sudo eopkg it gitkraken*.eopkg;sudo rm gitkraken*.eopkg


echo "== SETTINGS =="
# Add global git values
git config --global user.name "James Ussery"
git config --global user.email "james@ussery.me"


sudo eopkg upgrade -y
sudo eopkg clean packages -y

#REBOOT
shutdown now -r

