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

### Signature des images :
```
sudo sbctl sign -s /boot/vmlinuz-<noyau>
sudo sbctl sign -s /boot/EFI/BOOT/BOOTX64.EFI
sudo sbctl sign -s /boot/EFI/systemd/systemd-bootx64.efi
sudo sbctl sign -s -o /usr/lib/systemd/boot/efi/systemd-bootx64.efi.signed /usr/lib/systemd/boot/efi/systemd-bootx64.efi
```
