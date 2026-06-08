# Configuration du support d'installation ([retour](../INSTALL.md))

Avant d'installer Arch, il faut configurer le support d'installation. Cela consiste principalement en la configuration du terminal (clavier AZERTY, taille du font, ...), la connexion du support à Internet et la mise à jour de l'horloge interne.

> [!CAUTION]
> Pour l'installation d'Arch, il faut désactiver le Secure Boot et nettoyer les clés via le BIOS !

## Configuration du terminal d'installation :

### Passer le clavier en AZERTY :

```
localectl list-keymaps
loadkeys 
```

### Augmenter la taille de caractères :

```
setfont ter-132b
```

### Vérification du mode de boot :

Pour vérifier si nous sommes en UEFI (32 ou 64 bits) ou en MBR, il suffit d'exécuter la commande suivante :
```
cat /sys/firmware/efi/fw_platform_size
```

Si nous avons un retour, c'est que nous sommes bien en UEFI et on aura la précision si on est en 64 bits (64) ou en 32 bits (32).

Si nous n'avons aucun retour ou "No such file or directory", alors nous sommes en BIOS/CMS.

## Connection à Internet :

On commence par vérifier si la carte réseau est bien détectée :
```
ip link
```

Ensuite, tout dépend de comment vous voulez vous connecter à Internet :

### fillaire :

Il suffit de brancher le cable RJ45.

### sans-fil :

On commence par vérifier si la carte est bloquée :
```
rfkill
```

Si jamais elle est bloquée, il faut savoir que nous avons 2 types de blocages :

\- Matériel (hard) : 
il faut se renseigner sur la carte.

\- Logiciel (soft) : ```rfkill unblock <nom/type>```.

Pour se connecter à une box :
```
iwctl
```

Pour lister les cartes réseau disponibles :
```
device list
```

Si la carte réseau a comme valeur "off" pour la propriété "powered" :
```
device/adapter <nom> set-property Powered on
```

Scanner les réseaux :
```
station <nom> scan
```

Obtenir la liste des réseaux disponible (et leur SSID, qui est le nom du réseau) :
```
station <nom> get-networks
```

Pour se connecter au réseau :
```
station <nom> connect <SSID> 
```

Pour sortir d'iwctl :
```
exit
```

## Mise à jour de l'horloge interne :

Pour mettre l'horloge interne du système à jour, il suffit d'exécuter la commande suivante :
```
timedatectl
```