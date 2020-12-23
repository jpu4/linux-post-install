#!/bin/sh

# Author: James Ussery <James@Ussery.me>
# Date Created: 20171110
# Description: Fedora Post install (should work for future versions as well).
# As always, read through each item use the hash symbol "#" to stop a package from installing.
# I've used individual sudo dnf entries because I've found in the past apps get skipped if there's an error.
#-------------------------------------------------------------------------------------

dlpath="~/Downloads"
mysqluser=""
mysqlpass=""
gitfirstname=""
gitlastname=""
gitemail=""


cd $dlpath

# UnComment to enable SSH Service
# echo "Start SSHD service"
# systemctl enable sshd
# systemctl start sshd

echo "Remove programs I don't like"
sudo dnf -y remove amarok dragon parole

echo "Upgrade system"
sudo dnf -y upgrade

echo "== REPOS =="
sudo dnf -y install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

ehco "fastestmirror=true" >> /etc/sudo dnf/sudo dnf.conf
ehco "deltarpm=true" >> /etc/sudo dnf/sudo dnf.conf

sudo dnf copr enable kwizart/fedy -y
sudo dnf install fedy -y

echo "== MEDIA =="
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
sudo dnf -y install azureus

sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-spotify.repo
sudo dnf -y install spotify-client


echo "== CHAT =="
sudo dnf -y install skypeforlinux.x86_64
# sudo dnf -y install pidgin

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
sudo dnf -y install $slack
echo "=="


# Signal Desktop for Fedora
# https://copr.fedorainfracloud.org/coprs/luminoso/Signal-Desktop/

sudo dnf copr enable luminoso/Signal-Desktop -y
sudo dnf install -y signal-desktop


echo "== BROWSERS =="
sudo dnf -y install lynx
sudo dnf -y install google-chrome-stable

echo "=="
echo "Checking for Vivaldi Browser..."
echo "=="
vivaldi="$dlpath/vivaldi.rpm"
if [ -f "$vivaldi" ]
then
	echo "$vivaldi found. Skipping Download."
else
	echo "$vivaldi not found."
  echo "== Downloading Vivaldi as of 20201223 =="
  wget -O $vivaldi https://downloads.vivaldi.com/stable/vivaldi-stable-3.5.2115.81-1.x86_64.rpm
fi
echo "=="
sudo dnf -y install $vivaldi
echo "=="

echo "== PRODUCTIVITY =="
sudo dnf -y install focuswriter
sudo dnf -y install thunderbird
sudo dnf -y install libreoffice
# sudo dnf -y install hamster-time-tracker

echo "== GRAPHICS =="
sudo dnf -y install openshot
sudo dnf -y install digikam
sudo dnf -y install krita

echo "== SECURITY =="
# sudo dnf -y install keepass
# UnComment to install and enable tor
# sudo dnf -y install tor
# systemctl enable tor
# systemctl start tor

echo "== UTILITIES =="
sudo dnf -y install exfat-utils fuse-exfat fuse
sudo dnf -y install krename
sudo dnf -y install guake
sudo dnf -y install gnome-disk-utility
sudo dnf -y install gnome-tweak-tool
sudo dnf -y install krename
sudo dnf -y install remmina
sudo dnf -y install nextcloud-client
sudo dnf -y install solaar
sudo dnf -y install speedtest-cli
sudo dnf -y install rsync
sudo dnf -y install s3cmd
sudo dnf -y install unrar
sudo dnf -y install unzip
sudo dnf -y install wget
sudo dnf -y install htop
sudo dnf -y install ark
sudo dnf -y install fish

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
sudo dnf -y install $nomachine
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
sudo dnf -y install $teamviewer
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
sudo dnf -y install $bcompare
echo "=="

echo "== DEVELOPMENT =="
sudo dnf -y install kernel-devel kernel-headers

sudo dnf -y install filezilla
# sudo dnf -y install subversion
sudo dnf -y install git
# sudo dnf -y install eclipse

# = VS CODE (https://code.visualstudio.com/docs/setup/linux) =
rpm --import https://packages.microsoft.com/keys/microsoft.asc
sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf -y install code

# == Database ==
# = MYSQL =
sudo dnf -y install mysql-workbench-community
sudo dnf -y install mariadb mariadb-server
systemctl enable mariadb
systemctl start mariadb

# create admin user
sudo mysql -u root -e "CREATE USER '$mysqluser'@'%' IDENTIFIED BY '$mysqlpass';"
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '$mysqluser'@'localhost' WITH GRANT OPTION;"

# = MongoDB =
sudo dnf -y install mongodb mongodb-server
service mongod start

# = Node.js =
sudo dnf -y install nodejs npm

# = Web Service =
# = Apache (httpd) =
# sudo dnf -y install httpd
# systemctl enable httpd
# systemctl start httpd

# = Nginx =
sudo dnf -y install nginx
systemctl enable nginx
systemctl start nginx

sudo dnf -y install php
sudo dnf -y install php-mysqlnd
sudo dnf -y install php-opcache
sudo dnf -y install php-pecl-apcu
sudo dnf -y install php-cli
sudo dnf -y install php-pear
sudo dnf -y install php-pdo
sudo dnf -y install php-mysqlnd
sudo dnf -y install php-pgsql
sudo dnf -y install php-pecl-mongodb
sudo dnf -y install php-pecl-memcache
sudo dnf -y install php-pecl-memcached
sudo dnf -y install php-gd
sudo dnf -y install php-mbstring
sudo dnf -y install php-mcrypt
sudo dnf -y install php-xml

sudo pip install --upgrade pip

# UnComment for VirtualBox
# 
# sudo dnf config-manager --add-repo http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
# sudo dnf config-manager --set-enabled virtualbox
sudo dnf -y install binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms
# 
# sudo dnf -y install VirtualBox-6.0
# sudo dnf -y install VirtualBox-guest-additions
# Rebuild kernel modules
# /usr/lib/virtualbox/vboxdrv.sh setup
# usermod -a -G vboxusers $USER

echo "== SETTINGS =="
# Add global git values
git config --global user.name "$gitfirstname $gitlastname"
git config --global user.email "$gitemail"
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install -y gh

# Autostart utilities
cp autostart/guake.desktop ~/.config/autostart

# Secure mariadb
mysql_secure_installation

sudo dnf install rpm-build rpmdevtools -y

# https://github.com/RPM-Outpost/typora
git clone https://github.com/RPM-Outpost/typora.git
cd typora
./create-package.sh x64

# Flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Spotify
wget https://dl.flathub.org/repo/appstream/com.spotify.Client.flatpakref
flatpak install flathub com.spotify.Client

# Discord
wget https://dl.flathub.org/repo/appstream/com.discordapp.Discord.flatpakref
flatpak install flathub com.discordapp.Discord

sudo dnf upgrade -y
sudo dnf clean packages -y
reboot
