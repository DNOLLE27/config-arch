#!/bin/bash

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

DATE=$(date +'%Y-%m-%d-%H-%M-%S')
DIR=~/logs/av-scan
RKH=rkhunter-scan.log
RKHC=rkhunter-complete.log
LMD=lmd-scan.log

if [ ! -d $DIR  ]; then
	mkdir -p $DIR
fi

notify-send -a AV-SCAN "Analyse en cours... Veuillez ne pas éteindre votre système !"

mkdir $DIR/$DATE

echo "___ Analyse du : $DATE ___" | tee $DIR/$DATE/$RKH

sudo rkhunter --check --sk | tee -a $DIR/$DATE/$RKH
sudo rkhunter --check-config | tee -a $DIR/$DATE/$RKH

echo "___ Analyse du : $DATE ___" | tee $DIR/$DATE/$RKHC
sudo cat /var/log/rkhunter.log | tee -a $DIR/$DATE/$RKHC

echo "___ Analyse du : $DATE ___" | tee $DIR/$DATE/$LMD
sudo maldet -a / | tee -a $DIR/$DATE/$LMD

notify-send -a AV-SCAN "Analyse terminé, résultats dans : \"$DIR/$DATE\"."
