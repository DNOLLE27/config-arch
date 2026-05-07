# RClone ([retour](../SOFTWARE.md))

RClone est un client permettant la synchronisation et l'utilisation de vos services drives (Google Drive, Microsoft OneDrive, ...).

La procédure d'installation est complètement expliquée dans la [documentation officielle](https://rclone.org/docs/).

### Installation :
```
pacman -S rclone
```

### Configuration :

Création du remote :
```
rclone config
```

Chiffrement de la configuration :
```
rclone config encryption set
```

Configuration de KWallet pour contenir le mot de passe de la configuration chiffré : 
```
KWalletManager > Ouvrir le portefeuille (Ouvrir...) > Clique droit dans "Dossiers" > Nouveau Dossiers... > Clique droit sur "Mots de passe" > Nouveau... > config-pass > Afficher le contenu > Saisir mdp > Enregistrer
```

Script ~/.config/rclone/get_pass.sh :
```
#!/bin/bash
exec /usr/bin/kwallet-query kdewallet -f rclone -r config-pass
```

Mise à jour des permissions du script :
```
chmod u+x ~/.config/rclone/get_pass.sh
chmod go-r ~/.config/rclone/get_pass.sh
```

Service ~/.config/systemd/user/rclone-onedrive.service :
```
[Unit]
Description=Rclone Mount OneDrive
After=graphical-session.target
Wants=graphical-session.target
StartLimitIntervalSec=300
StartLimitBurst=3

[Service]
Type=simple
Environment=DBUS_SESSION_BUS_ADDRESS=unix:path=%t/bus
Environment=RCLONE_PASSWORD_COMMAND=%h/.config/rclone/get_pass.sh
ExecStartPre=/bin/sleep 10
ExecStartPre=/bin/sh -c 'for i in $(seq 1 30); do %h/.config/rclone/get_pass.sh >/dev/null 2>&1 && exit 0; sleep 2; done; exit 1'
ExecStart=/usr/bin/rclone mount rclone-onedrive: %h/OneDrive \
--config=%h/.config/rclone/rclone.conf \
--ask-password=false \
--vfs-cache-mode=writes
ExecStop=/usr/bin/fusermount3 -u %h/OneDrive
Restart=on-failure
RestartSec=30

[Install]
WantedBy=default.target
```

Création du répertoire qui va accueillir le montage du remote :
```
mkdir ~/OneDrive
```

Activation du service :
```
systemctl --user daemon-reexec
systemctl --user daemon-reload
systemctl --user enable --now rclone-onedrive
```