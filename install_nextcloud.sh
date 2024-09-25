#!/bin/bash

# Update and install required packages
#sudo apt update
sudo apt install -y ca-certificates apt-transport-https software-properties-common
sudo wget -qO /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
sudo apt update
sudo apt install -y php8.3-common php8.3-cli php8.3-zip php8.3-xml php8.3-mbstring php8.3-gd php8.3-curl

# Add PHP PPA and install Apache, PHP, and MySQL
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install -y apache2 php8.3 libapache2-mod-php8.3 mariadb-server php8.3-mysql wget tar

# Secure MySQL installation
sudo mysql_secure_installation

# Create MySQL database and user
sudo mysql -u root -p <<EOF
CREATE DATABASE nextcloud;
CREATE USER 'nextclouduser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextclouduser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
EOF

# Download and extract Nextcloud
wget https://download.nextcloud.com/server/releases/nextcloud-28.0.0.tar.bz2
tar -xjf nextcloud-28.0.0.tar.bz2
sudo mv nextcloud /var/www/html/

# Set permissions
sudo chown -R www-data:www-data /var/www/html/nextcloud
sudo chmod -R 755 /var/www/html/nextcloud

# Configure Apache
sudo bash -c 'cat > /etc/apache2/sites-available/nextcloud.conf <<EOF
<VirtualHost *:80>
    DocumentRoot /var/www/html/nextcloud/
    ServerName localhost

    <Directory /var/www/html/nextcloud/>
        Options +FollowSymlinks
        AllowOverride All

        <IfModule mod_dav.c>
            Dav off
        </IfModule>

        SetEnv HOME /var/www/html/nextcloud
        SetEnv HTTP_HOME /var/www/html/nextcloud
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF'

# Enable site and rewrite module
sudo a2ensite nextcloud.conf
sudo a2enmod rewrite
sudo systemctl restart apache2

echo "Nextcloud installation script completed. Please navigate to http://your_domain_or_IP/nextcloud to finish the setup."
