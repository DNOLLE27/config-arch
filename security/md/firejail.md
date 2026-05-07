# Installation de Firejail ([retour](../SECURITY.md))

Il s'agit d'un logiciel de sandboxing, permettant d'exécuter n'importe quel autre logiciel dans un environnement restreint.

> [!IMPORTANT]
> Il faut comprendre que ce n'est pas infaillible, bien que le sandboxing ajoute une couche de sécurité, il vaut mieux toujours éviter d'exécuter du code malveillant.
>
> Tout comme AppArmor, Firejail utilise un système de profils par logiciel. Bien que nous en avons par défaut, il vaut mieux toujours vérifier les configurations et au besoin en créer des nouvelles.

## Téléchargement de Firejail et de sa GUI :
```
sudo pacman -S firejail firetools
```

## Configuration de Firejail :

### Configuration de Apparmor :
```
sudo apparmor_parser -r /etc/apparmor.d/firejail-default
```

### Configuration de /etc/firejail/firejail.config :
```
force-nonewprivs yes
```

## Utilisation de Firejail :

### Par défaut :

Pour utiliser firejail par défaut, soit en exécutant la commande suivant :
```
sudo firecfg
```

Cela permet de créer des liens symboliques dans ```/usr/local/bin```, qui pointent vers ```/usr/bin/firejail```, pour les programmes listés dans ```/etc/firejail/firecfg.config``` et ayant un profile.

OU

Créer manuellement les liens symboliques :
```
ln -s /usr/bin/firejail /usr/local/bin/
```

### En exécutant le programme voulu :
```
firejail  
```