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
