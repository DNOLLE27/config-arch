# Comment surveiller les erreurs des services ? ([retour](../MAINTENANCE.md))

Il faut s'assurer, une fois les mises à jour installées et les fichiers de configuration remis dans leur répertoire respectif, de s'assurer qu'il n'y ait pas d'erreur, sinon il faudra les corriger.

Cela concerne principalement les services, il faut alors d'abord surveiller leur statut :
```
sudo systemctl status <nom du service>
```

Puis regarder dans les logs :
```
sudo journalctl -u <nom du service> --no-pager -n <nombre de lignes à afficher>
```

> [!NOTE]
> Dans le cadre de ces deux commandes, il est possible d'utiliser l'option "--user", permettant ainsi de spécifier que le service est utilisateur, c'est-à-dire un service exécuté uniquement dans un contexte d'un utilisateur spécifique.

Si vous utilisez KDE Plamsa, vous pouvez accéder à une interface graphique, permettant de naviguer dans les logs système, nommée : Kjournald.