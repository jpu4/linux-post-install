#!/bin/sh

# Author: James Ussery <James@JPU4.com>
# Date Created: 20171110
# Description: Fedora Post install (Should work for future versions as well).
# I've used individual dnf entries because I've found in the past apps get skipped if there's an error.
#-------------------------------------------------------------------------------------

dlpath="~/Downloads/"

echo "Start SSHD service"
systemctl enable sshd
systemctl start sshd

dnf install -y exfat-utils fuse-exfat fuse
echo "Remove programs I don't like"
dnf -y remove amarok dragon

echo "Upgrade system"
dnf -y upgrade

echo "== REPOS =="
dnf -y install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf -y install http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

## Remi Dependency on Fedora 26 / 25 / 24 ##
rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm
rpm -Uvh http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-stable.noarch.rpm

## Fedora 26 ##
rpm -Uvh http://rpms.famillecollet.com/fedora/remi-release-$(rpm -E %fedora).rpm

echo "== MEDIA =="
dnf -y install vlc
dnf -y install clementine
dnf -y install gstreamer1
dnf -y install gstreamer1-plugins-bad-free
dnf -y install gstreamer1-plugins-bad-free-gtk
dnf -y install gstreamer1-plugins-base
dnf -y install gstreamer1-plugins-good
dnf -y install gstreamer1-plugins-ugly
dnf -y install gstreamer1-plugins-ugly-free
dnf -y install kodi
dnf -y install youtube-dl
dnf -y install azureus

sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-spotify.repo
dnf -y install spotify-client


echo "== CHAT =="
dnf -y install skypeforlinux.x86_64
dnf -y install pidgin
echo "=="
echo "Checking for Slack..."
echo "=="
slack="$dlpath/slack.rpm"
if [ -f "$slack" ]
then
	echo "$slack found. Skipping Download."
else
	echo "$slack not found."
  echo "== Downloading Slack =="
 wget -O $slack https://downloads.slack-edge.com/linux_releases/slack-2.8.2-0.1.fc21.x86_64.rpm
fi
echo "=="
dnf -y install $slack
echo "=="

echo "== BROWSERS =="
dnf -y install lynx
dnf -y install google-chrome-stable

echo "=="
echo "Checking for Vivaldi Browser..."
echo "=="
vivaldi="$dlpath/vivaldi.rpm"
if [ -f "$vivaldi" ]
then
	echo "$vivaldi found. Skipping Download."
else
	echo "$vivaldi not found."
  echo "== Downloading Vivaldi as of 20171110 =="
  wget -O $vivaldi https://downloads.vivaldi.com/stable/vivaldi-stable-1.12.955.48-1.x86_64.rpm
fi
echo "=="
dnf -y install $vivaldi
echo "=="

echo "== PRODUCTIVITY =="
dnf -y install rednotebook
dnf -y install focuswriter
dnf -y install hamster-time-tracker
dnf -y install thunderbird
dnf -y install libreoffice

echo "== GRAPHICS =="
dnf -y install shotwell
dnf -y install rawstudio
dnf -y install gimp

echo "== SECURITY =="
dnf -y install keepass
dnf -y install tor
systemctl enable tor
systemctl start tor

echo "== UTILITIES =="
dnf -y install krename
dnf -y install guake
dnf -y install gnome-disk-utility
dnf -y install gnome-tweak-tool
dnf -y install krename
dnf -y install remmina
dnf -y install owncloud-client
dnf -y install solaar
dnf -y install speedtest-cli
dnf -y install rsync
dnf -y install s3cmd
dnf -y install unrar
dnf -y install unzip
dnf -y install wget
dnf -y install htop

echo "Checking for Beyond Compare..."
echo "=="
bcompare="$dlpath/bcompare.rpm"
if [ -f "$bcompare" ]
then
	echo "$bcompare found. Skipping Download."
else
	echo "$bcompare not found."
  echo "== Downloading Beyond Compare =="
	wget -O bcompare.rpm http://www.scootersoftware.com/bcompare-4.2.3.22587.x86_64.rpm
fi
echo "=="
dnf -y install $bcompare
echo "=="

echo "== DEVELOPMENT =="
dnf -y install filezilla
dnf -y install subversion
dnf -y install git
dnf -y install eclipse
dnf copr -y enable mosquito/brackets
dnf -y install brackets
dnf -y install kernel-devel kernel-headers
dnf -y install mysql-workbench-community
dnf -y install mariadb mariadb-server
systemctl enable mariadb
systemctl start mariadb

dnf -y install httpd
dnf -y install php
dnf -y install php-mysqlnd
dnf -y install php-opcache
dnf -y install php-pecl-apcu
dnf -y install php-cli
dnf -y install php-pear
dnf -y install php-pdo
dnf -y install php-mysqlnd
dnf -y install php-pgsql
dnf -y install php-pecl-mongodb
dnf -y install php-pecl-memcache
dnf -y install php-pecl-memcached
dnf -y install php-gd
dnf -y install php-mbstring
dnf -y install php-mcrypt
dnf -y install php-xml

systemctl enable httpd
systemctl start httpd


echo "=="
echo "Checking for atom editor..."
echo "=="
atom="$dlpath/atom.rpm"
if [ -f "$atom" ]
then
	echo "$atom found. Skipping Download."
else
	echo "$atom not found."
  echo "== Downloading Atom =="
  wget -O atom.rpm https://atom.io/download/rpm
fi
echo "=="
dnf -y install $atom
echo "=="

sudo pip install --upgrade pip

dnf config-manager --add-repo http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
dnf config-manager --set-enabled virtualbox
dnf -y install VirtualBox-5.2
dnf -y install VirtualBox-guest-additions

echo "== SETTINGS =="
# Add global git values
git config --global user.name "First Last"
git config --global user.email "your@email.com"

# Autostart utilities
cp autostart/guake.desktop ~/.config/autostart
cp autostart/ownCloud.desktop ~/.config/autostart

# Secure mariadb
mysql_secure_installation

dnf upgrade -y
dnf clean packages -y
reboot
