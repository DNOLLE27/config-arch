#!/bin/bash

if [[ $USER != "root" ]]; then
	echo "Seul le super-administrateur peut lancer ce script."
	exit
fi

SCRIPTDIR=$(dirname $0)
CONFIGDIR=$SCRIPTDIR/config-arch
BACKUPDIR=$CONFIGDIR/backup
SNAPDIR=$SCRIPTDIR/snapshots/july2026
SLEEPTPS=0.5
USRCONF=dnolle
HOSTCONF=hp-arch-dn

echo 'Installation des solutions de sécurités...'
sleep $SLEEPTPS

echo 'Version de la snapshot : 01/07/2026'
sleep $SLEEPTPS

git clone https://github.com/DNOLLE27/config-arch.git $CONFIGDIR

pacman --config $SNAPDIR/pacman-july2026 -S ufw fail2ban apparmor python-notify2 python-psutil tk rkhunter clamav libnotify inetutils ed inotify-tools which cronie libpwquality openssh firejail firetools usbguard usbutils lynis fakeroot net-tools bind-tools arch-audit sysstat 
pacman --config $SNAPDIR/pacman-july2026 -U $SNAPDIR/packages/clamav-1.5.3-1-x86_64.pkg.tar.zst

echo 'Configuration de UFW...'
sleep $SLEEPTPS

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
sleep $SLEEPTPS

echo 'Copie de /etc/fail2ban/jail.local...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/fail2ban/jail.local /etc/fail2ban/

chown root:root /etc/fail2ban/jail.local
chmod 644 /etc/fail2ban/jail.local

echo FAIT
sleep $SLEEPTPS

echo 'Copie de /etc/fail2ban/filter.d/ufw.aggressive.conf'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/fail2ban/filter.d/ufw.aggressive.conf /etc/fail2ban/filter.d/

chown root:root /etc/fail2ban/filter.d/ufw.aggressive.conf 
chmod 644 /etc/fail2ban/filter.d/ufw.aggressive.conf

echo FAIT
sleep $SLEEPTPS

systemctl enable fail2ban
systemctl start fail2ban

echo 'Configuration de AppArmor...'
sleep $SLEEPTPS

systemctl enable apparmor
systemctl start apparmor

systemctl enable auditd
systemctl start auditd

echo "Création du groupe audit et ajout de l'utilisateur $USRCONF..."
sleep $SLEEPTPS

groupadd -r audit
gpasswd -a $USRCONF audit

echo FAIT
sleep $SLEEPTPS

echo 'Copie de /etc/audit/auditd.conf...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/audit/auditd.conf /etc/audit/

chown root:root /etc/audit/auditd.conf
chmod 644 /etc/audit/auditd.conf

echo FAIT
sleep $SLEEPTPS

echo 'Copie de /etc/tmpfiles.d/audit.conf...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/tmpfiles.d/audit.conf /etc/tmpfiles.d/

chown root:root /etc/tmpfiles.d/audit.conf 
chmod 644 /etc/tmpfiles.d/audit.conf

echo FAIT
sleep $SLEEPTPS

echo 'Copie de ~/.config/autostart/apparmor-notify.desktop...'
sleep $SLEEPTPS

mkdir -p /home/$USRCONF/.config/autostart
chown -R $USRCONF:$USRCONF /home/$USRCONF/.config
chmod -R 755 /home/$USRCONF/.config

cp $BACKUPDIR/home/username/.config/autostart/apparmor-notify.desktop /home/$USRCONF/.config/autostart/

chown root:root /home/$USRCONF/.config/autostart/apparmor-notify.desktop
chmod 644 /home/$USRCONF/.config/autostart/apparmor-notify.desktop

echo FAIT
sleep $SLEEPTPS

echo "Configuration d'antivirus..."
sleep $SLEEPTPS

echo 'rkhunter...'
sleep $SLEEPTPS

rkhunter --propupd
rkhunter --update
rkhunter --propupd

rkhunter --config-check

echo FAIT
sleep $SLEEPTPS

