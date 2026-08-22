#!/bin/bash

if [[ $USER != "root" ]]; then
	echo "Seul le super-administrateur peut lancer ce script."
	exit
fi

SNAPSHOT=./snapshots/july2026
USRCONF=dnolle
HOSTCONF=hp-arch-dn

echo 'Installation des solutions de sécurités...'
echo 'Version de la snapshot : 01/07/2026'

pacman --config $SNAPSHOT/pacman-july2026 -S ufw fail2ban apparmor python-notify2 python-psutil tk rkhunter clamav libnotify inetutils ed inotify-tools which cronie libpwquality openssh lynis fakeroot net-tools bind-tools arch-audit sysstat
pacman --config $SNAPSHOT/pacman-july2026 -U $SNAPSHOT/packages/clamav-1.5.3-1-x86_64.pkg.tar.zst

echo 'Configuration de UFW...'

systemctl enable ufw
systemctl start ufw

ufw limit 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow from 192.168.1.0/24 to any port 1714:1764 proto tcp
ufw allow from 192.168.1.0/24 to any port 1714:1764 proto udp
ufw default deny incoming
ufw default allow outgoing

ufw enable

echo 'Configuration de fail2ban...'

echo 'Copie de /etc/fail2ban/jail.local...'

cp $SNAPSHOT/config/etc/fail2ban/jail.local /etc/fail2ban/

chown root:root /etc/fail2ban/jail.local
chmod 644 /etc/fail2ban/jail.local

echo FAIT

echo 'Copie de /etc/fail2ban/filter.d/ufw.aggressive.conf'

cp $SNAPSHOT/config/etc/fail2ban/filter.d/ufw.aggressive.conf /etc/fail2ban/filter.d/

chown root:root /etc/fail2ban/filter.d/ufw.aggressive.conf 
chmod 644 /etc/fail2ban/filter.d/ufw.aggressive.conf

echo FAIT

systemctl enable fail2ban
systemctl start fail2ban

echo 'Configuration de AppArmor...'

systemctl enable apparmor
systemctl start apparmor

systemctl enable auditd
systemctl start auditd

echo "Création du groupe audit et ajout de l'utilisateur $USRCONF..."

groupadd -r audit
gpasswd -a $USRCONF audit

echo FAIT

echo 'Copie de /etc/audit/auditd.conf...'

cp $SNAPSHOT/config/etc/audit/auditd.conf /etc/audit/

chown root:root /etc/audit/auditd.conf
chmod 644 /etc/etc/audit/auditd.conf

echo FAIT

echo 'Copie de /etc/tmpfiles.d/audit.conf...'

cp $SNAPSHOT/config/etc/tmpfiles.d/audit.conf /etc/tmpfiles.d/

chown root:root /etc/tmpfiles.d/audit.conf 
chmod 644 /etc/etc/tmpfiles.d/audit.conf

echo FAIT

echo 'Copie de ~/.config/autostart/apparmor-notify.desktop...'

mkdir -p /home/$USRCONF/.config/autostart
chown -R $USRCONF:$USRCONF /home/$USRCONF/.config
chmod -R 755 /home/$USRCONF/.config

cp $SNAPSHOT/config/home/username/.config/autostart/apparmor-notify.desktop /home/$USRCONF/.config/autostart/

chown root:root /home/$USRCONF/.config/autostart/apparmor-notify.desktop
chmod 644 /home/$USRCONF/.config/autostart/apparmor-notify.desktop

echo FAIT

echo 'Configuration d'antivirus...'
echo 'rkhunter...'

rkhunter --propupd
rkhunter --update
rkhunter --propupd

rkhunter --check --sk
rkhunter --config-check

echo FAIT

echo 'ClamAV...'

echo 'Copie de /etc/clamav/clamd.conf...'

cp $SNAPSHOT/config/etc/clamav/clamd.conf /etc/clamav/

chown root:root /etc/clamav/clamd.conf
chmod 644 /etc/clamav/clamd.conf

sed -i "s/<username>/$USRCONF/g" /etc/clamav/clamd.conf

echo FAIT

echo 'Création du répertoire /var/tmp/clamav-tmp...'

mkdir -p /var/tmp/clamav-tmp
chown clamav:clamav /var/tmp/clamav-tmp
chmod 700 /var/tmp/clamav-tmp

echo FAIT

echo 'Copie de /etc/clamav/exclude-list.txt...'

cp $SNAPSHOT/config/etc/clamav/exclude-list.txt /etc/clamav/

chown root:root /etc/clamav/exclude-list.txt
chmod 644 /etc/clamav/exclude-list.txt

sed -i "s/<username>/$USRCONF/g" /etc/clamav/exclude-list.txt 

