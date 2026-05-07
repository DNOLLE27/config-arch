# LAMP ([retour](../SOFTWARE.md))

LAMP désigne un serveur Web Linux avec Apache, MySQL/MariaDB et PHP. L'objectif de ce ReadMe est d'installer un serveur Web local.

> [!NOTE]
> Dans le cadre de Arch Linux, seul MariaDB est disponible. Il s'agit d'un fork MySQL.

## Installation d'Apache :

Installation du serveur Apache :
```
sudo pacman -S apache
```

Activation et démarrage du serveur Apache :
```
sudo systemctl enable httpd
sudo systemctl start httpd
```

Configuration de /etc/httpd/conf/httpd.conf :
```
ServerName localhost

LoadModule php_module modules/libphp.so

<IfModule php_module>
    AddHandler php-script .php
    Include conf/extra/php_module.conf
</IfModule>

Include conf/extra/phpmyadmin.conf

#LoadModule mpm_event_module modules/mod_mpm_event.so
#LoadModule mpm_worker_module modules/mod_mpm_worker.so
LoadModule mpm_prefork_module modules/mod_mpm_prefork.so

<IfModule mpm_prefork_module>
        LoadModule cgi_module modules/mod_cgi.so
</IfModule>
```

Test de la configuration :
```
sudo apachectl configtest
```

S'il n'y a pas d'erreur, il suffit de redémarrer le serveur Apache :
```
sudo systemctl restart httpd
```

## Installation de MariaDB :

Installation du serveur MariaDB :
```
sudo pacman -S mariadb
```

Configuration du serveur MariaDB (création des tables systèmes, ...) :
```
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
```

Activation et démarrage du serveur MariaDB :
```
sudo systemctl enable mariadb
sudo systemctl start mariadb
```

Sécurisation du serveur :
```
sudo mysql_secure_installation

root password (laisser vide) > 
Switch to unix_socket authentication : n > 
Change root password : n > 
Remove anonymous users ? : Y > 
Disallow root login remotely ? : Y >
Remove test database and access to it ? : Y >
Reload privilege tables now ? : Y
```

Création de l’utilisateur root :
```
# Accès au serveur :
sudo mariadb

# Requête SQL à exécuter dans MariaDB :
ALTER USER 'root'@'localhost' IDENTIFIED BY 'mdp';
```

## Installation de PHP :

Installation :
```
sudo pacman -S php php-apache php-cgi php-gd
```

Configuration de /etc/php/php.ini :
```
extension=curl
extension=zip
extension=mysqli
extension=pdo_mysql
extension=gd
```

## Installation de PHPMyAdmin :

Installation :
```
sudo pacman -S phpmyadmin
```

Configuration de /etc/httpd/conf/extra/phpmyadmin.conf :
```
Alias /phpmyadmin "/usr/share/webapps/phpMyAdmin"

<Directory "/usr/share/webapps/phpMyAdmin">
    DirectoryIndex index.php
    AllowOverride All
    Require all granted
</Directory>
```

Génération d'une clé pour Blowfish :
```
openssl rand -hex 16
```

Configuration de /etc/webapps/phpmyadmin/config.inc.php :
```
$cfg['blowfish_secret'] = 'clé';

$cfg['Servers'][$i]['pmadb'] = 'phpmyadmin';
$cfg['Servers'][$i]['controluser'] = 'pma';
$cfg['Servers'][$i]['controlpass'] = 'motdepasse'; 
```

Création du répertoire temporaire :
```
sudo mkdir -p /usr/share/webapps/phpMyAdmin/tmp
sudo chown -R http:http /usr/share/webapps/phpMyAdmin/tmp
sudo chmod 700 /usr/share/webapps/phpMyAdmin/tmp
```

Exécution du script de création des tables PHPMyAdmin :
```
sudo mariadb -u root -p < /usr/share/webapps/phpMyAdmin/sql/create_tables.sql
```

Création de l'utilisateur PMA :
```
sudo mariadb -u root -p

CREATE USER 'pma'@'localhost' IDENTIFIED BY 'motdepasse';

GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO 'pma'@'localhost';

FLUSH PRIVILEGES;
```

Redémarrage du serveur Apache :
```
sudo systemctl restart httpd
```

## Gestion du répertoire Web (/srv/http) :  

Modification du groupe propriétaire et des droits du répertoire qui contiendra les projets web (http) :
```
sudo chown root:wheel /srv/http
sudo chmod g+w /srv/http
```

Création d'un lien symbolique vers le répertoire http :
```
ln -s /srv/http ~/Bureau/www
```