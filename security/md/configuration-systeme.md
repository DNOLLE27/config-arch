# Configurations système ([retour](../SECURITY.md))

### Configuration de /etc/ssh/sshd_config :
```
# Modifier les lignes :
PasswordAuthentication no
PermitRootLogin no
UsePAM no
```

> [!IMPORTANT]
> Le paquet ```openssh``` doit être installé (pour avoir à la fois le client et le serveur).

### Configuration de sysctl :

Configuration de /etc/sysctl.d/99-security.conf :
```
# Protection réseau
# IPv4
net.ipv4.ip_forward=0

net.ipv4.conf.all.accept_redirects=0
net.ipv4.conf.default.accept_redirects=0

net.ipv4.conf.all.send_redirects=0
net.ipv4.conf.default.send_redirects=0

net.ipv4.conf.all.secure_redirects=0
net.ipv4.conf.default.secure_redirects=0

net.ipv4.conf.all.accept_source_route=0

net.ipv4.conf.all.rp_filter=1
net.ipv4.conf.default.rp_filter=1

net.ipv4.tcp_syncookies=1

net.ipv4.conf.default.log_martians=1
net.ipv4.conf.all.log_martians=1

# IPv6
net.ipv6.conf.all.accept_redirects=0
net.ipv6.conf.default.accept_redirects=0

# Protection mémoire
kernel.randomize_va_space=2

# Logs kernel
kernel.dmesg_restrict=1
kernel.kptr_restrict=2

# Protection symlink
fs.protected_symlinks=1
fs.protected_hardlinks=1

# BPF
net.core.bpf_jit_harden=2
kernel.unprivileged_bpf_disabled=1

# Restrict Module Loading
module.sig_enforce=1

# Disable kexec
kernel.kexec_load_disabled = 1

# Flatpak namespace
kernel.unprivileged_userns_clone=1
```

Mise à jour des règles sysctl :
```
sudo sysctl --system
```

### Configuration du logging centralisé :
Configuration de /etc/systemd/journald.conf :
```
# Modifier les lignes :
Storage=persistent
SystemMaxUse=500M
```

Relancer le service journald :
```
sudo systemctl restart systemd-journald
```

### Renforcement de la politique PAM pour les mots de passes :

Installation du paquet libpwquality :
```
sudo pacman -S libpwquality
```

Modification de /etc/pam.d/passwd :
```
#%PAM-1.0
...
password	require		pam_quality.so retry=2 minlen=10 difok=6 dcredit=-1 ucredit=-1 ocredit=-1 lcredit=-1 [badwords=myservice mydomain] enforce_for_root
password	require		pam_unix.so use_authtok sha512 shadow
```

### Autoriser uniquement les utilisateurs du groupe "wheel" à utiliser la commande "su" :

Configuration de /etc/pam.d/su et /etc/pam.d/su-l :
```
# Décomenter la ligne : 
auth required pam_wheel.so use_uid
```

### Modifcation du boot loader :
```
# Ajoutez dans les options du noyau :
loglevel=3
slab_nomerge
init_on_alloc=1
init_on_free=1
mitigations=auto,nosmt
```