echo FAIT

echo 'Copie de /usr/lib/systemd/clamav-clamonacc.service...'

cp $SNAPSHOT/config/usr/lib/systemd/system/clamav-clamonacc.service /usr/lib/systemd/system/

chown root:root /usr/lib/systemd/system/clamav-clamonacc.service
chmod 644 /usr/lib/systemd/system/clamav-clamonacc.service

echo FAIT

echo 'Copie de /etc/sudoers.d/clamav...'

cp $SNAPSHOT/config/etc/sudoers.d/clamav /etc/sudoers.d/

chown root:root /etc/sudoers.d/clamav
chmod 644 /etc/sudoers.d/clamav

echo FAIT

echo 'Copie de /etc/clamav/virus-event.bash...'

cp $SNAPSHOT/config/etc/clamav/virus-event.bash /etc/clamav/

chown root:root /etc/clamav/virus-event.bash                          
chmod 755 /etc/clamav/virus-event.bash

echo FAIT

echo 'Création du répertoire /root/quarantine...'

mkdir -p /root/quarantine

echo FAIT

echo 'Copie de /etc/clamav/freshclam.conf...'

cp $SNAPSHOT/config/etc/clamav/freshclam.conf /etc/clamav/

chown root:root /etc/clamav/freshclam.conf
chmod 644 /etc/clamav/freshclam.conf

echo FAIT

freshclam

echo 'Création du fichier /var/log/clamav/freshclam.log...'

touch /var/log/clamav/freshclam.log
chmod 600 /var/log/clamav/freshclam.log
chown clamav /var/log/clamav/freshclam.log

echo FAIT

echo 'Copie de /etc/systemd/system/clamav-clamonacc-delayed-restart.service et /etc/systemd/system/clamav-clamonacc-delayed-restart.timer...'

cp $SNAPSHOT/config/etc/systemd/system/clamav-clamonacc-delayed-restart.* /etc/systemd/system/

chown root:root /etc/systemd/system/clamav-clamonacc-delayed-restart.*
chmod 644 /etc/systemd/system/clamav-clamonacc-delayed-restart.*

echo FAIT

echo 'Copie de /etc/systemd/system/clamav-restart-on-error.service...'

cp $SNAPSHOT/config/etc/systemd/system/clamav-restart-on-error.service /etc/systemd/system/

chown root:root /etc/systemd/system/clamav-restart-on-error.service
chmod 644 /etc/systemd/system/clamav-restart-on-error.service

sed -i "s/<username>/$USRCONF/g" /etc/systemd/system/clamav-restart-on-error.service

echo FAIT

echo 'Copie de ~/Documents/scripts/clamav-restartonerr.sh...'

mkdir -p /home/$USRCONF/Documents/scripts
chown -R $USRCONF:$USRCONF /home/$USRCONF/Documents
chmod -R 755 /home/$USRCONF/Documents

cp $SNAPSHOT/config/home/username/Documents/scripts/clamav-restartonerr.sh /home/$USRCONF/Documents/scripts/

chown $USRCONF:$USRCONF /home/$USRCONF/Documents/scripts/clamav-restartonerr.sh
chmod 755 /home/$USRCONF/Documents/scripts/clamav-restartonerr.sh

echo FAIT

systemctl daemon-reload

echo 'LMD...'

git clone https://github.com/rfxn/linux-malware-detect.git

cd ./linux-malware-detect

./install.sh

cd ..

rm -Rf ./linux-malware-detect

echo 'Copie de /usr/local/maldetect/conf.maldet...'

cp $SNAPSHOT/config/usr/local/maldetect/conf.maldet /usr/local/maldetect/

chown $USRCONF:$USRCONF /usr/local/maldetect/conf.maldet
chmod 640 /usr/local/maldetect/conf.maldet

echo FAIT

echo 'Copie de /usr/local/maldetect/ignore_paths...'

cp $SNAPSHOT/config/usr/local/maldetect/ignore_paths /usr/local/maldetect/

chown $USRCONF:$USRCONF /usr/local/maldetect/ignore_paths
chmod 644 /usr/local/maldetect/ignore_paths

sed -i "s/<username>/$USRCONF/g" /usr/local/maldetect/ignore_paths

echo FAIT

echo 'Copie de /usr/local/maldetect/monitor_paths...'

cp $SNAPSHOT/config/usr/local/maldetect/monitor_paths /usr/local/maldetect/

chown $USRCONF:$USRCONF /usr/local/maldetect/monitor_paths
chmod 644 /usr/local/maldetect/monitor_paths

echo FAIT

systemctl enable clamav-daemon
systemctl start clamav-daemon

