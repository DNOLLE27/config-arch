# Parsec ([retour](../SOFTWARE.md))

Il s'agit d'un logiciel permettant l'accès à un ordinateur à distance, utilisé dans le cadre du gaming.

> [!IMPORTANT]
> Pour le moment, Parsec n'est qu'accessible en client et non en host sur Linux.

### Installation des prérequis :
```
pacman -S binutils tar
```

### Installation :

Il faut télécharger le .deb depuis le site officiel :

https://parsec.app/downloads

Extration du .deb :
```
bsdtar -xvf parsec-linux.deb 
bsdtar -xvf data.tar.*
```

Copie des fichiers vers les répertoires adéquats :
```
sudo cp -r usr/* /usr/
```