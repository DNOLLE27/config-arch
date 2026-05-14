# Draw.io ([retour](../SOFTWARE.md))

Il s'agit d'un logiciel permettant la réalisation de diagrammes type UML, MCD, ...

Téléchargement du .appimage :

https://www.drawio.com/

Modification des permissions du fichier, pour ajouter le droit d'exécution :
```
chmod +x drawio-x86_64-[version].AppImage
```

Enfin on peut ajouter le fichier dans un répertoire contenu dans la variable d'environnement PATH :
```
ln -s ~/soft-local/appimage/drawio-x86_64-[version].AppImage ~/soft-local/path/drawio
```

Création d'une entrée desktop :
```
[Desktop Entry]
Version=30.0.0
Name=Draw.io
Comment=Logiciel de réalisation de diagrammes
Exec=/home/<username>/soft-local/appimage/drawio-x86_64-30.0.0.AppImage
Path=/home/<username>/soft-local/appimage/
Icon=/home/<username>/Images/Icons/drawio-icon.png
Terminal=false
Type=Application
Categories=AudioVideo;
```