systemctl enable clamav-clamonacc
systemctl start clamav-clamonacc

systemctl enable clamav-freshclam-once.timer
systemctl start clamav-freshclam-once.timer

systemctl enable clamav-clamonacc-delayed-restart.timer
systemctl start clamav-clamonacc-delayed-restart.timer

systemctl enable clamav-restart-on-error
systemctl start clamav-restart-on-error

systemctl enable maldet
systemctl start maldet

maldet -u

echo 'Configuration de Cronie...'

systemctl enable cronie
systemctl start cronie

echo 'Copie de ~/Documents/scripts/av-scan.sh...'

cp $SNAPSHOT/config/home/username/Documents/scripts/av-scan.sh /home/$USRCONF/Documents/scripts

chown $USRCONF:$USRCONF /home/$USRCONF/Documents/scripts/av-scan.sh
chmod 755 /home/$USRCONF/Documents/scripts/av-scan.sh

echo FAIT

echo 'Configuration de ~/.bashrc pour av-scan...'

echo '' >> /home/$USRCONF/.bashrc
echo 'PATH=$PATH:~/Documents/scripts' >> /home/$USRCONF/.bashrc
echo '' >> /home/$USRCONF/.bashrc
echo 'alias av-scan=av-scan.sh' >> /home/$USRCONF/.bashrc

echo FAIT

echo 'Configuration du système...'

echo 'Copie de /etc/ssh/sshd_config...'

cp $SNAPSHOT/config/etc/ssh/sshd_config /etc/ssh/

chown root:root /etc/ssh/sshd_config
chmod 600 /etc/ssh/sshd_config

echo FAIT

echo 'Copie de /etc/sysctl.d/99-security.conf...'

cp $SNAPSHOT/config/etc/sysctl.d/99-security.conf /etc/sysctl.d/

chown root:root /etc/ssh/sshd_config
chmod 644 /etc/ssh/sshd_config

echo FAIT

sysctl --system

echo 'Copie de /etc/systemd/journald.conf...'

cp $SNAPSHOT/config/etc/systemd/journald.conf /etc/systemd/

chown root:root /etc/systemd/journald.conf
chmod 644 /etc/systemd/journald.conf

echo FAIT

systemctl restart systemd-journald

echo 'Copie de /etc/pam.d/system-auth...'

cp $SNAPSHOT/config/etc/pam.d/system-auth /etc/pam.d/

chown root:root /etc/pam.d/system-auth
chmod 644 /etc/pam.d/system-auth

echo FAIT

echo 'Copie de /etc/pam.d/passwd...'

cp $SNAPSHOT/config/etc/pam.d/passwd /etc/pam.d/

chown root:root /etc/pam.d/passwd
chmod 644 /etc/pam.d/passwd

echo FAIT

echo 'Copie de /etc/pam.d/su...'

cp $SNAPSHOT/config/etc/pam.d/su /etc/pam.d/

chown root:root /etc/pam.d/su
chmod 644 /etc/pam.d/su

echo FAIT

echo 'Copie de /etc/pam.d/su-l...'

cp $SNAPSHOT/config/etc/pam.d/su-l /etc/pam.d/

chown root:root /etc/pam.d/su-l
chmod 644 /etc/pam.d/su-l

echo FAIT

echo 'Configuration de Firejail...'

apparmor_parser -r /etc/apparmor.d/firejail-default

echo 'Copie de /etc/firejail/firejail.config...'

cp $SNAPSHOT/config/etc/firejail/firejail.config /etc/firejail/

chown root:root /etc/firejail/firejail.config
chmod 644 /etc/firejail/firejail.config

echo FAIT

echo 'Configuration de USBGuard...'

echo 'Copie de /etc/usbguard/usbguard-daemon.conf...'

cp $SNAPSHOT/config/etc/usbguard/usbguard-daemon.conf /etc/usbguard/

chown root:root /etc/usbguard/usbguard-daemon.conf
chmod 600 /etc/usbguard/usbguard-daemon.conf

sed -i "s/<username>/$USRCONF/g" /etc/usbguard/usbguard-daemon.conf

echo FAIT

echo 'Génération des règles par défaut...'

usbguard generate-policy > ./rules.conf
mv ./rules.conf /etc/usbguard/
chmod 600 /etc/usbguard/rules.conf
chown root:root /etc/usbguard/rules.conf

echo FAIT

systemctl enable usbguard
systemctl start usbguard

echo 'Configuration système avec recommandations Lynis...'

echo '[KRNL-5820]'

echo 'Copie de /etc/security/limits.conf...'

cp $SNAPSHOT/config/etc/security/limits.conf /etc/security/

chown root:root /etc/security/limits.conf
chmod 644 /etc/security/limits.conf

