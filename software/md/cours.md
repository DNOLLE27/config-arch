# Cours ([retour](../SOFTWARE.md))

Il s'agit d'outils/logiciels utilisés dans un contexte de cours.

## Maven :

### Installation :

```
sudo pacman -S maven
```

## Informatique Graphique :

### Installation de xmake :
```
sudo pacman -S xmake
```

### Activation des miroirs multilib (32 bits) :

Configuration de /etc/pacman.conf :
```
[multilib]
Include = /etc/pacman.d/mirrorlist
```

Mise à jour des miroirs :
```
sudo pacman -Syu
```

Installation du driver GPU (OpenGL et Vulkan (32/64 bits)) :
```
sudo pacman -S mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader libva-mesa-driver lib32-libva-mesa-driver vulkan-tools mesa-utils lib32-mesa-utils
```

> [!IMPORTANT]
> Il faudra addapter en fonction du GPU (NVidia, Intel, ...).

## Angular :

### Installation :
```
npm install -g @angular/cli
```

## Symfony :

### Installation de Composer :

Script d'installation ([documentation officiel](getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md)) :
```
#!/bin/sh

EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
then
    >&2 echo 'ERROR: Invalid installer checksum'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quiet
RESULT=$?
rm composer-setup.php
exit $RESULT
```

Création du répertoire pour Composer et déplacement du script :
```
mkdir ~/composer

mv composer.phar ~/composer
```

Configuration de .bashrc :
```
PATH=$PATH:[...]:~/composer
...
alias composer=composer.phar
```

Changement du propriétaire du répertoire :
```
sudo chown -R root:root ~/composer
```

### Installation :
Téléchargement et exécution du script d'installation, puis déplacement du répertoire de symfony :
```
wget https://get.symfony.com/cli/installer -O - | bash
mv ~/.symfony5 ~/.config/symfony-cli
```

Configuration de .bashrc :
```
PATH=$PATH:[...]:~/.config/symfony-cli/bin
```

## Couverture de code :

### Installation :
```
pacman -S lcov
```

## PlantUML :

### Installation de gradle : 
```
sudo pacman -S gradle
```

### Téléchargement et Build :
```
mkdir plantuml
cd plantuml
git clone https://github.com/plantuml/plantuml.git
cd plantuml
gradle build
gradle test
gradle jar
cd build/libs
cp plantuml-*[^javadoc,sources].jar plantuml.jar
```

### Script d'utilisation :
```
#!/bin/bash

dir=$HOME/Documents/plantuml/plantuml/build/libs/
dirImgFile=$HOME/Documents/Scripts

if [[ $1 == "" || ! -f $1 || ! $1 == *.txt ]]
then
    echo "PLANTUML - Veuillez saisir saisir un chemin valide vers un fichier .txt !";
else
    if [[ $2 != "" ]]
    then
        if [[ -d $2 ]]
        then
            java -jar $dir"plantuml.jar" -verbose $1;
            mv $dirImgFile/*.png $2;
        else
            echo "PLANTUML - Veuillez saisir saisir un chemin de destination valide !"
        fi
    else
        java -jar $dir"plantuml.jar" -verbose $1;
        mv $dirImgFile/*.png $(pwd)
    fi
fi
```

### Changement des droits du script :
```
chmod +x plantuml.sh 
```

### Configuration de .bashrc :
```
PATH=$PATH:[...]:~/Documents/Scripts
```

## GTest :

Il suffit de télécharger l'archive :
```
wget https://github.com/google/googletest/archive/master.zip
```

Puis d'extraire l'archive, et dans le répertoire résultant de l'extraction :
```
mkdir build

cd build 

cmake -G "Unix Makefiles" ..

make

cd ..

mkdir GoogleTestLib

cd GoogleTestLib

cp ../build/lib/libgtest.a .

cp -r ../googletest/include .
```


## Doxygen :

Il suffit de télécharger l'archive depuis le [site officiel](https://www.doxygen.nl/download.html), puis de l'extraire où vous voulez.

> [!IMPORTANT]
> Il ne faut pas prendre le code source, mais la version "tarball".

Configuration de .bashrc :
```
PATH=$PATH:[...]:~/doxygen-1.16.1/bin
```

## Vite :

### Installation/Utilisation :
```
npm create vite@latest
```

## NodeJS :

### Installation de NVM :
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

\. "$HOME/.nvm/nvm.sh"
```

### Installation :
```
nvm install 24
```