#!/bin/bash

while [[ true ]]
do
    ERROR=$(journalctl -u clamav-clamonacc --no-pager -n 5 | grep -E 'watch descriptor issue|issue when adding watch|could not watch path|could not add element to hash table|Communication error')

    if [[ ! $ERROR = '' ]]
    then
        echo Une erreur a été détécté, redémarrage du service clamav-clamonacc en cours...
        sudo systemctl restart clamav-clamonacc.service
        sleep 8
    else
        sleep 1
    fi
done
