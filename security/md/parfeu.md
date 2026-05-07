# Installation d'un pare-feu ([retour](../SECURITY.md))

Par défaut, aucun pare-feu n'est installé, il faut donc en installer un et le configurer.

### Téléchargement de UFW :
```
sudo pacman -S ufw
```

### Activation du service :
```
sudo systemctl enable ufw.service
sudo systemctl start ufw.service
```

### Règles du parfeu :
```
sudo ufw limit 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw enable
```

> [!WARNING]
> Toute connexions entrantes, en dehors des protocoles HTTP, HTTPS et SSH, seront automatiquement bloqués. En fonction des logiciels/jeux, il faudra alors autoriser le port, en fonction du protocole de communication (TCP/UDP).