echo FAIT

echo '[AUTH-9230]'

echo 'Copie de /etc/login.defs...'

cp $SNAPSHOT/config/etc/login.defs /etc/

chown root:root /etc/login.defs
chmod 644 /etc/login.defs

echo FAIT

echo '[AUTH-9282] et [AUTH-9328]'

echo "Changement des règles du mot de passe de $USRCONF..."

chage -M 365 -m 1 -W 14 $USRCONF

echo FAIT

echo '[STRG-1846]'

echo 'Copie de /etc/modprobe.d/firewire.conf...'

cp $SNAPSHOT/config/etc/modprobe.d/firewire.conf /etc/modprobe.d/

chown root:root /etc/modprobe.d/firewire.conf
chmod 640 /etc/modprobe.d/firewire.conf

echo FAIT

mkinitcpio -P

echo '[PKGS-7398]'

arch-audit

echo '[NETW-3200]'

echo 'Copie de /etc/modprobe.d/disable-protocols.conf...'

cp $SNAPSHOT/config/etc/modprobe.d/disable-protocols.conf /etc/modprobe.d/

chown root:root /etc/modprobe.d/disable-protocols.conf
chmod 640 /etc/modprobe.d/disable-protocols.conf

echo FAIT

mkinitcpio -P

echo '[ACCT-9626]'

sysctemctl enable --now sysstat

echo '[TIME-3104]'

systemctl enable --now systemd-timesyncd

timedatectl status

echo '[MALW-3286]'

systemctl enable --now clamav-freshclam

echo '[NAME-4028] et [NAME-4404]'

hostnamectl set-hostname $HOSTCONF.localdomain

echo 'Copie de /etc/hosts...'

cp $SNAPSHOT/config/etc/hosts /etc/

chown root:root /etc/hosts
chmod 644 /etc/hosts

sed -i "s/<hostname>/$HOSTCONF/g" /etc/hosts

echo FAIT

echo '[BANN-7126]'

echo 'Copie de /etc/issue...'

cp $SNAPSHOT/config/etc/issue /etc/

chown root:root /etc/issue
chmod 644 /etc/issue

echo FAIT

echo 'Copie de /etc/issue.net...'

cp $SNAPSHOT/config/etc/issue.net /etc/

chown root:root /etc/issue.net
chmod 640 /etc/issue.net

echo FAIT

echo '[ACCT-9630]'

echo 'Copie de /etc/audit/rules.d/hardening.rules...'

cp $SNAPSHOT/config/etc/audit/rules.d/hardening.rules /etc/audit/rules.d/

chown root:root /etc/audit/rules.d/hardening.rules
chmod 640 /etc/audit/rules.d/hardening.rules

echo FAIT

augenrules --load
auditctl -l

echo '[FILE-7524]'

chmod 600 /etc/cron.deny
chmod 600 /etc/crontab
chmod 600 /etc/ssh/sshd_config
chmod 700 /etc/cron.d
chmod 700 /etc/cron.daily
chmod 700 /etc/cron.hourly
chmod 700 /etc/cron.weekly
chmod 700 /etc/cron.monthly

echo FAIT

echo '[KRNL-6000]'

echo 'Copie de /etc/systemd/system/log-martians.service...'

cp $SNAPSHOT/config/etc/systemd/system/log-martians.service /etc/systemd/system/

chown root:root /etc/systemd/system/log-martians.service
chmod 640 /etc/systemd/system/log-martians.service

echo FAIT

systemctl daemon-reload
systemctl enable --now log-martians.service

echo '[TIME-3185]'

echo 'Copie de /etc/systemd/timesyncd.conf.d/60-lynis.conf...'

mkdir -p /etc/systemd/timesyncd.conf.d

cp $SNAPSHOT/config/etc/systemd/timesyncd.conf.d/60-lynis.conf /etc/systemd/timesyncd.conf.d/

chown root:root /etc/systemd/timesyncd.conf.d/60-lynis.conf
chmod 644 /etc/systemd/timesyncd.conf.d/60-lynis.conf
chmod 755 /etc/systemd/timesyncd.conf.d

systemctl restart systemd-timesyncd

echo '/!\ Attention ! /!\'
echo 'Ce qui n'a pas été géré par le script :'
echo '	- Configuration du crontab pour av-scan.sh.'
echo '	- Configuration général de firejail (liens symboliques).'
echo "	- Changer le mot de passe de $USRCONF pour que les règles modifiées soient appliquées."
echo '	- Lynis : [FINT-4350], [ACCT-9622], [HTTP-6640], [HTTP-6643], [PHP-2372], [PHP-2376] et [HRDN-7222].'
