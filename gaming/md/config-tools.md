# Configuration et outils ([retour](../GAMING.md))

L'objectif est de répertorier les procédures d'installation et de configuration des différents outils utiles pour le Gaming.

## LACT

Il s'agit d'un logiciel permettant l'overclocking et le contrôle des ventilateurs de la carte graphique, à la manière de MSI Afterburner.

### Installation :

```
sudo pacman -S lact
```

### Activation et démarrage du daemon :

```
sudo systemctl enable --now lactd
```

## OpenRazer/Polychromatic

OpenRazer est le driver open source des péripĥériques (clavier, souris, ...) de la marque Razer, développé pour Linux.

Polychromatic est un logiciel permettant le contrôle du RGB sur le matériels Razer, à la manière de Synapse/Chroma.

### Installation d'OpenRazer :

Installation du driver :
```
sudo pacman -S openrazer-daemon
```

Création et ajout de l'utilisateur courant au groupe "plugdev" :
```
sudo groupadd plugdev
sudo gpasswd -a $USER plugdev
```

### Installation de Polychromatic :

Installation des prérequis :
```
sudo pacman -S fakeroot debugedit
```

Installation de Polychromatic :
```
git clone https://aur.archlinux.org/polychromatic.git
cd polychromatic/
makepkg -si
```

Ajout de l'utilisateur courant au groupe "openrazer" :
```
sudo gpasswd -a $USER openrazer
```

## Gamemode, Gamescope, Mangohud, Goverlay et ProtonPlus

Il s'agit d'un ensemble d'outils permettant l'optimisation, que ce soit en jeu ou pour la configuration du système.

Gamemode : permet l'optimisation du système lors du lancement d'un jeu. On peut configurer les optimisations réalisées, mais on se contentera des optimisations par défaut.

Gamescope : est un micro-compositeur Wayland développé par Valve, notamment utilisé sur le Steam Deck. Il permet de lancer un jeu dans un environnement isolé avec des paramètres spécifiques (résolution, limitation du nombre d'images par seconde, mise à l'échelle, HDR, etc.).

Mangohud : permet d'afficher des informations système (températures, FPS, ...) en jeu.

Goverlay : est une interface graphique permettant la configuration de Mangohud.

ProtonPlus : gestionnaire des versions de Wine/Proton en fonction du launcher.

### Installation :

Gamemode, Gamescope, Mangohud et Goverlay :
```
sudo pacman -S gamemode lib32-gamemode gamescope mangohud lib32-mangohud goverlay
sudo usermod -aG gamemode $USER
```

ProtonPlus :
```
flatpak install flathub com.vysp3r.ProtonPlus
```

## Configuration ClamAV/LMD :

Ajout de répertoires aux exclusions :
```
/home/<username>/Games
/home/<username>/.local/share/umu
/home/<username>/.local/share/lutris
/home/<username>/.local/share/Steam
/home/<username>/.local/share/Steam/compatibilitytools.d/GE-Proton10-34/files
/home/<username>/.cache/net.lutris.Lutris/WebKitCache
```