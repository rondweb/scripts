#!/bin/bash
# Execute sudo ip address add 192.168.2.2/24 brd + dev eth0
sudo ip address add 192.168.2.2/24 brd + dev eth0
# Execute apt-get update and upgrade
sudo apt-get update && sudo apt-get upgrade -y
# install the ssh client and server
sudo apt-get install openssh-client openssh-server -y
# Install PHP and the Apache PHP module
sudo apt install php libapache2-mod-php -y
# Install MySQL and the PHP-MySQL package
sudo apt install mysql-server php-mysql -y
# Install PostgreSQL and the PHP-PgSQL package
sudo apt install postgresql postgresql-contrib php-pgsql -y
# clean the enviroment
sudo apt-get autoremove
# Install the latest version of miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-py311_23.5.2-0-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p $HOME/miniconda
source $HOME/miniconda/bin/activate
conda init

# reboot the system
sudo reboot