echo 'ClamAV...'
sleep $SLEEPTPS

echo 'Copie de /etc/clamav/clamd.conf...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/clamav/clamd.conf /etc/clamav/

chown root:root /etc/clamav/clamd.conf
chmod 644 /etc/clamav/clamd.conf

sed -i "s/<username>/$USRCONF/g" /etc/clamav/clamd.conf

echo FAIT
sleep $SLEEPTPS

echo 'Création du répertoire /var/tmp/clamav-tmp...'
sleep $SLEEPTPS

mkdir -p /var/tmp/clamav-tmp
chown clamav:clamav /var/tmp/clamav-tmp
chmod 700 /var/tmp/clamav-tmp

echo FAIT
sleep $SLEEPTPS

echo 'Copie de /etc/clamav/exclude-list.txt...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/clamav/exclude-list.txt /etc/clamav/

chown root:root /etc/clamav/exclude-list.txt
chmod 644 /etc/clamav/exclude-list.txt

sed -i "s/<username>/$USRCONF/g" /etc/clamav/exclude-list.txt 

echo FAIT
sleep $SLEEPTPS

echo 'Copie de /usr/lib/systemd/clamav-clamonacc.service...'
sleep $SLEEPTPS

cp $BACKUPDIR/usr/lib/systemd/system/clamav-clamonacc.service /usr/lib/systemd/system/

chown root:root /usr/lib/systemd/system/clamav-clamonacc.service
chmod 644 /usr/lib/systemd/system/clamav-clamonacc.service

echo FAIT
sleep $SLEEPTPS

echo 'Copie de /etc/sudoers.d/clamav...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/sudoers.d/clamav /etc/sudoers.d/

chown root:root /etc/sudoers.d/clamav
chmod 644 /etc/sudoers.d/clamav

echo FAIT
sleep $SLEEPTPS

echo 'Copie de /etc/clamav/virus-event.bash...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/clamav/virus-event.bash /etc/clamav/

chown root:root /etc/clamav/virus-event.bash                          
chmod 755 /etc/clamav/virus-event.bash

echo FAIT
sleep $SLEEPTPS

echo 'Création du répertoire /root/quarantine...'
sleep $SLEEPTPS

mkdir -p /root/quarantine

echo FAIT
sleep $SLEEPTPS

echo 'Copie de /etc/clamav/freshclam.conf...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/clamav/freshclam.conf /etc/clamav/

chown root:root /etc/clamav/freshclam.conf
chmod 644 /etc/clamav/freshclam.conf

echo FAIT
sleep $SLEEPTPS

freshclam

echo 'Création du fichier /var/log/clamav/freshclam.log...'
sleep $SLEEPTPS

touch /var/log/clamav/freshclam.log
chmod 600 /var/log/clamav/freshclam.log
chown clamav /var/log/clamav/freshclam.log

echo FAIT
sleep $SLEEPTPS

echo 'Copie de /etc/systemd/system/clamav-clamonacc-delayed-restart.service et /etc/systemd/system/clamav-clamonacc-delayed-restart.timer...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/systemd/system/clamav-clamonacc-delayed-restart.* /etc/systemd/system/

chown root:root /etc/systemd/system/clamav-clamonacc-delayed-restart.*
chmod 644 /etc/systemd/system/clamav-clamonacc-delayed-restart.*

echo FAIT
sleep $SLEEPTPS

echo 'Copie de /etc/systemd/system/clamav-restart-on-error.service...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/systemd/system/clamav-restart-on-error.service /etc/systemd/system/

chown root:root /etc/systemd/system/clamav-restart-on-error.service
chmod 644 /etc/systemd/system/clamav-restart-on-error.service

sed -i "s/<username>/$USRCONF/g" /etc/systemd/system/clamav-restart-on-error.service

echo FAIT
sleep $SLEEPTPS

echo 'Copie de ~/Documents/scripts/clamav-restartonerr.sh...'
sleep $SLEEPTPS

