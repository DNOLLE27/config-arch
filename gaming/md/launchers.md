# Installation et configurations des launchers ([retour](../GAMING.md))

Une fois le driver de votre carte graphique et les différents outils installés et configurés, on peut enfin installer les différents launchers pour pouvoir jouer.

La particularité sous Linux est que le seul launcher natif est Steam. Pour les autres, il faudra utiliser un launcher alternatif intermédiaire. Par exemple, pour Epic Games, on utilisera Heroic Games Launcher, pour Ubisoft Connect, Itch.io, ... on utilisera Lutris.

## Installation  des launchers Linux (Steam, Litrus et Heroic Games Launcher)

```
# Steam et Lutris :
sudo pacman -S steam lutris

# Heroic Games Launcher :
flatpak install flathub com.heroicgameslauncher.hgl
```

## Installation et configuration des launchers

Il s'agit de répertorier l'installation et la configuration des launchers que j'utilisais personnellement sous Windows.

### Itch.io :

Dans Litrus :
```
Préférences > Sources > Activer Itch.io
```

Puis il suffit de se connecter et, en tentant d'installer un jeu, l'installation d'itch.io se fera.

### Ubisoft Connect :

Dans ProtonPlus, Il faut télécharger pour le launcher Litrus :
```
Wine-Stacking-Tkg (Kron4ek) - la dernière version (11.10).
```

Puis il faut lancer l'installation de Ubisoft Connect dans Lutris :
```
+ > 
Rechercher des installateurs sur le site de Lutris > 
Rechercher "Ubisoft Connect" > 
Téléchager la version "Latest".
```

Arrivé à la fin de l'installation, le setup d'installation d'Ubisoft Connect est censé se lancer.

En fonction de votre version de Proton, il se peut que celui-ci ne se lance pas, mais l'installation via Lutris se termine quand même.

Ce qu'il se passe, c'est que la version de Proton utilisée pendant l'installation peut ne pas être compatible sur le moment.

> [!NOTE] 
> Cela peut arriver pour d'autres launchers.

Il faut alors changer la version de Proton, télécharger le setup d'installation et l'exécuter dans l'environnement Wine/Proton :
```
Clic droit sur "Ubisoft Connect" > 
Configurer > 
Options de l'exécuteur > 
Dans "Version de Wine", sélectionnez la version précédemment installée > 
À côté du logo de Wine, en cliquant sur la flèche vers le haut, cliquez sur 
"Exécuter EXE dans le préfixe Wine" et sélectionnez l'installateur téléchargé sur 
le site officiel > 
Une fois installé, remettez la dernière version "par défaut".
```

### Rockstar Games :

Même principe que précédemment, sauf qu'il faut utiliser cette version de Proton :
```
GE-Proton10-29
```

### Battle.Net :

Il suffit simplement de l'installer via Lutris, aucun problème à déclarer.

### EA :

Idem que Battle.Net.