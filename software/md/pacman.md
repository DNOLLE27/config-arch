# Pacman ([retour](../SOFTWARE.md))

Il s'agit ici de répertorier tous les éléments installables directement en paquet disponible depuis pacman.

On retrouve :
- htop (affiche les processus actifs en temps réel).
- Thunderbird (client mail).
- LibreOffice (suite en français).
- Filezilla (client FTP).
- MySQL Workbench (permet la modélisation de base de données et la génération de script SQL).
- Wireshark (permet de surveiller le réseau).
- Inkscape (éditeur d'image SVG).
- Obsidian (bloc-notes LaTeX).
- Audacity (logiciel d'enregistrement et de montage audio).
- OBS Studio (logiciel d'enregistrement vidéo).
- VLC (lecteur multimédia).
- Scite (IDE Java et plus).
- hunspell-fr (dictionnaire français pour correcteur orthographique).
- fastfetch (permet d'obtenir des informations sur le système depuis le terminal).

Il suffit tout simplement d'exécuter la commande suivante :
```
sudo pacman -S htop thunderbird libreoffice-fresh-fr filezilla mysql-workbench wireshark-qt inkscape obsidian audacity obs-studio vlc vlc-plugins-all scite hunspell-fr fastfetch
```

## Wireshark :

Script d'exécution :
```
#!/bin/bash

sudo wireshark $1
```

Modification de l'entrée desktop :
```
...

TryExec=/home/<username>/Documents/scripts/launch_wireshark.sh
Exec=/home/<username>/Documents/scripts/launch_wireshark.sh %f
...
```

### hunspell-fr :

Il s'agit d'un ensemble de dictionnaires français, pouvant être installés avec l'extension Spell Right de Visual Studio Code :

```
ln -s /usr/share/hunspell/* ~/.config/Code/Dictionaries
```