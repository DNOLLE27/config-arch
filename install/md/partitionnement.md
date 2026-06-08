# Partitionnement ([retour](../INSTALL.md))

Une fois le support d'installation configuré, nous allons partitionner le disque de manière à accueillir la nouvelle installation d'Arch.

Il faut savoir que nous avons deux méthodes de partitionnement qui dépendent de si vous voulez chiffrer le disque ou non.

### Pour lister les disques :
```
lsblk
```

### Création de la table GPT :
```
fdisk /dev/<nom disque (sans le numéro de partition)>
g
w
```

À partir d'ici, nous avons deux façons de faire qui dépend de si vous voulez chiffrer votre disque ou non.

### Si vous voulez le chiffrer :

[SECURITY#encryption-disk](../../security/md/encryption-disk.md)

### Sinon :
```
cfdisk /dev/<nom disque (sans le numéro de partition)>
```

On vient créer 3 partitions :

\- La première : correspondant à la partition où sera installé le bootloader (1G).

\- La seconde : correspond à la partition SWAP (au moins 4G).

\- La dernière : correspond à la partition racine du système.

### Attribution d'un système de fichier pour chaque partition :
```
mkfs.fat -F 32 /dev/<partition boot>
mkswap /dev/<partition swap>
mkfs.ext4 /dev/<partition racine>
```

### Montage des partitions sur le support d'installation :
```
mount /dev/<partition racine> /mnt
mount --mkdir /dev/<partition boot> /mnt/boot
swapon /dev/<partition swap>
```