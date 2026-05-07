# Visual Studio Code ([retour](../SOFTWARE.md))

Il s'agit de l'IDE de Microsoft, permettant la programmation dans plusieurs langages et personnalisable via les extensions.

### Télécharger l'archive (.tar.gz) :

https://code.visualstudio.com/Download

### Attribution des droits et changement du propriétaire de la sandbox :

Une fois l'archive téléchargée et extraite, il suffit de changer les droits en 4755 et le propriétaire (utilisateur et groupe) en root.

```
sudo chown root:root ~/soft-local/VSCode-linux-x64/chrome-sandbox
sudo chmod 4755 ~/soft-local/VSCode-linux-x64/chrome-sandbox
```

### Création d'un lien symbolique pour l'exécuter comme une commande :
```
ln -s ~/soft-local/VSCode-linux-x64/code ~/soft-local/path/vscode
```

> [!IMPORTANT]
> Il faut mettre le répertoire contenant le lien symbolique dans la variable PATH, dans le fichier .bashrc. 

### Entrée desktop :
```
[Desktop Entry]
Type=Application
Version=1.116.0
Name=Visual Studio Code
Comment=Microsoft IDE
Path=/home/<username>/soft-local/VSCode-linux-x64
Exec=/home/<username>/soft-local/path/vscode
Icon=/home/<username>/Images/Icons/vscode-icon.png
Terminal=false
Categories=Development
```