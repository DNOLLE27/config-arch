# Flatpak ([retour](../SOFTWARE.md))

Il s'agit d'un système de distribution d’applications, qui a la particularité d'isoler dans une sandbox (bubblewarp) tous les logiciels installés. Ces derniers contiennent alors tout leur environnement dans leur sandbox.

## Installation :
```
sudo pacman -S flatpak
```

## Quelques logiciels installables depuis flatpak :

### Gimp :
```
flatpak install --user https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref
```

Script d'exécution :
```
#!/bin/bash

flatpak run org.gimp.GIMP
```

Entrée desktop :
```
[Desktop Entry]
Version=3.2.4
Name=GIMP
Comment=Créer des images et modifier des photographies
Exec=/home/<username>/Documents/scripts/launch_gimp.sh
Path=/usr/bin
Icon=/usr/share/swcatalog/icons/archlinux-arch-extra/128x128/gimp_gimp.png
Terminal=false
Type=Application
Categories=Graphics;
```

### VideoDownloader :
```
flatpak install flathub com.github.unrud.VideoDownloader
```

Script d'exécution :
```
#!/bin/bash

flatpak run com.github.unrud.VideoDownloader
```

Entrée desktop :
```
[Desktop Entry]
Version=0.12.31
Name=Téléchargeur de vidéos
Comment=Téléchargez des vidéos à partir de sites web
Exec=/home/<username>/Documents/scripts/launch_videodownloader.sh
Path=/usr/bin
Icon=/home/<username>/Images/Icons/videodownloader-icon.png
Terminal=false
Type=Application
Categories=AudioVideo;
```

### Mozilla Firefox :
Installation des prérequis :
```
sudo pacman -S speech-dispatcher
```

Installation :
```
flatpak install flathub org.mozilla.firefox
```

Attribution de l'accès à speech-dispatcher :
```
flatpak override --user --talk-name=org.freedesktop.speechd org.mozilla.firefox
```

Script d'exécution :
```
#!/bin/bash

flatpak run org.mozilla.firefox
```

Entrée desktop :
```
[Desktop Entry]
Version=150.0
Name=Firefox
Comment=Navigateur rapide et privé
Exec=/home/<username>/Documents/scripts/launch_firefox.sh
Path=/usr/bin
Icon=/home/<username>/Images/Icons/firefox-icon.png
Terminal=false
Type=Application
Categories=Network;
```