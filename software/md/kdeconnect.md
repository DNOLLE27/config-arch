# KDE Connect ([retour](../SOFTWARE.md))

Il s'agit d'un logiciel permettant de connecter des appareils entre eux, son principal intérêt est de connecter votre téléphone à votre PC, à la manière du logiciel "Mobile connecté" sous Windows.

> [!IMPORTANT]
> Il y a plus de fonctionnalités avec un appareil sous Android qu'iOS.

## Installation :

### Installation des prérequis et de KDE Connect :  
```
sudo pacman -S net-tools kdeconnect qt6-declarative qt6-wayland kirigami qqc2-desktop-style kcmutils tcpdump nmap
```

### Activation et démarrage du service avahi (mDNS) :
```
sudo systemctl enable avahi-daemon
sudo systemctl start avahi-daemon
```

### Redémarrage et configuration de kdeconnectd :
```
killall kdeconnectd
rm -rf ~/.config/kdeconnect
rm -rf ~/.local/share/kdeconnect
rm -rf ~/.cache/kdeconnect*

mkdir -p ~/.config/kdeconnect
chmod 700 ~/.config/kdeconnect

sudo setcap cap_net_admin+eip /usr/bin/kdeconnectd
```

### Ban de votre appareil par Fail2Ban :

Il faut savoir que KDE Connect peut faire énormément de requêtes, il se peut que votre appareil ait été banni par Fail2Ban si vous l'avez installé. Il faut donc débannir manuellement votre appareil :
```
sudo fail2ban-client unban <ip de votre appareil>
```

> [!NOTE]
> Les configurations dans [SECURITY#Fail2Ban](../../security/md/fail2ban.md) et [SECURITY#Parfeu](../../security/md/parfeu.md) ont été changées en conséquence.

### Redémarrage du daemon de KDE Connect :
```
QT_LOGGING_RULES="kdeconnect*=true" kdeconnectd --replace
```