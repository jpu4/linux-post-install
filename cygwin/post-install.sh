#!/bin/bash

# The following installs are what is useful for managing basic scripts when forced to work from a windows environment
#
# Download and install cygwin from https://cygwin.com
#
# Place the setup file inside the directory chosen to hold cygwin (possibly c:\cygwin)
# 
# From the windows command line run setup-x86_64.exe -q -P wget
# 
# From there you will be able to run the rest of these installs.

wget rawgit.com/transcode-open/apt-cyg/master/apt-cyg
install apt-cyg /bin
apt-cyg install curl
apt-cyg install php php-curl php-bcmath php-bz2 php-calendar php-ctype php-devel php-exif php-fileinfo php-ftp php-gd php-gettext php-gv php-imap php-intl php-json php-mbstring php-PEAR php-phar php-posix php-simplexml php-sockets php-sqlite3 php-tidy php-tokenizer php-xmlreader php-xmlrpc php-xmlwriter php-xsl php-zip php-zlib
apt-cyg install dateutils
apt-cyg install openssh openssl
apt-cyg install zip
apt-cyg install unzip
apt-cyg install vim
apt-cyg install whois
apt-cyg install time
apt-cyg install git
apt-cyg install rsync
apt-cyg install ping
apt-cyg install jpeg openjpeg openjpeg2
apt-cyg install offlineimap
# apt-cyg install nginx
apt-cyg install mcrypt
apt-cyg install grep dos2unix
apt-cyg install binutils
