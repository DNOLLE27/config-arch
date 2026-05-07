# USBGuard ([retour](../SECURITY.md))

Il s'agit d'un service permettant de bloquer les supports USB non reconnu, branché sur le système. Il se base sur une whitelist, que l'on devra mettre à jour pour autoriser de nouveau support.

> [!WARNING]
> Lorsque vous arriverez à l'étape d'activation et de démarrage du service, il faudra au préalable générer la liste de tous les supports présents sur le système. Sinon, cela peut bloquer le clavier, la souris et la carte Bluetooth.

## Installation d'USBGuard :

### Téléchargement d'USBGuard :
```
pacman -S usbguard usbutils
```

### Configuration de /etc/usbguard/usbguard-daemon.conf :
```
IPCAllowedUsers=... 
```

### Activation du service :
```
sudo systemctl enable usbguard.service
sudo systemctl start usbguard.service
```

## Utilisation d'USBGuard :
Autoriser un appareil USB de manière temporaire :
```
# Lister les appareils USB actuellement connectés (permet d'obtenir leur id) :
lsusb

# Autoriser un appareil :
usbguard allow-device 
```

Autoriser un appareil USB de manière persistante :
```
usbguard generate-policy > ./rules.conf
sudo mv ./rules.conf /etc/usbguard/
```