# Discord ([retour](../SOFTWARE.md))

Cette messagerie instantanée n'a même plus besoin d'être présentée.

Toutefois, pour une raison qui m'est encore inconnue, l'autostart de KDE Plasma ne permet pas de le lancer correctement au démarrage. J'utilise alors un service systemd pour cela.

### Installation de Discord :
```
pacmam -S discord
```

### Discord au démarrage :

Service discord-on-start.service (/home/\<username>/.config/systemd/user) :
```
[Unit]
Description=Discord on start
After=graphical-session.target
Wants=graphical-session.target

[Service]
Type=simple
Environment=DBUS_SESSION_BUS_ADDRESS=unix:path=%t/bus
ExecStartPre=/bin/sleep 10
ExecStart=/usr/local/bin/discord
Restart=on-failure
RestartSec=30

[Install]
WantedBy=default.target
```

Activation du service :
```
systemctl --user daemon-reexec
systemctl --user daemon-reload
systemctl --user enable discord-on-start.service
systemctl --user start discord-on-start.service
```