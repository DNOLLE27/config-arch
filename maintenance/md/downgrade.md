# Comment downgrade des paquets ? ([retour](../MAINTENANCE.md))

Lors des mises à jour, il se peut que certains paquets cessent de fonctionner, ce qui peut être dû, par exemple, à un problème avec une dépendance dysfonctionnelle.

Il peut alors être judicieux de revenir à une version précédente (que ce soit le paquet spécifique, ses dépendances ou le système complet) de manière temporaire, jusqu'à ce qu'une nouvelle version sorte, corrigeant le problème.

## Downgrade :

Le principe de downgrade (action inverse de upgrade) consiste à la réinstallation d'une version précédente d'un paquet. Nous avons deux possibilités :

\- Downgrade manuel (paquet spécifique) :
```
wget https://archive.archlinux.org/packages/<première lettre>/<nom paquet>
sudo pacman -U <archive>
```

\- Downgrade de pacman :

L'objectif est que l'on va utiliser une snapshot, c'est à dire une version spécifique, en général correspondant à une date, du gestionnaire de paquets.

Configuration d'une snapshot :
```
[options]
Architecture = auto
SigLevel = Required DatabaseOptional
LocalFileSigLevel = Optional

[core]
Server = https://archive.archlinux.org/repos/AAAA/MM/JJ/core/os/$arch

[extra]
Server = https://archive.archlinux.org/repos/AAAA/MM/JJ/extra/os/$arch
```

Dès lors, nous pouvons utiliser la snapshot de plusieurs façons :

\- En mettant à jour uniquement les paquets avec une version encore plus ancienne :
```
pacman --config <config snapshot> -Syu
```

> [!WARNING]
> Les paquets ayant une version plus récente ne seront pas downgradés !

\- En forçant le downgrade de tout le système :
```
pacman --config <config snapshot> -Syyuu
```

\- En installant un ou plusieurs paquets spécifiques :
```
pacman --config <config snapshot> -S <liste de paquets>
```

## Zone de test avec une snapshot :

Il faut savoir que vous avez la possibilité de réaliser une installation vierge d'Arch dans un répertoire et de l'utiliser en chroot.

Cela permet d'installer temporairement un système Arch, sans passer par une VM et sans toucher au système hôte, avec la possibilité de configurer une snapshot afin d'avoir un environnement d'exécution correspondant à une date précise. 

Ce qui permet de tester et déterminer ce qui ne fonctionne plus avec un paquet (paquet principal, dépendances...).

> [!WARNING]
> Les systèmes hôte et chroot peuvent partager certains éléments (noyau, ...). 
>
> Toutefois, tout ce que vous installez dans le système chroot ne sera conservé que dans le répertoire de ce dernier.

### Installation des prérequis :

```
sudo pacman -S arch-install-scripts
```

### Création et installation d'un système de test :

Il suffit de créer un répertoire et, dans celui-ci, d'installer le paquet ```base``` avec pacstrap :
```
sudo pacstrap -C <config snapshot> <répertoire cible> base
```

Puis de monter le répertoire sur lui-même afin de pouvoir utiliser pacman en chroot :
```
sudo mount --bind <répertoire cible> <répertoire cible lui-même>
```

Enfin, on accède au système en chroot :
```
sudo arch-chroot <répertoire cible>
```

## Lister les dépendances d'un paquet :

Pour lister les dépendances d'un paquet, nous avons deux possibilités :
```
pacman -Qi <paquet>

# OU

pactree <paquet> # (Il faut installer le paquet : pacman-contrib)
```

Pour lister les versions des dépendances directes d'un paquet :
```
pactree -d 1 -u <paquet> | taile -n+2 | xargs -r pacman -Q
```

Pour lister les bibliothèques chargées :
```
ldd <chemin vers binaire>
```

## Empêcher la mise à jour d'un paquet avec pacman :

Pour dela, il suffit d'éditer le fichier ```/etc/pacman.conf```, de la manière suivante :
```
[options]
...
IgnorePkg = <paquet(s) espacés>
...
```