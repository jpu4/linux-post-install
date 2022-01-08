#!/bin/bash

GIT_USER=""
GIT_EMAIL=""
CMD_INSTALL="sudo pacman -S --noconfirm "
DIR_START="~/Downloads"

start () {
    sudo systemctl enable $1
    sudo systemctl start $1
}

restart () {
    sudo systemctl restart $1
}

cd $DIR_START

sudo pacman -Syy
$CMD_INSTALL base-devel
$CMD_INSTALL wget

$CMD_INSTALL git
git config --global user.name="$GIT_USER"
git config --global user.email="$GIT_EMAIL"


# LEMP
$CMD_INSTALL nginx
$CMD_INSTALL mariadb
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
$CMD_INSTALL php php-fpm

# Find and replace nginx.conf
# location / {
# root   /usr/share/nginx/html;
# index  index.html index.htm index.php;
# }
# location ~ \.php$ {
# fastcgi_pass   unix:/var/run/php-fpm/php-fpm.sock;
# fastcgi_index  index.php;
# root   /usr/share/nginx/html;
# include        fastcgi.conf;
# }

$CMD_INSTALL ufw
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable

start mariadb
start nginx
start php-fpm

# SPOTIFY
git clone https://aur.archlinux.org/spotify.git
cd spotify
makepkg -si
cd $DIR_START

# VSCODE
git clone https://aur.archlinux.org/visual-studio-code-bin.git
cd visual-studio-code-bin
makepkg -si
cd $DIR_START

# BEYOND COMPARE
wget https://www.scootersoftware.com/bcompare-4.4.1.26165.x86_64.tar.gz
tar zxvf bcompare-4.4.1.26165.i386.tar.gz
cd bcompare-4.4.1.26165
./install.sh
cd $DIR_START

