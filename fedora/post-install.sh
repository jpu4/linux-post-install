#!/bin/sh

# Author: James Ussery <James@Ussery.me>
# Date Created: 20171110
# Description: Fedora Post install (should work for future versions as well).
# As always, read through each item use the hash symbol "#" to stop a package from installing.
# I've used individual sudo dnf entries because I've found in the past apps get skipped if there's an error.
#-------------------------------------------------------------------------------------

DIR_DL="~/Downloads"
DB_USER=""
DB_PASS=""
GIT_FNAME=""
GIT_LNAME=""
GIT_EMAIL=""

# sudo setenforce 0
# sudo sed -i 's|SELinux=enforcing|SELinux=permissive|g' /etc/sysconfig/selinux
# sudo sed -i 's|SELINUX=permissive|SELINUX=disabled|g' /etc/sysconfig/selinux
# sudo sed -i 's|SELINUX=permissive|SELINUX=disabled|g' /etc/selinux/config
# sudo sed -i 's|SELINUX=enforcing|SELINUX=disabled|g' /etc/sysconfig/selinux
# sudo sed -i 's|SELINUX=enforcing|SELINUX=disabled|g' /etc/selinux/config
sudo grubby --update-kernel ALL --args selinux=0

sudo gsettings set org.gnome.desktop.session idle-delay 0
sudo gsettings set org.gnome.desktop.screensaver lock-enabled false
cd $DIR_DL

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
sudo dnf install -y https://rpms.remirepo.net/fedora/remi-release-$(rpm -E %fedora).rpm
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo curl -o /etc/yum.repos.d/skype-stable.repo https://repo.skype.com/rpm/stable/skype-stable.repo
sudo dnf config-manager --add-repo http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
# sudo touch /etc/yum.repos.d/mysql-community.repo
# sudo echo "
# [mysql80-community]
# name=MySQL 8.0 Community Server
# baseurl=http://repo.mysql.com/yum/mysql-8.0-community/fc/$releasever/$basearch/
# enabled=1
# gpgcheck=0" > /etc/yum.repos.d/mysql-community.repo
# sudo dnf -y install mysql-community-server
# sudo systemctl enable mysqld.service
# sudo systemctl start mysqld.service
# grep 'A temporary password is generated' /var/log/mysqld.log | tail -1

sudo dnf config-manager --setopt=fastestmirror=True --save
sudo dnf config-manager --setopt=deltarpm=true --save

sudo dnf copr enable kwizart/fedy -y
sudo dnf install fedy -y

echo "== SETTINGS =="
# Add global git values
git config --global user.name "$GIT_FNAME $GIT_LNAME"
git config --global user.email "$GIT_EMAIL"
sudo dnf install -y gh
export EDITOR=/usr/bin/micro

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
sudo dnf -y install obs-studio

echo "== CHAT =="
sudo dnf -y install skypeforlinux
# sudo dnf -y install pidgin
sudo dnf -y install https://downloads.slack-edge.com/linux_releases/slack-4.12.0-0.1.fc21.x86_64.rpm

# Signal Desktop for Fedora
# https://copr.fedorainfracloud.org/coprs/luminoso/Signal-Desktop/
sudo dnf copr enable luminoso/Signal-Desktop -y
sudo dnf install -y signal-desktop

echo "== BROWSERS =="
sudo dnf -y install lynx
# sudo dnf -y install google-chrome-stable
sudo dnf -y install https://downloads.vivaldi.com/stable/vivaldi-stable-5.0.2497.51-1.x86_64.rpm

echo "== PRODUCTIVITY =="
# sudo dnf -y install focuswriter 
sudo dnf -y install thunderbird
sudo dnf -y install libreoffice
# sudo dnf -y install hamster-time-tracker

# https://github.com/RPM-Outpost/typora
git clone https://github.com/RPM-Outpost/typora.git
cd typora
./create-package.sh x64

echo "== GRAPHICS =="
# sudo dnf -y install openshot
sudo dnf -y install digikam
sudo dnf -y install krita
# sudo dnf -y install kdenlive

echo "== SECURITY =="
# sudo dnf -y install keepass
# UnComment to install and enable tor
# sudo dnf -y install tor
# systemctl enable tor
# systemctl start tor

