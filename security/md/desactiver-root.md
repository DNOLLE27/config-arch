# Désactivation de l'utilisateur root ([retour](../SECURITY.md))

Une bonne pratique, quelle que soit la distribution Linux, est de toujours désactiver la connexion au super-utilisateur root, afin de n'exécuter que certaines commandes avec les privilèges administrateur via la commande "sudo".

> [!IMPORTANT]
> Il vaut mieux d'utiliser la commande "sudo" à "su".

> [!NOTE]
> La commande "sudo" n'est pas installé par défaut : ```pacman -S sudo```.

### Création d'un compte utilisateur :
```
useradd -m -U <username>
passwd <username>
```

### Ajout du groupe "wheel" à notre nouvel utilisateur :
```
usermod -aG wheel <username>
```

### Ajout du groupe "wheel" en tant que sudoers :
```
nano /etc/sudoers
```

> [!CAUTION]
> Pour éviter des problèmes de syntaxe, voir de complétement corrompre le système d'authentification/sudo, il vaut mieux utiliser la commande : ```visudo```.

Il suffit de décommenter la ligne contenant "%wheel" et de modifier la règle de l'utilisateur/groupe destinataire en "root:root".

### Désactivation du login root :
```
sudo passwd -l root
sudo usermod -s /usr/bin/nologin root
```