mkdir -p /home/$USRCONF/Documents/scripts
chown -R $USRCONF:$USRCONF /home/$USRCONF/Documents
chmod -R 755 /home/$USRCONF/Documents

cp $BACKUPDIR/home/username/Documents/scripts/clamav-restartonerr.sh /home/$USRCONF/Documents/scripts/

chown $USRCONF:$USRCONF /home/$USRCONF/Documents/scripts/clamav-restartonerr.sh
chmod 755 /home/$USRCONF/Documents/scripts/clamav-restartonerr.sh

echo FAIT
sleep $SLEEPTPS

systemctl daemon-reload

echo 'LMD...'
sleep $SLEEPTPS

git clone https://github.com/rfxn/linux-malware-detect.git $SCRIPTDIR/linux-malware-detect

cd $SCRIPTDIR/linux-malware-detect

./install.sh

cd $SCRIPTDIR

rm -Rf $SCRIPTDIR/linux-malware-detect

echo 'Copie de /usr/local/maldetect/conf.maldet...'
sleep $SLEEPTPS

cp $BACKUPDIR/usr/local/maldetect/conf.maldet /usr/local/maldetect/

chown $USRCONF:$USRCONF /usr/local/maldetect/conf.maldet
chmod 640 /usr/local/maldetect/conf.maldet

echo FAIT
sleep $SLEEPTPS

echo 'Copie de /usr/local/maldetect/ignore_paths...'
sleep $SLEEPTPS

cp $BACKUPDIR/usr/local/maldetect/ignore_paths /usr/local/maldetect/

chown $USRCONF:$USRCONF /usr/local/maldetect/ignore_paths
chmod 644 /usr/local/maldetect/ignore_paths

sed -i "s/<username>/$USRCONF/g" /usr/local/maldetect/ignore_paths

echo FAIT
sleep $SLEEPTPS

echo 'Copie de /usr/local/maldetect/monitor_paths...'
sleep $SLEEPTPS

cp $BACKUPDIR/usr/local/maldetect/monitor_paths /usr/local/maldetect/

chown $USRCONF:$USRCONF /usr/local/maldetect/monitor_paths
chmod 644 /usr/local/maldetect/monitor_paths

echo FAIT
sleep $SLEEPTPS

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
sleep $SLEEPTPS

systemctl enable cronie
systemctl start cronie

echo 'Copie de ~/Documents/scripts/av-scan.sh...'
sleep $SLEEPTPS

cp $BACKUPDIR/home/username/Documents/scripts/av-scan.sh /home/$USRCONF/Documents/scripts

chown $USRCONF:$USRCONF /home/$USRCONF/Documents/scripts/av-scan.sh
chmod 755 /home/$USRCONF/Documents/scripts/av-scan.sh

echo FAIT
sleep $SLEEPTPS

echo 'Configuration de ~/.bashrc pour av-scan...'
sleep $SLEEPTPS

echo '' >> /home/$USRCONF/.bashrc
echo 'PATH=$PATH:~/Documents/scripts' >> /home/$USRCONF/.bashrc
echo '' >> /home/$USRCONF/.bashrc
echo 'alias av-scan=av-scan.sh' >> /home/$USRCONF/.bashrc

echo FAIT
sleep $SLEEPTPS

echo 'Configuration du système...'
sleep $SLEEPTPS

echo 'Copie de /etc/ssh/sshd_config...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/ssh/sshd_config /etc/ssh/

chown root:root /etc/ssh/sshd_config
chmod 600 /etc/ssh/sshd_config

echo FAIT
sleep $SLEEPTPS

echo 'Copie de /etc/sysctl.d/99-security.conf...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/sysctl.d/99-security.conf /etc/sysctl.d/

chown root:root /etc/ssh/sshd_config
chmod 644 /etc/ssh/sshd_config

echo FAIT
sleep $SLEEPTPS

sysctl --system

echo 'Copie de /etc/systemd/journald.conf...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/systemd/journald.conf /etc/systemd/

chown root:root /etc/systemd/journald.conf
chmod 644 /etc/systemd/journald.conf

