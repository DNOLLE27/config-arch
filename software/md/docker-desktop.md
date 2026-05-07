# Docker-Desktop ([retour](../SOFTWARE.md))

Docker-Desktop est une interface graphique pour Docker, permettant donc de créer et de gérer des environnements d'exécutions isolés (containers), à des fins de développements et de déploiement.

La procédure d'installation est complètement décrite dans la [documentation officielle](docs.docker.com/desktop/setup/install/linux/archlinux/) de Docker.

### Installation du binaire du client Docker :

```
wget https://download.docker.com/linux/static/stable/x86_64/docker-29.4.2.tgz -qO- | tar xvfz - docker/docker --strip-components=1
sudo cp -rp ./docker /usr/local/bin/ && rm -r ./docker
```

### Installation de l'interface :

Il suffit de télécharger l'archive .pkg.tar.zst (version Arch) :
https://docs.docker.com/desktop/release-notes/

Puis de l'installer avec la commande :
```
sudo pacman -U ./docker-desktop-x86_64.pkg.tar.zst
```

### Connexion avec Docker-Desktop :

Génération des clés GPG :
```
gpg --generate-key
```

Puis dans la sortie de la commande précédente, nous obtiendrions notre GPG ID, que l'on devra utiliser avec cette commande :
```
pass init <GPG ID>
```