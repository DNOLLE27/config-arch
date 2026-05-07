# Lunacy ([retour](../SOFTWARE.md))

Il s'agit d'un logiciel permettant la réalisation de maquette d'interface graphique pour des projets (Web, client lourd, ...).

### Installation des prérequis :
```
pacman -S binutils tar
```

### Installation :

Il faut télécharger le .deb depuis le site officiel :

https://icones8.fr/lunacy-download

Extraction du .deb :
```
bsdtar -xvf Lunacy.deb 
bsdtar -xvf data.tar.*
```

Copie des fichiers vers les répertoires adéquats :
```
sudo cp -r opt/* /opt/
sudo cp -r usr/* /usr/
```

### Création d'un MIME type pour les fichiers de sauvegardes Lunacy :

Créer un MIME type permet, dans un premier temps, d'associer une icône aux fichiers reconnus, et dans un second temps, d'associer un logiciel à utiliser par défaut pour ouvrir les fichiers associés au type.

Configuration de /usr/share/mime/packages/lunacy.xml :
```
<?xml version="1.0" encoding="UTF-8"?>
<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
  <mime-type type="application/x-lunacy">
    <comment>Lunacy file</comment>
    <glob pattern="*.free" weight="100"/>
    <glob pattern="*.sketch" weight="100"/>
  </mime-type>
</mime-info>
```

Mise à jour de la base de données des MIME types :
```
sudo update-mime-database /usr/share/mime
```

Copie de l'icône dans le répertoire :
```
sudo cp /usr/share/icons/hicolor/scalable/mimetypes/zip-sketch.svg /usr/share/icons/hicolor/scalable/mimetypes/application-x-lunacy.png
```