echo FAIT
sleep $SLEEPTPS

systemctl restart systemd-journald

echo 'Copie de /etc/pam.d/system-auth...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/pam.d/system-auth /etc/pam.d/

chown root:root /etc/pam.d/system-auth
chmod 644 /etc/pam.d/system-auth

echo FAIT
sleep $SLEEPTPS

echo 'Copie de /etc/pam.d/passwd...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/pam.d/passwd /etc/pam.d/

chown root:root /etc/pam.d/passwd
chmod 644 /etc/pam.d/passwd

echo FAIT
sleep $SLEEPTPS

echo 'Copie de /etc/pam.d/su...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/pam.d/su /etc/pam.d/

chown root:root /etc/pam.d/su
chmod 644 /etc/pam.d/su

echo FAIT
sleep $SLEEPTPS

echo 'Copie de /etc/pam.d/su-l...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/pam.d/su-l /etc/pam.d/

chown root:root /etc/pam.d/su-l
chmod 644 /etc/pam.d/su-l

echo FAIT
sleep $SLEEPTPS

echo 'Configuration de Firejail...'
sleep $SLEEPTPS

apparmor_parser -rv /etc/apparmor.d/firejail-default

echo 'Copie de /etc/firejail/firejail.config...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/firejail/firejail.config /etc/firejail/

chown root:root /etc/firejail/firejail.config
chmod 644 /etc/firejail/firejail.config

echo FAIT
sleep $SLEEPTPS

echo 'Configuration de USBGuard...'
sleep $SLEEPTPS

echo 'Copie de /etc/usbguard/usbguard-daemon.conf...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/usbguard/usbguard-daemon.conf /etc/usbguard/

chown root:root /etc/usbguard/usbguard-daemon.conf
chmod 600 /etc/usbguard/usbguard-daemon.conf

sed -i "s/<username>/$USRCONF/g" /etc/usbguard/usbguard-daemon.conf

echo FAIT
sleep $SLEEPTPS

echo 'Génération des règles par défaut...'
sleep $SLEEPTPS

usbguard generate-policy > $WORKDIR/rules.conf
mv $WORKDIR/rules.conf /etc/usbguard/
chmod 600 /etc/usbguard/rules.conf
chown root:root /etc/usbguard/rules.conf

echo FAIT
sleep $SLEEPTPS

systemctl enable usbguard
systemctl start usbguard

echo 'Configuration système avec recommandations Lynis...'
sleep $SLEEPTPS

echo '[KRNL-5820]'
sleep $SLEEPTPS

echo 'Copie de /etc/security/limits.conf...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/security/limits.conf /etc/security/

chown root:root /etc/security/limits.conf
chmod 644 /etc/security/limits.conf

echo FAIT
sleep $SLEEPTPS

echo '[AUTH-9230]'
sleep $SLEEPTPS

echo 'Copie de /etc/login.defs...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/login.defs /etc/

chown root:root /etc/login.defs
chmod 644 /etc/login.defs

echo FAIT
sleep $SLEEPTPS

echo '[AUTH-9282] et [AUTH-9328]'
sleep $SLEEPTPS

echo "Changement des règles du mot de passe de $USRCONF..."
sleep $SLEEPTPS

chage -M 365 -m 1 -W 14 $USRCONF

echo FAIT
sleep $SLEEPTPS

echo '[STRG-1846]'
sleep $SLEEPTPS

echo 'Copie de /etc/modprobe.d/firewire.conf...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/modprobe.d/firewire.conf /etc/modprobe.d/

chown root:root /etc/modprobe.d/firewire.conf
chmod 640 /etc/modprobe.d/firewire.conf

echo FAIT
sleep $SLEEPTPS

mkinitcpio -P

echo '[PKGS-7398]'
sleep $SLEEPTPS

arch-audit

echo '[NETW-3200]'
sleep $SLEEPTPS

echo 'Copie de /etc/modprobe.d/disable-protocols.conf...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/modprobe.d/disable-protocols.conf /etc/modprobe.d/

