#!/bin/bash

GIT_USER=""
GIT_EMAIL=""
CMD_INSTALL="sudo pacman -S --noconfirm "
DIR_START="~/Downloads"
DIR_WEBCONF="/localhost/config/conf"

start () {
    sudo systemctl enable $1
    sudo systemctl start $1
}

restart () {
    sudo systemctl restart $1
}

aur_install () {
    git clone https://aur.archlinux.org/$1.git
    cd $1
    makepkg -si
    cd $DIR_START
}

snap_install () {
    sudo snap install $1
}

cd $DIR_START

$CMD_INSTALL chaotic-keyring
sudo pacman -Syy
$CMD_INSTALL base-devel
$CMD_INSTALL wget

$CMD_INSTALL git
git config --global user.name="$GIT_USER"
git config --global user.email="$GIT_EMAIL"

# SNAPD
aur_install snapd
start snapd

# LEMP
$CMD_INSTALL nginx
$CMD_INSTALL mariadb
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
$CMD_INSTALL php php-fpm

sudo sed -i "s|#gzip  on;|include        $DIR_WEBCONF/*.conf;|g" /etc/nginx/nginx.conf
# sed -i "s|index  index.html index.htm|index  index.html index.htm index.php;|g" /etc/nginx/nginx.conf
# sed -i "s|include        fastcgi_params;|include        fastcgi.conf;|g" /etc/nginx/nginx.conf
# sed -i "s|fastcgi_pass   127.0.0.1:9000;|fastcgi_pass   unix:/var/run/php-fpm/php-fpm.sock;|g" /etc/nginx/nginx.conf
# sed -i "s|root           html;|root   /usr/share/nginx/html;|g" /etc/nginx/nginx.conf

$CMD_INSTALL ufw
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable

start mariadb
start nginx
start php-fpm

# SPOTIFY
snap_install spotify

# VSCODE
aur_install visual-studio-code-bin

# TYPORA
aur_install typora-free

# SKYPE
aur_install skypeforlinux-stable-bin

# NEXTCLOUD CLIENT
aur_install nextcloud-client-git

# DISCORD
$CMD_INSTALL discord

# THUNDERBIRD
$CMD_INSTALL thunderbird

# BEYOND COMPARE
wget https://www.scootersoftware.com/bcompare-4.4.1.26165.x86_64.tar.gz
tar zxvf bcompare-4.4.1.26165.i386.tar.gz
cd bcompare-4.4.1.26165
./install.sh
cd $DIR_START

# MYSQL-WORKBENCH
$CMD_INSTALL mysql-workbench
