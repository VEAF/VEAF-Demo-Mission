Ce document est également disponible [en anglais](README.md).

# Mission de démonstration VEAF

Une mission de démonstration pour les [VEAF Mission Creation Tools](https://github.com/VEAF/VEAF-Mission-Creation-Tools),
et la mission avec laquelle nous les vérifions en jeu. Si une fonctionnalité VEAF marche
ici, elle marche.

**Ce dossier de mission est un dossier v6.** Il a été converti depuis la forme v5 en août
2026 : plus de `build.cmd`, plus de `configuration.json`, ni node, ni yarn, ni 7zip à
installer. Un seul exécutable fait tout, et la mission est décrite par `mission.yaml`.

## Prérequis

Rien d'autre que les outils eux-mêmes. Téléchargez `veaf-tools-updater.exe` depuis la
[dernière version publiée](https://github.com/VEAF/VEAF-Mission-Creation-Tools/releases/latest),
posez-le dans ce dossier et lancez-le : il récupère `veaf-tools.exe` et le tient à jour.

Voir la [documentation](https://veaf.github.io/documentation/) pour le reste.

## Construire la mission

Depuis **ce dossier** :

```
veaf-tools.exe build
```

C'est tout. Les missions construites arrivent dans `missions/`, une par variante météo
déclarée dans `src/versions.yaml` — vingt-cinq à l'heure où ces lignes sont écrites.

> **Lancez-le d'ici, pas depuis le dépôt des outils.** `veaf-tools.exe` résout `published/`
> et sa sortie par rapport au dossier courant ; le lancer ailleurs en passant ce dossier en
> argument échoue sur un `mist.lua` manquant.

## Ce que vous éditez

| Fichier | Ce qu'il contient |
|---|---|
| `mission.yaml` | toute la configuration de la mission — quels modules VEAF sont actifs, et comment chacun est réglé |
| `src/mission/` | la mission elle-même, telle que l'éditeur DCS l'a laissée |
| `src/scripts/` | le Lua propre à la mission, chargé après les scripts VEAF |
| `src/versions.yaml` | les variantes de météo et d'heure, chacune produisant un `.miz` |
| `src/presets.yaml` | les préréglages radio poussés dans les appareils |
| `src/spawnables.yaml`, `src/spawn-groups.yaml` | ce que les commandes de spawn peuvent créer |
| `src/waypoints.yaml` | les plans de vol injectés dans les slots joueur |
| `src/warehouses.yaml` | les stocks des aérodromes et des navires |
| `src/dynamic-slot-templates.yaml` | les gabarits derrière les slots dynamiques de DCS |

Tout est compilé **dans** le `.miz` : une modification demande donc une reconstruction avant
de pouvoir l'essayer en jeu.

### Tester une modification Lua sans reconstruire

Construisez une fois avec `--dev-mode` : la mission charge alors les scripts VEAF depuis
votre copie locale du dépôt des outils, au lieu de ceux embarqués dans le `.miz`. Relancer
la mission dans DCS (Maj-gauche + R) reprend ce que vous venez d'enregistrer.

```
veaf-tools.exe build --dev-mode
```

Cela demande un `scripts_path` dans votre `~/veafmct.yaml` — voir
[la configuration globale utilisateur](https://veaf.github.io/documentation/mission-maker/GUIDE/#global-user-configuration).

## Extraire une mission éditée

Après avoir édité et enregistré la mission dans l'éditeur DCS, remettez son `.miz` dans
`src/mission/` :

```
veaf-tools.exe extract <le fichier .miz>
```

## Ce que sont devenus les fichiers v5

`build.cmd`, `extract.cmd`, `weather.cmd`, `replace.ps1`, `package.json` et les installeurs
de `setup/` ont été retirés au passage en v6 : ils pilotaient une chaîne d'outils qui
n'existe plus. Ils restent dans l'historique git si besoin.

`configuration.json` a disparu aussi. Il portait une clé d'API CheckWX — c'est pourquoi
`.gitignore` l'a toujours exclu, et pourquoi elle n'a jamais atteint ce dépôt public. La v6
n'a besoin d'aucune clé : une variante météo déclarant `airport_icao` récupère son METAR
sans elle.
