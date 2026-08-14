# Comment mettre à jour le système et les logiciels ? ([retour](../MAINTENANCE.md))

Tout va dépendre de comment vous les auraient installés.

## Via Pacman :

Utilisé notamment pour les éléments du système, il suffit, tout simplement, de les mettre à jour avec la commande :
```
pacman -Syu
```

> [!NOTE]
> Vous pouvez en apprendre plus sur les commandes pacman dans la [documentation officielle](https://wiki.archlinux.org/title/Pacman).

## Via Flatpak :

Vous avez deux possibilités pour mettre à jour un paquet :   
1. Via le terminal : ```flatpak update```.

2. Si vous utilisez KDE Plasma, via la logithèque Discover, qui se synchronise avec tous les paquets installés via Flatpak.

## Via une archive .deb, .tar.gz ou .appimage :

Il s'agit de la deuxième méthode (après Pacman/Flatpak) où les mises à jour sont les plus simples.

Il suffit tout simplement d'extraire les archives et de mettre les fichiers au bon endroit.

## Via Build :

En règle général, il suffit de re-télécharger les sources pour le build et de suivre la procédure, lorsqu'on utilise cmake ou make, les binaires/fichiers seront remplacés (ce qui est le cas de Docker-Desktop, Code::Blocs, ...).

Mais dans certains cas (Teamviewer, ...), un setup est proposé permettant de désinstaller d'anciennes versions installées.

Par exemple, dans le cadre de Linux Malware Detection (LMD), la version précédente est placée dans un répertoire .old, permettant ainsi de pouvoir récupérer une ancienne version fonctionnelle, en cas de problème.

L'objectif étant d'essayer de désinstaller la version précédente, puis d'installer la nouvelle, sinon elle sera normalement remplacée lors du build.

> [!NOTE]
> Il faut se renseigner par rapport à l'outil utilisé lors du build.
