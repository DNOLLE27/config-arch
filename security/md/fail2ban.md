# Installation de Fail2Ban ([retour](../SECURITY.md))

Il s'agit d'un service qui va analyser les logs d'autres services (HTTP, SSH, ...), afin de détecter des comportements anormaux et de réaliser un ban IP.

Ce service est surtout pratique dans le cadre où vous souhaiterez réaliser de l'hébergement.

### Téléchargement de fail2ban :
```
sudo pacman -S fail2ban
```

### Configuration de /etc/fail2ban/jail.local :
```
[DEFAULT]
banaction = ufw
banaction_allports = ufw[type=allports]
ignoreip = 127.0.0.1/8 ::1 192.168.1.0/24
bantime = 3600
findtime = 600
maxretry = 5

[ufw]
enabled = true
filter = ufw.aggressive
action = ufw[type=allports]
backend = systemd
journalmatch = _TRANSPORT=kernel
maxretry = 5
bantime = 3600

[sshd]
enabled = true
backend = systemd
filter = sshd
mode = normal
port = 22
protocol = tcp
maxretry = 3
bantime = -1
```

### Configuration de /etc/fail2ban/filter.d/ufw.aggressive.conf :
```
[Definition]
failregex = ^.*\[UFW BLOCK\].*SRC=<HOST> DST=.*$
ignoreregex = 
```

### Activation du service :
```
sudo systemctl enable fail2ban.service
sudo systemctl start fail2ban.service
```