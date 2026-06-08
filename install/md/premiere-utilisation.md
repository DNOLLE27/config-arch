# Première utilisation ([retour](../INSTALL.md))

À partir d'ici, vous avec une nouvelle installation d'Arch prète à être configuré.

## Configurations :

La première étape consiste à configurer le système, avant d'installer votre environnement desktop. 

On commence par finir la configuration du chiffrement du disque (si réalisé), puis on configurera une connexion internet, on installera le nécessaire pour le Bluetooth, on viendra protéger notre système avec quelques solutions/configurations de sécurité, on personnalisera l'écran de démarrage et enfin, on installera l'environnement desktop.

### Configuration de TPM :

Si vous avez chiffré votre disque, il faut d'abord finir la configuration :

[SECURITY#encryption-disk](../../security/md/encryption-disk.md)

### Configuration de NetworkManager :

Par défaut, une nouvelle installation Arch n'est pas connectée à Internet. Il faut alors activer le service "networkmanager" :
```
systemctl enable NetworkManager
systemctl start NetworkManager
```

Puis se connecter à votre réseau :
```
nmcli device wifi list
nmcli device wifi connect <SSID> password <mdp>
```

### Première mise à jour du système :

Pour toute nouvelle installation, et ce, quelle que soit la distribution, il faut toujours vérifier qu'il n'y a pas de mise à jour, sinon il faut les installer : 
```
pacman -Syu
```

### Activer le Bluetooth :

Si vous avez une carte Bluetooth (intégrée ou non), il faut savoir que par défaut, elle est désactivée.

Pour pouvoir l'utiliser, il faut installer Bluez :
```
pacman -S bluez bluez-utils bluez-deprecated-tools
```

Puis activer le service "bluetooth" :
```
systemctl enable bluetooth.service
systemctl start bluetooth.service
```

### Sécurité :

Il faut savoir que par défaut, Arch ne contient aucune solution de sécurité, hormis le strict minimum offert par Linux (DAC, ...). Il faut donc prévoir d'installer et de configurer vos solutions de sécurité, en fonction de vos besoins.

Vous pouvez voir ici quelques exemples de solutions et leurs configurations :

[SECURITY](../../security/SECURITY.md)

### Personnaliser l'écran de boot :

Par défaut, lors du démarrage de l'OS, Arch affiche les boot logs. Pour pouvoir le remplacer avec un splash (animation de démarrage) personnalisé, on peut utiliser Plymouth.

> [!NOTE]
> Même si Plymouth est activé, vous pourrez toujours accéder aux logs de démarrage avec la touche "echap".

Téléchargement de Plymouth :
```
pacman -S plymouth
```

Configuration de /etc/mkinitcpio.conf :
```
modules=(amdgpu)

...

hooks=(... kms plymouth ...)
```

Paramètres du noyau (à ajouter dans les entrées du bootloader):
```
quiet splash amdgpu.modeset=1
```

> [!CAUTION]
> Les deux étapes précédentes sont à adapter en fonction de la carte graphique que vous utilisez (NVidia, Intel ou AMD).

Régénération des images initramfs :
```
sudo mkinitcpio -P
```

Pour installer un thème, il suffit d'extraire le contenu de l'archive dans :
```
/usr/share/plymouth/themes
```

Puis d'activer le thème par défaut :
```
sudo plymouth-set-default-theme -R 
```

### Installation de l'environnement de desktop :

À partir d'ici, vous pouvez installer l'environnement desktop que vous voulez. Personnellement, j'ai choisi KDE Plasma pour sa facilité d'installation, son minimalisme et son optimisation.

Procédure d'installation :

[DESKTOP](../../desktop/DESKTOP.md)

### Installation de logiciels :

À partir d'ici vous avez terminé d'installer et de configurer le système. Votre environnement est donc prêt à être utilisé.

Vous pouvez donc installer ce que vous voulez, mais afin de sauvegarder mes différents systèmes, vous trouverez des procédures d'installation de logiciels que j'utilise personnellement dans :

[SOFTWARE](../../software/SOFTWARE.md)