chown root:root /etc/modprobe.d/disable-protocols.conf
chmod 640 /etc/modprobe.d/disable-protocols.conf

echo FAIT
sleep $SLEEPTPS

mkinitcpio -P

echo '[ACCT-9626]'
sleep $SLEEPTPS

systemctl enable --now sysstat

echo '[TIME-3104]'
sleep $SLEEPTPS

systemctl enable --now systemd-timesyncd

timedatectl status

echo '[MALW-3286]'
sleep $SLEEPTPS

systemctl enable --now clamav-freshclam

echo '[NAME-4028] et [NAME-4404]'
sleep $SLEEPTPS

hostnamectl set-hostname $HOSTCONF.localdomain

echo 'Copie de /etc/hosts...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/hosts /etc/

chown root:root /etc/hosts
chmod 644 /etc/hosts

sed -i "s/<hostname>/$HOSTCONF/g" /etc/hosts

echo FAIT
sleep $SLEEPTPS

echo '[BANN-7126]'
sleep $SLEEPTPS

echo 'Copie de /etc/issue...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/issue /etc/

chown root:root /etc/issue
chmod 644 /etc/issue

echo FAIT
sleep $SLEEPTPS

echo 'Copie de /etc/issue.net...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/issue.net /etc/

chown root:root /etc/issue.net
chmod 640 /etc/issue.net

echo FAIT
sleep $SLEEPTPS

echo '[ACCT-9630]'
sleep $SLEEPTPS

echo 'Copie de /etc/audit/rules.d/hardening.rules...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/audit/rules.d/hardening.rules /etc/audit/rules.d/

chown root:root /etc/audit/rules.d/hardening.rules
chmod 640 /etc/audit/rules.d/hardening.rules

echo FAIT
sleep $SLEEPTPS

augenrules --load
auditctl -l

echo '[FILE-7524]'
sleep $SLEEPTPS

chmod 600 /etc/cron.deny
chmod 600 /etc/crontab
chmod 600 /etc/ssh/sshd_config
chmod 700 /etc/cron.d
chmod 700 /etc/cron.daily
chmod 700 /etc/cron.hourly
chmod 700 /etc/cron.weekly
chmod 700 /etc/cron.monthly

echo FAIT
sleep $SLEEPTPS

echo '[KRNL-6000]'
sleep $SLEEPTPS

echo 'Copie de /etc/systemd/system/log-martians.service...'
sleep $SLEEPTPS

cp $BACKUPDIR/etc/systemd/system/log-martians.service /etc/systemd/system/

chown root:root /etc/systemd/system/log-martians.service
chmod 640 /etc/systemd/system/log-martians.service

echo FAIT
sleep $SLEEPTPS

systemctl daemon-reload
systemctl enable --now log-martians.service

echo '[TIME-3185]'
sleep $SLEEPTPS

echo 'Copie de /etc/systemd/timesyncd.conf.d/60-lynis.conf...'
sleep $SLEEPTPS

mkdir -p /etc/systemd/timesyncd.conf.d

cp $BACKUPDIR/etc/systemd/timesyncd.conf.d/60-lynis.conf /etc/systemd/timesyncd.conf.d/

chown root:root /etc/systemd/timesyncd.conf.d/60-lynis.conf
chmod 644 /etc/systemd/timesyncd.conf.d/60-lynis.conf
chmod 755 /etc/systemd/timesyncd.conf.d

echo FAIT
sleep $SLEEPTPS

systemctl restart systemd-timesyncd

rm -Rf $CONFIGDIR

echo '/!\ Attention ! /!\'
echo "Ce qui n'a pas été géré par le script :"
echo '	- Configuration du crontab pour av-scan.sh.'
echo '	- Configuration général de firejail (liens symboliques).'
echo "	- Changer le mot de passe de $USRCONF pour que les règles modifiées soient appliquées."
echo '	- Lynis : [FINT-4350], [ACCT-9622], [HTTP-6640], [HTTP-6643], [PHP-2372], [PHP-2376] et [HRDN-7222].'
