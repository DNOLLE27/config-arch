# Troubleshooting ([retour](../INSTALL.md))

Cette section répertorie les différents problèmes que j'ai pu rencontrer lors de l'installation d'Arch et leurs solutions.

## Terminal du support d'installation :

### 1. Problème de saisie dans le terminal :

Lors de l'utilisation du terminal, en se trompant sur une commande par exemple, il se peut que le terminal affiche un nombre à côté du nom d'utilisateur.

### Solution :

Vous pouvez soit utiliser la commande suivante :
```
stty sane
```

soit tout simplement corriger la commande avant de l'exécuter de nouveau.

## BootCTL

### 1. Couldn't find EFI system partition :

Avec les commandes : ```bootctl status``` ou ```bootctl list```, vous obtenez une erreur du type : ```Couldn't find EFI system partition```.

### Solution :

Installation des prérequis :
```
pacman -S gdisk efibootmgr
```

Correction du type de la partition :
```
gdisk /dev/
t
1
ef00
w
```

Réinstallation de systemd-boot :
```
bootctl --esp-path=/boot install
```

Il faut ensuite régénérer l'entrée du boot manager :

Si elle existe :
```
efibootmgr
efibootmgr -b XXXX -B
```

Puis :
```
efibootmgr --create --disk /dev/nvme0n1 --part 1 --label "Linux Boot Manager" --loader '\EFI\systemd\systemd-bootx64.efi'
efibootmgr
```

Enfin, on donne la priorité à notre nouvelle entrée et on redémarre le système :
```
efibootmgr -o XXXX
reboot
```