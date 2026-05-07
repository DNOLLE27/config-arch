# Installation d'Arch ([retour](../INSTALL.md))

Une fois le partitionnement réalisé et le support d'installation configuré, vous pouvez passer à l'installation d'Arch.

## Pour éviter des problèmes avec pacman/pacstrap :
```
pacman-key --init
pacman-key --populate
pacman -Sy archlinux-keyring
```

## Installation du système :

### Téléchargement minimal du système :
```
pacstrap -K /mnt base nano vi
```

> [!TIP] 
> Il est conseillé de toujours réaliser une installation minimale dans un premier temps, puis compléter l'installation en chroot.

## Configuration du système :

### Configuration des points de montage :
```
genfstab -U /mnt >> /mnt/etc/fstab
```

### Accès en chroot :
```
arch-chroot /mnt
```

### Installation des éléments de base :
```
pacman -S linux-<noyau> linux-<noyau>-headers linux-firmware networkmanager
```

> [!NOTE]
> Il existe différents noyaux supportés officiellement par Arch (Zen, Hardened, Linux, LTS, ...), ayant chacun leur propre fonctionnement, mais il est possible d'installer son propre noyau. Toutefois, il est conseillé de plutôt en utiliser un parmi ceux supportés. Vous trouverez plus d'informations dans la [documentation officiele](https://wiki.archlinux.org/title/Kernel).

### Mise à jour date/heure système :
```
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc
```

### Configuration de /etc/locale.gen :
```
# Décommenter :
fr_FR.UTF-8 UTF-8

# Puis exécuter :
locale-gen
```

### Configuration de /etc/locale.conf :
```
LANG=fr_FR.UTF-8
```

### Configuration de /etc/vconsole.conf :
```
KEYMAP=fr-latin1
```

### Configuration de /etc/hostname :
```
<Nom de la machine>
```

### Configuration Initramfs :

Si vous avez chiffré votre partition, veuillez revenir sur :

[SECURITY#encryption-disk](../../security/md/encryption-disk.md)

Sinon, vous pouvez passer à l'étape suivante.

## Installation et configuration du bootloader (systemd-boot) :

### Installation de systemd-boot :
```
bootctl install
```

### Configuration de /boot/loader/loader.conf :
```
default  arch.conf
timeout  4
console-mode max
editor   no
```

### Création des entrées :

Récupération de l'UUID de la partition racine :
```
blkid | grep  | cut -d'"' -f 2 >> /boot/loader/entries/arch.conf
```

Configuration de l'entrée de base :
```
title   Arch Linux
linux   /vmlinuz-
initrd  /initramfs-.img
options root=UUID= rw
```

Si le disque est chiffré :
```
...
options rd.luks.name== root=/dev/mapper/ rw
```

> [!CAUTION] 
> Il ne faut pas mettre l'UUID de la partition déchiffré et ouverte, mais bel et bien celui de la partition accueillant le chiffrement (celui du disque) !

Configuration /etc/mkinitcpio.d/.preset :
```
ALL_config="/etc/mkinitcpio.conf"
#PRESETS=('default')
PRESETS=('default' 'fallback')
fallback_image="..."
```

Configuration de l'entrée (fallback) :
```
cp arch.conf arch-fallback.conf

# Modifier initrd en :
initrd  /initramfs--fallback.img
```

## Installation et configuration du microcode pour le CPU :

### Téléchargement de l'image du microcode :

Si vous êtes chez AMD :
```
pacman -S amd-ucode
```

Si vous êtes chez Intel :
```
pacman -S intel-ucode
```

### Chargement du microcode :

Pour charger le microcode, deux solutions sont possibles.

Soit on réuni l'image du microcode, avec l'initramfs principal :
```
Modifier /etc/mkinitcpio.conf :
HOOKS=(... microcode autodetect ...)
```

Soit on le garde dans un fichier séparé :

On modifie d'abord les entrées du bootloader :
```
...
linux   /vmlinuz-
initrd  /amd-ucode.img
initrd  /initramfs-.img
...
```

> [!CAUTION] 
> L'ordre est important !

Puis on retire "microcode" dans les HOOKS du fichier de configuration : /etc/mkinicpio.conf.

On régénère les images :
```
mkinitcpio -P
```

> [!IMPORTANT] 
> Avec le chiffrement du disque, si jamais vous avec un processeur AMD, il se peut qu'un warning concernant le module 'qat_6xxx' puisse apparaître, ignorez le.

## Fin d'installation :

### On change le mot de passe de l'utilisateur root :
```
passwd
```

### On quitte le chroot :
```
exit
```

### On retire les points montés du support d'installation :
```
umount -R /mnt
swapoff /dev/
reboot
```