# Configuration Gaming d'Arch ([retour](../README.md))

L'un des éléments qui faisaient que je ne passais pas sous Linux pour une utilisation quotidienne était la possibilité de jouer à des jeux vidéo.

En effet, bien que Linux soit un OS intéressant dans le milieu professionnel ou pour les études, il a toujours été en retard par rapport à son environnement de bureau et au gaming, contrairement à Windows.

Mais, depuis quelques années, de nombreuses améliorations ont été apportées, notamment grâce à Valve et à l'apparition du Steam Deck.

> [!IMPORTANT]
> Bien qu'aujourd'hui le gaming sur Linux soit plus intéressant qu'il y a une décennie, vous aurez toujours une différence de performances par rapport à Windows. En effet, il faut penser que la plupart des jeux sont principalement développés pour les utilisateurs de Windows. Utiliser Proton/Wine revient à avoir une couche de traduction entre le jeu et l'OS, faisant ainsi baisser les performances.
>
> De plus, si vous utilisez, comme moi, une carte graphique Nvidia, ce n'est que depuis récemment que ce dernier a commencé à s'intéresser aux utilisateurs Linux. Comme précédemment, bien qu'il y ait de nombreuses améliorations, vous risquez de rencontrer certains problèmes, notamment avec le DLSS/Frame Gen (cela a été mon cas pour ce dernier).

Il faut aussi noter que, lors de la réalisation de ce dépôt, le système qui a été utilisé était un PC portable HP, composé principalement d'un Ryzen 5 5500U et de son iGPU. Le nouveau système, utilise un Ryzen 7 7700 et d'une RTX 4060 Ti, de ce fait, on se basera ici sur les GPU NVidia. Pour les autres constructeurs, il faudra adapter, en faisant des recherches dans la documentation d'Arch ou autre.

De plus, dans le premier système, j'ai utilisé le noyau linux-hardened, qui est une version plus sécurisée du noyau Linux. Dans le second, j'ai utilisé le noyau linux-zen, qui est une version plus optimisée, idéale pour le gaming.

## Sommaire :
1. [Installation du driver GPU (NVidia).](./md/install-nvidia-driver)
2. [Configurations et outils.](./md/config-tools.md)
3. [Installation et configurations des launchers.](./md/launchers.md)
4. [Configuration de jeux.](./md/config-jeux.md)