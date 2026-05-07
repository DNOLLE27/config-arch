# Postman ([retour](../SOFTWARE.md))

Il s'agit d'un client HTTP avec interface graphique, permettant de réaliser des appels vers API.

### Télécharger l'archive (.tar.gz) :

https://www.postman.com/downloads/

### Attribution des droits et changement du propriétaire de la sandbox :

Une fois l'archive téléchargée et extraite, il suffit de changer les droits en 4755 et le propriétaire (utilisateur et groupe) en root.

```
sudo chown root:root chrome-sandbox 
sudo chmod 4755 chrome-sandbox 
```

### Création d'un lien symbolique pour l'exécuter comme une commande :
```
ln -s ~/soft-local/Postman/app/postman ~/soft-local/path/postman
```

> [!IMPORTANT]
> Il faut mettre le répertoire contenant le lien symbolique dans la variable PATH, dans le fichier .bashrc. 

### Entrée desktop :

```
[Desktop Entry]
Version=12.6.8
Name=Postman
Comment=Client HTTP
Exec=/home/<username>/soft-local/Postman/app/postman
Path=/home/<username>/soft-local/Postman/
Icon=/home/<username>/soft-local/Postman/app/resources/app/assets/icon.png
Terminal=false
Type=Application
Categories=Development;
```