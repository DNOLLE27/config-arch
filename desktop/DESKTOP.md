# Environnement desktop ([retour](../README.md))

Par défaut, Arch est en CLI uniquement, pour avoir un environnement desktop graphique, il faut alors installer tous les éléments nécessaires.

KDE Plasma, en plus d'être adapté pour le gaming, permet d'installer tout le nécessaire en un seul paquet.

Par défaut, KDE Plasma utilise Wayland, mais il est possible d'utiliser Xorg en installant le serveur graphique et tout le nécessaire.

> [!IMPORTANT]
> À partir de la version 6.8, KDE Plasma abandonnera la prise en charge de Xorg (X11).

## Installation de KDE Plasma :

KDE Plasma est disponible en plusieurs paquets, chacun ayant leur propre utilité.

Par défaut, les trois paquets ne contiennent aucune autre application que le strict nécessaire pour faire tourner l'environnement.

### plasma/plasma-meta :

Les deux paquets permettent d'installer l'environnement et tout ce qu'il faut pour directement l'utiliser.

La différence entre plasma et plasma-meta est que l'un est un paquet group permettant de tout installer, y compris les dépendances. L'autre est un paquet meta, certaines dépendances peuvent donc être manquantes, empêchant ainsi le fonctionnement de certaines fonctionnalités :

```
sudo pacman -S plasma|plasma-meta
```

### plasma-desktop :

Ce paquet est la version la plus minimaliste de plasma, il faudra alors installer et configurer tout ce qui peut manquer :

```
sudo pacman -S plasma-desktop
```

## Activation du display manager :

Pour cela, il faut l'installer et l'activer, dans le cadre de KDE Plasma, vous pouvez soit utiliser SDDM, soit Plasma Login Manager.

### plasma/plasma-meta :

Par défaut, les deux sont automatiquement installés, il faut alors activer et démarrer le service de l'un des deux uniquement :

```
sudo systemctl enable sddm.service|plasmalogin.service
sudo systemctl start sddm.service|plasmalogin.service
```

### Passer SDDM en AZERTY :
```
sudo localectl set-x11-keymap fr
``` 

### Condiguration de /etc/sddm.conf :
``` 
[General]
InputMethod=

[Keyboard]
Layout=fr
``` 

### plasma-desktop :

Il faudra d'abord l'installer, avant de le démarrer de la même manière que précédemment.

## Installation des logiciels

Par défaut, aucun logiciel n'est installé, quel que soit le paquet que vous ayez installé. Il faudra alors soit les télécharger un à un :
```
sudo pacman -S dolphin konsole kjournald isoimagewriter kalk kclock sweeper partitionmanager spectacle kfind kwalletmanager kinfocenter kmenuedit kweather kate filelight ark okular gwenview
```

Ou installer le paquet de logiciels proposé par la team KDE :
```
sudo pacman -S kde-applications-meta|kde-applications
```

## Configurations :

### Activer numlock par défaut :

Pour activer numlock sur le bureau et sur l'authentification, il faut d'abord privilégier SDDM à Plasma Login Manager, puis il faut configurer /etc/sddm.conf :
```
[General]
Numlock=on
```

Puis dans "Configuration du système" :
```
Entrées & Sorties > Clavier > Verrouillage numérique au démarrage : Activer > Appliquer
```

> [!IMPORTANT]
> Pour que cela fonctionne, il faut que le service "Démons du clavier" soit activé et démarré. Pour vérifier si c'est le cas, il faut exécuter la commande : ```kcmshell6 kcm_kded```.