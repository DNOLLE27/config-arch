# Virtualbox ([retour](../SOFTWARE.md))

Il s'agit d'un Hyperviseur, créé par Oracle, permettant de créer et de gérer des VM avec la possibilité d'installer n'importe quel OS.

### Installation :

Installation des différents paquets :
```
pacman -S virtualbox virtualbox-host-dkms
```

Ajout de notre utilisateur au groupe vboxusers :
```
sudo usermod -aG vboxusers $USER
```

Si jamais vous avez les profils par défaut de Firejail d'activés, il faut désactiver le profile pour VirtualBox :
```
sudo rm -f /usr/local/bin/VirtualBox
sudo rm -f /usr/local/bin/virtualbox
sudo rm -f /usr/local/bin/VirtualBoxVM
sudo rm -f /usr/local/bin/VBoxHeadless
sudo rm -f /usr/local/bin/VBoxManage
```

### Erreur lors du build du driver :

Si jamais vous avez une erreur lors du build du driver, il existe un patch permettant de le corriger.

Il suffit de télécharger le patch :

https://build.opensuse.org/projects/Virtualization/packages/virtualbox/files/kernel-6.19.patch

Puis de rechercher certains fichiers qui peuvent ne pas être installés dans les mêmes répertoires que ceux du patch :
```
find . \( -name 'SUPDrv-linux.c' -o -name 'initterm-r0drv-linux.c' -o -name 'memobj-r0drv-linux.c' -o -name 'the-linux-kernel.h' \)
```

De corriger les chemins du patch :
```
sed -i \
-e 's|a/src/VBox/HostDrivers/Support/linux/SUPDrv-linux.c|a/vboxdrv/linux/SUPDrv-linux.c|' \
-e 's|b/src/VBox/HostDrivers/Support/linux/SUPDrv-linux.c|b/vboxdrv/linux/SUPDrv-linux.c|' \
-e 's|a/src/VBox/Runtime/r0drv/linux/initterm-r0drv-linux.c|a/vboxdrv/r0drv/linux/initterm-r0drv-linux.c|' \
-e 's|b/src/VBox/Runtime/r0drv/linux/initterm-r0drv-linux.c|b/vboxdrv/r0drv/linux/initterm-r0drv-linux.c|' \
-e 's|a/src/VBox/Runtime/r0drv/linux/memobj-r0drv-linux.c|a/vboxdrv/r0drv/linux/memobj-r0drv-linux.c|' \
-e 's|b/src/VBox/Runtime/r0drv/linux/memobj-r0drv-linux.c|b/vboxdrv/r0drv/linux/memobj-r0drv-linux.c|' \
-e 's|a/src/VBox/Runtime/r0drv/linux/the-linux-kernel.h|a/vboxdrv/r0drv/linux/the-linux-kernel.h|' \
-e 's|b/src/VBox/Runtime/r0drv/linux/the-linux-kernel.h|b/vboxdrv/r0drv/linux/the-linux-kernel.h|' \
~/Téléchargements/kernel-6.19.arch.patch
```

Et enfin, de tester et appliquer le patch depuis le répertoire /usr/src/vboxhost-7.2.6_OSE :

```
sudo patch -p1 --dry-run  [!WARNING]
> Il se peut que le patch ne soit plus valable (soit parce qu'il n'est plus d'actualité pour votre version de noyau ou de VirtualBox, soit parce que les dernières mises à jours de VirtuaBox corrigerons le problème pour votre noyau).