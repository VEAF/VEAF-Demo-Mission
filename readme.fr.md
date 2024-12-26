
## Comment compiler une mission ?

### Prérequis

Voir {cette page](https://veaf.github.io/documentation/environment/index.fr.html) - [also in english](https://veaf.github.io/documentation/environment/) - pour les instructions aidant à installer tous les outils prérequis.

### Compiler une mission

C'est facile de compiler une mission à partir des sources ; il suffit de lancer le script `build.cmd`. Vous n'avez même pas besoin de le lancer dans une invite de commande `cmd`, il suffit de double-cliquer dessus.

Le processus va prendre tous les fichiers du répertoire `src`, récupérer la dernière version des outils *VEAF Mission Creation Tools* (à partir de GitHub), et compiler tout ça dans une mission prête à l'emploi pour DCS (dans un fichier `.miz`)

Ce fichier aura le même nom que la mission (configuré dans la première ligne du script `build.cmd`), et placé dans le répertoire `build`.

### Editer une version compilée

Une fois la mission compilée, copiez-là du répertoire `build` vers le répertoire de la mission (celui dans lequel se trouvent `extract.cmd` et `build.cmd`). Ensuite, ouvrez-la dans l'éditeur de mission de DCS, et éditez-la (ajouter/supprimer des unités, ajouter des triggers, changer des zones, etc.).

Egalement, vous pouvez éditer les fichiers source de la mission en parallèle (en utilisant un éditeur de texte, je conseille Notepad++ ou Visual Studio Code); en particulier, vous pouvez éditer :

- le fichier de configuration de la mission `src/scripts/missionConfig.lua`, pour définir les paramètres de la mission ; c'est le principal fichier source que vous éditerez.
- le fichier des canaux radio `src/radio/radioSettings.lua`, pour définir les canaux radio qui seront poussés dans les avions.
- les presets pour la météo dans `src/weatherAndTime`

So vous éditez un de ces fichiers, et parce qu'ils sont intégrés *dans* le fichier `.miz` de la mission, vous devrez *recompiler* la mission avant de pouvoir tester vos changements dans le jeu.

Il existe un moyen de tester facilement ces changements : le premier trigger de la mission contient une condition LUA, qui conditionne la méthode de chargement des scripts. Si elle est à `false`, les scripts seront chargés statiquement (i.e. ils seront chargés *à partir de la mission*) ; si elle est à `true`, les scripts seront chargés dynamiquement, et donc à chaque redémarrage de la mission dans DCS (ShiftGauche + R), vous pourrez tester les changements apportés aux fichiers.

![triggers](https://user-images.githubusercontent.com/172286/109670752-bac72180-7b73-11eb-9d20-cadd84bff1a5.jpg)

### Extraire une mission éditée

Une fois qu'une mission a été éditée et sauvée dans l'éditeur de mission de DCS, il faut *extraire* son contenu dans le répertoire `src`, afin de pouvoir le réinjecter plus tard avec le script `build`.

Pour ce faire, il suffit de lancer le script `extract.cmd`. Vous n'avez même pas besoin de le lancer dans une invite de commande `cmd`, il suffit de double-cliquer dessus.

Ce script va prendre n'importe quel fichier dont le nom commence par le nom de la mission (configuré dans la première ligne du script `extract.cmd`), dans le répertoire de la mission (celui dans lequel se trouvent `extract.cmd` et `build.cmd`, pas le répertoire `build`), extraire son contenu, le traiter et le stocker dans `src`.

### Paramètres avancés

#### Spécifier l'emplacement de l'exécutable 7zip

Si l'outil 7zip est installé mais n'est pas dans votre PATH, vous pouvez spécifier son emplacement dans la variable d'environnement `SEVENZIP`. C'est une chaine qui doit pointer vers l'exécutable `7za` (par ex: `c:\tools\7zip\bin\7zip.exe`)

#### Spécifier l'emplacement de l'exécutable LUA

De la même manière, vous pouvez spécifier son emplacement dans la variable d'environnement `LUA`. C'est une chaine qui doit pointer vers l'exécutable `lua` (par ex: `c:\tools\lua\bin\lua.exe`)

#### Ne pas marquer de pause

Si vous précisez la valeur "true" dans la variable d'environnement `NOPAUSE`, alors les scripts se déroulera sans marquer de pause.

## Comment transformer une mission existante - version graphique

![schema](https://user-images.githubusercontent.com/172286/109006666-9a96ee80-76ab-11eb-871c-a77a1ffa4fd9.jpg)
