# Chiffrement d'un disque (LUKS/Secure Boot/TPM2)

Pour chiffrer la partition contenant le système et vos données, nous utiliserons le format LUKS et TMP2 pour contenir la clé pour l'ouvrir, afin de ne pas avoir le mot de passe à saisir à chaque redémarrage.

> [!IMPORTANT]
> Il est important de noter que pour pouvoir chiffrer le disque, il faut le réaliser au moment de l'installation d'Arch. En effet, il est impossible de le réaliser avec un système déjà installé, car le chiffrement entraînera l'effacement du disque.
>
> De plus, chaque partie de cette section est nommé avec leurs équivalents dans [INSTALL](../../install/INSTALL.md), afin que vous puissiez suivre au fur et à mesure les étapes pour pouvoir les réaliser.

## Partitionnement :

Comme dans [INSTALL#partitionnement](../../install/md/partitionnement.md), nous utiliserons l'outil cfdisk pour partitionner le disque.

```
cfdisk /dev/
```

On vient créer 2 partitions :

\- La première : correspond à la partition où sera installé le bootloader (1G).

\- La deuxième : correspond à la partition racine du système.

### Attribution d'un système de fichier pour chaque partition :
```
# Partition boot :
mkfs.fat -F 32 /dev/

# Création et ouverture de la partition chiffrée :
cryptsetup luksFormat /dev/
cryptsetup open /dev/ 

# Attribution du système de fichier pour la partition racine :
mkfs.ext4 /dev/mapper/
```

### Montage des partitions sur le support d'installation :
```
mount /dev/mapper/ /mnt
mount --mkdir /dev/ /mnt/boot
```

## Configuration Initramfs :

### Configuration de /etc/mkinitcpio.conf :
```
...
HOOKS=(... block sd-encrypt filesystems ...)
...
```

## Première utilisation : 
Pour utiliser TPM, il faut d'abord activer le Secure Boot :
[SECURITY#secure-boot](./secure-boot.md).

### Création des clés de récupération et enrôlement du TPM :
```
systemd-cryptenroll /dev/ --recovery-key
systemd-cryptenroll /dev/ --wipe-slot=empty --tpm2-device=auto --tpm2-pcrs=7+15:sha256=0000000000000000000000000000000000000000000000000000000000000000
```

> [!CAUTION]
> il faut bien prendre la partition disque et non celle ouverte ! 