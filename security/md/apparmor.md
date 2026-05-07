# Installation d'AppArmor ([retour](../SECURITY.md))

AppArmor est un service implémentant le système Mandatory Access Control (MAC). 

Le principe est que nous allons avoir des profils pour chaque programme, qui vont permettre de limiter l'accès aux ressources du système de manière plus restreinte que le système par défaut sur Linux : Discretionary Access Control (DAC).

> [!IMPORTANT]
> Il ne s'agit pas d'un système qui va complétement remplacer le DAC, mais plutôt ajouter une couche de sécurité par-dessus.

### Installation d'AppArmor :
```
sudo pacman -S apparmor python-notify2 python-psutil
```

### Modification du boot loader :
```
# Ajouter dans les options du noyau :
lsm=landlock,lockdown,yama,integrity,apparmor,bpf 
apparmor=1 
security=apparmor 
audit=1
```

### Activation du service AppArmor :
```
sudo systemctl enable apparmor.service
sudo systemctl start apparmor.service
```

### Activation du service auditd :
```
sudo systemctl enable auditd.service
sudo systemctl start auditd.service
```

### Création du groupe "audit" et ajout de votre compte utilisateur dans ce groupe :
```
sudo groupadd -r audit
sudo gpasswd -a $USER audit
```

### Modification de /etc/audit/auditd.conf :
```
log_group = audit
```

### Modification de /etc/tmpfiles.d/audit.conf :
```
z /var/log/audit 750 root audit - -
```

### Création du fichier ~/.config/autostart/apparmor-notify.desktop :

Au besoin, il faut créer le répertoire "autostart" :
```
mkdir -p ~/.config/autostart
```

Puis créer le fichier "apparmor-notify.desktop" :
```
[Desktop Entry]
Type=Application
Name=AppArmor Notify
Comment=Receive on-screen notifications of AppArmor denials
TryExec=aa-notify
Exec=aa-notify -p -s 1 -w 60 -f /var/log/audit/audit.log
StartupNotify=false
NoDisplay=true
```