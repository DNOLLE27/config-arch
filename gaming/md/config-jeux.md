# Configuration de jeux ([retour](../GAMING.md))

Contrairement à Windows, vous serez souvent amené à modifier la configuration pour chaque jeu, que ce soit des options de lancement ou pour changer la version de Proton.

En règle générale, il faut se renseigner sur [ProtonDB](https://www.protondb.com/) pour connaître la configuration à adopter.

L'objectif global est de configurer de manière à avoir Mangohud, Gamemode et Gamescope utilisés, et de s'assurer d'utiliser une version de Proton avec laquelle le jeu fonctionne.

> [!WARNING] 
> Sur les anciens jeux, il faut éviter d'utiliser Gamescope. Et pour les autres, il faut penser à installer la lib32.
>
> Pour certains jeux, le DLSS, et plus précisément le Frame Gen, peut ne pas fonctionner correctement. Toutefois, l'upscaling semble fonctionner.

## Steam :

### Configuration de la version de Proton :

Pour sélectionner la version de Proton à utiliser de manière globale :
```
Steam > Paramètres > Compatibilité.
```

Pour sélectionner une version de Proton à utiliser pour un jeu spécifique :
```
Clique droit sur le jeu > Propriétés... > Compatibilité.
```

Pour préciser des options de lancement :
```
Clique droit sur le jeu > Propriétés... > Général > Options de lancement.
```

### Quelques exemples d'options de lancement par jeu :

L'utilisation des options de lancement permet de configurer le lancement d'un jeu avec Gamemode, Gamescope et Mangohud, en plus de corriger certains problèmes.

Pragmata :
```
PROTON_ENABLE_WAYLAND=1 PROTON_USE_NTSYNC=1 PROTON_ENABLE_NVAPI=1 PROTON_ENABLE_HDR=1 PROTON_DLSS_UPGRADE=1 MANGOHUD=1 gamemoderun gamescope -W 1920 -H 1080 -r 180 -f -- %command% /WineDetectionEnabled:False
```

Postal 2 :
```
mangohud gamemoderun %command%
```

## Litrus :

Pour configurer Gamemode, Gamescope, Mangohud et Proton, tout se passe via l'interface graphique. Il suffit de faire :
```
Clique droit sur le jeu > Configurer > Options système > Avancé.
```

## Heroic Games Launcher :

Comme pour Litrus, la configuration se fait directement depuis l'interface graphique. Toutefois, nous devons installer Mangohud et Gamescope dans l'environnement sandboxé du launcher (même s'ils sont installés sur le système).

Pour obtenir la version du runtime :
```
flatpak info com.heroicgameslauncher.hgl
```

Pour installer les versions de Gamescope et Mangohud, correspondant à la version du runtime :
```
flatpak install flathub org.freedesktop.Platform.VulkanLayer.MangoHud//<version runtime>
flatpak install flathub org.freedesktop.Platform.VulkanLayer.gamescope//<version runtime>
```