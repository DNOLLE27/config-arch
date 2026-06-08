# Activer le Secure Boot ([retour](../SECURITY.md))

Par défaut, nous devons désactiver le Secure Boot afin de démarrer sur le support d'installation et sur Arch, alors installé.

Pour pouvoir le réactiver, il faut alors signer les images représentant le noyau et le bootloader.

Pour simplifier le processus de signature, nous utiliserons l'outil : sbctl.

### Téléchargement de sbctl :
```
sudo pacman -S sbctl
```

### Création des clés :
```
sudo sbctl create-keys
sudo sbctl enroll-keys -m
```

> [!CAUTION]
> Lors de cette étape, il faut que le Secure Boot soit en mode Setup, c'est-à-dire que toutes les clés soient supprimées (en règle générale, dans le cadre des BIOS UEFI modernes, nous avons un bouton "Reset to Setup Mode" de disponible). 
>
> Attention à bien s'assurer que votre Secure Boot ne soit pas automatiquement alimenté au démarrage, car cela peut empêcher de passer en Setup Mode (il suffit de désactiver une option du type "Factory Key Provision") !

### Signature des images :
```
sudo sbctl sign -s /boot/vmlinuz-<noyau>
sudo sbctl sign -s /boot/EFI/BOOT/BOOTX64.EFI
sudo sbctl sign -s /boot/EFI/systemd/systemd-bootx64.efi
sudo sbctl sign -s -o /usr/lib/systemd/boot/efi/systemd-bootx64.efi.signed /usr/lib/systemd/boot/efi/systemd-bootx64.efi
```
