# Unity ([retour](../SOFTWARE.md))

Unity est un environnement de développement de jeux vidéo en 3D et en 2D, utilisant le langage de programmation C#.

> [!IMPORTANT]
> Contrairement à Windows, nous n'avons pas accès à Visual Studio Community, nous devons donc utiliser un autre IDE. Vous pouvez utiliser Visual Studio Code, pour cela, vous devez installer les extensions précisées [ici](https://docs.unity3d.com/6000.4/Documentation/Manual/scripting-ide-support.html#vs-code), et .NET : ```sudo pacman -S dotnet-runtime dotnet-sdk```, puis configurer l'éditeur Unity comme décrit [ici](https://code.visualstudio.com/docs/other/unity).

### Installation des prérequis :
```
pacman -S binutils tar
```

### Installation :

Il faut télécharger le .deb depuis le site officiel :

https://cloud.unity.com/home/organizations/20066549916690/onboarding/post-download?locale=fr&code=KGAqBSlL3ZSnZa95v0a_KQ012f&locale=fr&session_state=1346fd95944c1f346b64db96d95e9c212be702b3a7b1c383f1e1f4fa0e951216.02GgyaFTKl8UqHLN1OykSw008f

Extration du .deb :
```
bsdtar -xvf UnityHubSetup-amd64.deb
bsdtar -xvf data.tar.*
```

Copie des fichiers vers les répertoires adéquats :
```
sudo cp -r opt/* /opt/
sudo cp -r usr/* /usr/
```

Modification de l'entrée desktop (/usr/share/applications/unityhub.desktop) :
```
[Desktop Entry]
Version=3.18.0
Name=Unity Hub
Comment=The Official Unity Hub
Exec=/opt/unityhub/unityhub %U
Path=/opt/unityhub
Icon=/usr/share/icons/hicolor/512x512/apps/unityhub.png
Terminal=false
Type=Application
Categories=Development;
```