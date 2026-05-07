# Codeblocks ([retour](../SOFTWARE.md))

Codeblocks est un IDE permettant la programmation en C/C++. Il s'agit de build le logiciel, la procédure est complètement décrite dans la [documentation officielle](https://wiki.codeblocks.org/index.php/Installing_Code::Blocks_from_source_on_Arch_Linux).

### Installation des prérequis :

Prérequis via pacman :
```
pacman -S wget zip xterm svn hunspell boost
```

Installation de wxWidgets :
```
wget https://github.com/wxWidgets/wxWidgets/releases/download/v3.0.3/wxWidgets-3.0.3.tar.bz2

tar -x -f wxWidgets-3.0.3.tar.bz2

cd wxWidgets-3.0.3

./configure --enable-unicode --enable-monolithic --enable-debug --enable-shared

make

sudo make install
```

### Installation de Codeblocks :
```
svn checkout https://svn.code.sf.net/p/codeblocks/code/trunk codeblocks-code

cd codeblocks-code

./bootstrap

./configure  --with-contrib-plugins=all,-FileManager --prefix=/opt/codeblocks

make

sudo make install
```

### Script d'exécution :
```
#!/bin/bash

GTK_THEME=Adwaita:light GDK_BACKEND=x11 QT_QPA_PLATFORM=xcb LD_LIBRARY_PATH=/usr/local/lib /opt/codeblocks/bin/codeblocks
```

### Entrée desktop :
```
[Desktop Entry]
Version=svn 13832
Name=Code::Blocks
Comment=C++/C IDE
Exec=/home/<username>/Documents/scripts/launch_codeblocks.sh
Path=/opt/codeblocks 
Icon=/home/<username>/Images/Icons/codeblocks-icon.png
Terminal=false
Type=Application
Categories=Development;
```