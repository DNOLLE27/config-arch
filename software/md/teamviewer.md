# Teamviewer ([retour](../SOFTWARE.md))

La procédure d'installation est complètement expliquée dans la [documentation officielle](https://www.teamviewer.com/fr/global/support/knowledge-base/teamviewer-remote/download-and-installation/linux/use-the-tar-package-for-linux/).

### Installation des prérequis :
```
sudo pacman -S qt5-base qt5-declarative qt5-quickcontrols qt5-quickcontrols2 qt6-base qt6-declarative
```

### Installation :
Il faut télécharger l'archive "Full Client" (other systems) :

https://www.teamviewer.com/fr/download/portal/linux/

Puis dans le répertoire extrait et dans le répertoire "teamviewer" :
```
./tv-setup checklibs
```

Si vous avez une erreur concernant QtQuickControls, il faut modifier la fonction suivante dans ./teamviewer/tv_bin/script/teamviewer_setup :
```
function CheckQtQuickControls()
{
ls /usr/lib/qt/qml/QtQuick/Controls/qmldir &>/dev/null && return
ls /usr/lib*/*/qt5/qml/QtQuick/Controls/qmldir &>/dev/null && return
ls /usr/lib*/qt5/qml/QtQuick/Controls/qmldir   &>/dev/null
}
```

Enfin, pour installer TeamViewer :
```
sudo ./tv-setup install
```