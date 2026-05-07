# GitKraken ([retour](../SOFTWARE.md))

Il s'agit d'une interface graphique permettant l'utilisation de Git, notamment via Github.

### Télécharger l'archive (.tar.gz) :
https://www.gitkraken.com/download

### Attribution des droits et changement du propriétaire de la sandbox :

Une fois l'archive téléchargée et extraite, il suffit de changer les droits en 4755 et le propriétaire (utilisateur et groupe) en root.

```
sudo chown root:root chrome-sandbox 
sudo chmod 4755 chrome-sandbox 
```

### Création d'un lien symbolique pour l'exécuter comme une commande :
```
ln -s ~/soft-local/gitkraken/gitkraken ~/soft-local/path/gitkraken
```

> [!IMPORTANT]
> Il faut mettre le répertoire contenant le lien symbolique dans la variable PATH, dans le fichier .bashrc. 

### Entrée desktop :
```
[Desktop Entry]
Version=12.0.1
Name=GitKraken
Comment=GUI pour Git
Exec=/home/<username>/soft-local/gitkraken/gitkraken
Path=/home/<username>/soft-local/gitkraken/
Icon=/home/<username>/soft-local/gitkraken/gitkraken.png
Terminal=false
Type=Application
Categories=Development;
```