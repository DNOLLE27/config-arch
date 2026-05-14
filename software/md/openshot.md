# OpenShot ([retour](../SOFTWARE.md))

Il s'agit d'un logiciel de montage vidéo gratuit et open source.

Téléchargement du .appimage :

https://www.openshot.org/download/

Modification des permissions du fichier, pour ajouter le droit d'exécution :
```
chmod +x OpenShot-[version]-x86_64.AppImage
```

Enfin on peut ajouter le fichier dans un répertoire contenu dans la variable d'environnement PATH :
```
ln -s ~/soft-local/appimage/OpenShot-v3.5.1-x86_64.AppImage ~/soft-local/path/openshot
```

Création d'une entrée desktop :
```
[Desktop Entry]
Version=3.5.1
Name=OpenShot
Comment=Logiciel de montage vidéos
Exec=/home/<username>/soft-local/appimage/OpenShot-v3.5.1-x86_64.AppImage
Path=/home/<username>/soft-local/appimage/
Icon=/home/<username>/Images/Icons/openshot-icon.png
Terminal=false
Type=Application
Categories=AudioVideo;
```