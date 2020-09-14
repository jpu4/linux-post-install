#!/bin/sh

# Author: James Ussery <James@Ussery.me>
# Date Created: 20171110
# Description: Fedora Post install (should work for future versions as well).
# As always, read through each item use the hash symbol "#" to stop a package from installing.
# I've used individual dnf entries because I've found in the past apps get skipped if there's an error.
#-------------------------------------------------------------------------------------

dlpath="~/Downloads"
cd $dlpath

# UnComment to enable SSH Service
# echo "Start SSHD service"
# systemctl enable sshd
# systemctl start sshd

echo "Remove programs I don't like"
dnf -y remove amarok dragon

echo "Upgrade system"
dnf -y upgrade

echo "== REPOS =="
dnf -y install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf -y install http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

ehco "fastestmirror=true" >> /etc/dnf/dnf.conf
ehco "deltarpm=true" >> /etc/dnf/dnf.conf

dnf copr enable kwizart/fedy
dnf install fedy -y

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
# dnf -y install pidgin

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
 wget -O $slack https://downloads.slack-edge.com/linux_releases/slack-4.8.0-0.1.fc21.x86_64.rpm
fi
echo "=="
dnf -y install $slack
echo "=="


# Signal Desktop for Fedora
# https://copr.fedorainfracloud.org/coprs/luminoso/Signal-Desktop/

dnf copr enable luminoso/Signal-Desktop
dnf install -y signal-desktop


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
  wget -O $vivaldi https://downloads.vivaldi.com/stable/vivaldi-stable-3.1.1929.48-1.x86_64.rpm
fi
echo "=="
dnf -y install $vivaldi
echo "=="

echo "== PRODUCTIVITY =="
dnf -y install focuswriter
dnf -y install thunderbird
dnf -y install libreoffice
# dnf -y install hamster-time-tracker

echo "== GRAPHICS =="
dnf -y install openshot
dnf -y install digikam
dnf -y install krita

echo "== SECURITY =="
# dnf -y install keepass
# UnComment to install and enable tor
# dnf -y install tor
# systemctl enable tor
# systemctl start tor

echo "== UTILITIES =="
dnf -y install exfat-utils fuse-exfat fuse
dnf -y install krename
dnf -y install guake
dnf -y install gnome-disk-utility
dnf -y install gnome-tweak-tool
dnf -y install krename
dnf -y install remmina
dnf -y install nextcloud-client
dnf -y install solaar
dnf -y install speedtest-cli
dnf -y install rsync
dnf -y install s3cmd
dnf -y install unrar
dnf -y install unzip
dnf -y install wget
dnf -y install htop

echo "Checking for NoMachine..."
echo "=="
nomachine="$dlpath/NoMachine.rpm"
if [ -f "$nomachine" ]
then
	echo "$nomachine found. Skipping Download."
else
	echo "$nomachine not found."
  echo "== Downloading NoMachine =="
	wget -O nomachine.rpm https://download.nomachine.com/download/6.2/Linux/nomachine_6.11.2_1_x86_64.rpm
fi
echo "=="
dnf -y install $nomachine
echo "=="


echo "Checking for TeamViewer..."
echo "=="
teamviewer="$dlpath/teamviewer.rpm"
if [ -f "$teamviewer" ]
then
	echo "$teamviewer found. Skipping Download."
else
	echo "$teamviewer not found."
  echo "== Downloading teamviewer =="
	wget -O teamviewer.rpm https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm
fi
echo "=="
dnf -y install $teamviewer
echo "=="

echo "Checking for Beyond Compare..."
echo "=="
bcompare="$dlpath/bcompare.rpm"
if [ -f "$bcompare" ]
then
	echo "$bcompare found. Skipping Download."
else
	echo "$bcompare not found."
  echo "== Downloading Beyond Compare =="
	wget -O bcompare.rpm http://scootersoftware.com/bcompare-4.3.5.24893.x86_64.rpm
fi
echo "=="
dnf -y install $bcompare
echo "=="

echo "== DEVELOPMENT =="
dnf -y install kernel-devel kernel-headers

dnf -y install filezilla
# dnf -y install subversion
dnf -y install git
# dnf -y install eclipse

# = VS CODE (https://code.visualstudio.com/docs/setup/linux) =
rpm --import https://packages.microsoft.com/keys/microsoft.asc
sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
dnf -y install code

# == Database ==
# = MYSQL =
dnf -y install mysql-workbench-community
dnf -y install mariadb mariadb-server
systemctl enable mariadb
systemctl start mariadb

# = MongoDB =
dnf -y install mongodb mongodb-server
service mongod start

# = Node.js =
dnf -y install nodejs npm

# = Apache (httpd+php) =
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

sudo pip install --upgrade pip

# UnComment for VirtualBox
# 
# dnf config-manager --add-repo http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
# dnf config-manager --set-enabled virtualbox
dnf -y install binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms rpm-build
# 
# dnf -y install VirtualBox-6.0
# dnf -y install VirtualBox-guest-additions
# Rebuild kernel modules
# /usr/lib/virtualbox/vboxdrv.sh setup
# usermod -a -G vboxusers $USER

echo "== SETTINGS =="
# Add global git values
git config --global user.name "First Last"
git config --global user.email "your@email.com"

# Autostart utilities
cp autostart/guake.desktop ~/.config/autostart

# Secure mariadb
mysql_secure_installation

# https://github.com/RPM-Outpost/typora
git clone https://github.com/RPM-Outpost/typora.git
cd typora
./create-package.sh x64


dnf upgrade -y
dnf clean packages -y
reboot
