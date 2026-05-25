# Maintenance ([retour](../README.md))

Une fois que vous avez fini de configurer votre système et installé tous les logiciels dont vous avez besoin. Vous serez amené à devoir maintenir votre installation.

Cette maintenance est principalement à réaliser lors des mises à jour de votre système et tous les éléments que vous aurez installé.

L'objectif étant de s'assurer qu'il n'y ait pas de problème, notamment avec les services ou configurations que vous aurez pu réaliser.

> [!NOTE]
> Lors des mises à jour, notamment avec pacman, il se peut que tous les fichiers soient remplacés, il est donc important de prévoir un backup de vos fichiers de configurations et service, afin de pouvoir rapidement les replacer.

## Comment mettre à jour le système et les logiciels ?

Tout va dépendre de comment vous les auraient installés.

### Via Pacman :

Utilisé notamment pour les éléments du système, il suffit, tout simplement, de les mettre à jour avec la commande :
```
pacman -Syu
```

> [!NOTE]
> Vous pouvez en apprendre plus sur les commandes pacman dans la [documentation officielle](https://wiki.archlinux.org/title/Pacman).

### Via Flatpak :

Vous avez deux possibilités pour mettre à jour un paquet :   
1. Via le terminal : ```flatpak update```.

2. Si vous utilisez KDE Plasma, via la logithèque Discover, qui se synchronise avec tous les paquets installés via Flatpak.

### Via une archive .deb, .tar.gz ou .appimage :

Il s'agit de la deuxième méthode (après Pacman/Flatpak) où les mises à jour sont les plus simples.

Il suffit tout simplement d'extraire les archives et de mettre les fichiers au bon endroit.

### Via Build :

En règle général, il suffit de re-télécharger les sources pour le build et de suivre la procédure, lorsqu'on utilise cmake ou make, les binaires/fichiers seront remplacés (ce qui est le cas de Docker-Desktop, Code::Blocs, ...).

Mais dans certains cas (Teamviewer, ...), un setup est proposé permettant de désinstaller d'anciennes versions installées.

Par exemple, dans le cadre de Linux Malware Detection (LMD), la version précédente est placée dans un répertoire .old, permettant ainsi de pouvoir récupérer une ancienne version fonctionnelle, en cas de problème.

L'objectif étant d'essayer de désinstaller la version précédente, puis d'installer la nouvelle, sinon elle sera normalement remplacée lors du build.

> [!NOTE]
> Il faut se renseigner par rapport à l'outil utilisé lors du build.

## Comment surveiller les erreurs des services ?

Il faut s'assurer, une fois les mises à jour installées et les fichiers de configuration remis dans leur répertoire respectif, de s'assurer qu'il n'y ait pas d'erreur, sinon il faudra les corriger.

Cela concerne principalement les services, il faut alors d'abord surveiller leur statut :
```
sudo systemctl status <nom du service>
```

Puis regarder dans les logs :
```
sudo journalctl -u <nom du service> --no-pager -n <nombre de lignes à afficher>
```

> [!NOTE]
> Dans le cadre de ces deux commandes, il est possible d'utiliser l'option "--user", permettant ainsi de spécifier que le service est utilisateur, c'est-à-dire un service exécuté uniquement dans un contexte d'un utilisateur spécifique.

Si vous utilisez KDE Plamsa, vous pouvez accéder à une interface graphique, permettant de naviguer dans les logs système, nommée : Kjournald.