echo "== UTILITIES =="
sudo dnf -y install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo dnf -y install exfat-utils fuse-exfat fuse
sudo dnf -y install krename
sudo dnf -y install yakuake
sudo dnf -y install gnome-disk-utility
sudo dnf -y install gnome-tweak-tool
sudo dnf -y install krename
sudo dnf -y install remmina
sudo dnf -y install nextcloud-client
sudo dnf -y install solaar
sudo dnf -y install numlockx 
sudo dnf -y install micro xclip
sudo dnf -y install samba
sudo dnf -y install wget
wget https://bintray.com/ookla/rhel/rpm -O bintray-ookla-rhel.repo
sudo mv bintray-ookla-rhel.repo /etc/yum.repos.d/
sudo dnf -y install speedtest
sudo dnf -y install rsync
sudo dnf -y install s3cmd
sudo dnf -y install unrar
sudo dnf -y install unzip
sudo dnf -y install wget
sudo dnf -y install htop
sudo dnf -y install vim
sudo dnf -y install ark
sudo dnf -y install fish
sudo dnf -y install ksnip
sudo dnf -y install filezilla
sudo dnf -y install binutils gcc make patch libgomp glibc-headers glibc-devel kernel-headers kernel-devel dkms
sudo dnf -y install rpm-build rpmdevtools
sudo dnf -y install https://download.nomachine.com/download/6.2/Linux/nomachine_6.11.2_1_x86_64.rpm
sudo dnf -y install http://scootersoftware.com/bcompare-4.3.5.24893.x86_64.rpm

echo "== DEVELOPMENT =="
sudo dnf -y install kernel-devel kernel-headers
sudo dnf -y install git
# sudo dnf -y install mongodb mongodb-server
# sudo systemctl start mongod
sudo dnf -y install nodejs npm
sudo dnf -y install https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-8.0.23-1.fc33.x86_64.rpm
sudo dnf -y install mariadb-server
sudo systemctl enable mariadb
sudo systemctl start mariadb
sudo firewall-cmd --add-port=3306/tcp --permanent

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

sudo dnf check-update
sudo dnf -y install code

# create admin user
sudo mysql -u root -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';"
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' WITH GRANT OPTION;"
sudo mysql -u root -e "GRANT ALL ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS' WITH GRANT OPTION;"

# = Nginx =
sudo dnf -y install nginx
sudo systemctl enable nginx
sudo systemctl start nginx

sudo dnf -y install php-fpm
sudo dnf -y install php-xdebug
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
sudo dnf -y install php-zip
sudo firewall-cmd --add-port=80/tcp --permanent
sudo firewall-cmd --add-port=443/tcp --permanent
# Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer

pip install --user
pip install --upgrade pip

echo "=== VIRTUALIZATION ==="
echo "== QEMU and Virt Manager =="
sudo dnf group install -y --with-optional virtualization
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
sudo sed -i 's|# unix_sock_group|unix_sock_group|g' /etc/libvirt/libvirtd.conf
sudo sed -i 's|# unix_sock_rw_perms|unix_sock_rw_perms|g' /etc/libvirt/libvirtd.conf
sudo usermod -a -G libvirt $USER
sudo systemctl restart libvirtd

# UnComment for VirtualBox
# sudo dnf config-manager --set-enabled virtualbox
# sudo dnf -y install VirtualBox-6.0
# sudo dnf -y install VirtualBox-guest-additions
# Rebuild kernel modules
# /usr/lib/virtualbox/vboxdrv.sh setup
# usermod -a -G vboxusers $USER

# Secure mariadb
mysql_secure_installation

# Flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Spotify
wget https://dl.flathub.org/repo/appstream/com.spotify.Client.flatpakref
flatpak install -y flathub com.spotify.Client

# Discord
# wget https://dl.flathub.org/repo/appstream/com.discordapp.Discord.flatpakref
# flatpak install -y flathub com.discordapp.Discord
sudo dnf install- -y discord

# Obsidian
wget https://dl.flathub.org/repo/appstream/md.obsidian.Obsidian.flatpakref
flatpak install -y flathub md.obsidian.Obsidian

sudo dnf -y install zeal
sudo dnf -y install https://vpn.net/installers/logmein-hamachi-2.1.0.203-1.x86_64.rpm
sudo dnf -y install https://www.expressvpn.works/clients/linux/expressvpn-3.17.0.8-1.x86_64.rpm
sudo dnf -y install https://scootersoftware.com/bcompare-4.4.1.26165.x86_64.rpm

## Teamviewer
# sudo dnf -y install https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm
## anydesk
# cat > /etc/yum.repos.d/AnyDesk-Fedora.repo << "EOF" 
# [anydesk]
# name=AnyDesk Fedora - stable
# baseurl=http://rpm.anydesk.com/fedora/$basearch/
# gpgcheck=1
# repo_gpgcheck=1
# gpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY
# EOF
# sudo dnf install -y http://springdale.princeton.edu/data/springdale/7/x86_64/os/Addons/Packages/pangox-compat-0.0.2-2.sdl7.x86_64.rpm
# sudo dnf install -y anydesk

sudo dnf upgrade -y
sudo dnf clean packages -y

# NVIDIA GEFORCE RTX 3060
# https://www.reddit.com/r/Fedora/comments/qntks4/how_can_i_install_nvidia_470_driver/
# sudo dnf remove -y '*nvidia*'
# sudo dnf install -y --refresh akmod-nvidia-470xx --enablerepo=rpmfusion-nonfree-updates-testing

reboot
