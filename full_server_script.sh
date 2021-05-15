### Updating system & upgrading it
sudo apt update && apt upgrade -y
### Installing Apache2 as a webserver and MySQL as DB server
echo "Basic software installation"
sudo apt install -y apache2 php php-mysql php-gd php-mbstring php-zip php-bz2 php-xml mysql-server tar unzip 
### MySQL
### Creating mysql user called admin with password admin on localhost only
sudo mysql -e "create user 'admin'@'localhost' identified by 'admin';"
sudo mysql -e "grant all privileges on *.* to 'admin'@'localhost' with grant option;"
### Installing firewall
echo "UFW Installation"
sudo apt install -y ufw
### Allowing connections from common ports (HTTP(s), SSH, MySQL, and FTP)
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow 3306
sudo ufw allow 21
sudo ufw enable
sudo xdotool key y
### Installing FTP & SSH server
echo "VSFTPD Server Installation"
sudo apt install -y vsftpd 
echo "OpenSSH Server Installation"
sudo apt install -y openssh-server
### Installing PHPMyAdmin

echo "PHPMyAdmin Installation"
wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-all-languages.zip
tar xzf phpMyAdmin-5.1.0-all-languages.zip phpmyadmin
mv phpmyadmin /usr/share/
echo "# phpMyAdmin default Apache configuration

Alias /phpmyadmin /usr/share/phpmyadmin

<Directory /usr/share/phpmyadmin>
    Options SymLinksIfOwnerMatch
    DirectoryIndex index.php

    # limit libapache2-mod-php to files and directories necessary by pma
    <IfModule mod_php7.c>
        php_admin_value upload_tmp_dir /var/lib/phpmyadmin/tmp
        php_admin_value open_basedir /usr/share/phpmyadmin/:/etc/phpmyadmin/:/var/lib/phpmyadmin/:/usr/share/php/php-gettext/:/usr/share/php/php-php-gettext/:/usr/share/javascript/:/usr/share/php/tcpdf/:/usr/share/doc/phpmyadmin/:/usr/share/php/phpseclib/:/usr/share/php/PhpMyAdmin/:/usr/share/php/Symfony/:/usr/share/php/Twig/:/usr/share/php/Twig-Extensions/:/usr/share/php/ReCaptcha/:/usr/share/php/Psr/Container/:/usr/share/php/Psr/Cache/:/usr/share/php/Psr/Log/:/usr/share/php/Psr/SimpleCache/
    </IfModule>

</Directory>

# Disallow web access to directories that don't need it
<Directory /usr/share/phpmyadmin/templates>
    Require all denied
</Directory>
<Directory /usr/share/phpmyadmin/libraries>
    Require all denied
</Directory>" >> /etc/apache2/conf-available/phpmyadmin.conf
a2enconf phpmyadmin
systemctl restart apache2
