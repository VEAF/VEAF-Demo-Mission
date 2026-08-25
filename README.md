This document is also available [in French](readme.fr.md).

# VEAF Demo Mission

A demonstration mission for the [VEAF Mission Creation Tools](https://github.com/VEAF/VEAF-Mission-Creation-Tools),
and the mission we use to check them in game. If a VEAF feature works here, it works.

**This mission folder is a v6 mission folder.** It was converted from the v5 layout in
August 2026: there is no `build.cmd`, no `configuration.json`, no node or yarn, and no
7zip to install. One executable does everything, and the mission is described by
`mission.yaml`.

## Prerequisites

Nothing but the tools themselves. Download `veaf-tools-updater.exe` from the
[latest release](https://github.com/VEAF/VEAF-Mission-Creation-Tools/releases/latest),
drop it in this folder and run it — it fetches `veaf-tools.exe` and keeps it up to date.

See the [documentation](https://veaf.github.io/documentation/) for everything else.

## Building the mission

From **this folder**:

```
veaf-tools.exe build
```

That is all. The built missions land in `missions/`, one per weather variant declared in
`src/versions.yaml` — twenty-five of them at the time of writing.

> **Run it from here, not from the tools repository.** `veaf-tools.exe` resolves
> `published/` and its output relative to the current directory, so launching it elsewhere
> with this folder as an argument fails on a missing `mist.lua`.

## What you edit

| File | What it holds |
|---|---|
| `mission.yaml` | the whole mission's configuration — which VEAF modules are on, and how each is set up |
| `src/mission/` | the mission itself, as the DCS editor left it |
| `src/scripts/` | the mission's own Lua, loaded after the VEAF scripts |
| `src/versions.yaml` | the weather and time variants, each producing one `.miz` |
| `src/presets.yaml` | the radio presets pushed into the aircraft |
| `src/spawnables.yaml`, `src/spawn-groups.yaml` | what the spawn commands can create |
| `src/waypoints.yaml` | the flight plans injected into player slots |
| `src/warehouses.yaml` | airfield and ship stocks |
| `src/dynamic-slot-templates.yaml` | the templates behind DCS dynamic slots |

Everything is compiled **into** the `.miz`, so a change means a rebuild before you can test
it in game.

### Testing a Lua change without rebuilding

Build once with `--dev-mode`: the mission then loads the VEAF scripts from your local copy
of the tools repository instead of from inside the `.miz`. Restarting the mission in DCS
(Left-Shift + R) picks up whatever you saved.

```
veaf-tools.exe build --dev-mode
```

This needs `scripts_path` set in your `~/veafmct.yaml` — see
[the global user configuration](https://veaf.github.io/documentation/mission-maker/GUIDE/#global-user-configuration).

## Extracting an edited mission

Once you have edited and saved the mission in the DCS Mission Editor, put its `.miz` back
into `src/mission/`:

```
veaf-tools.exe extract <the .miz file>
```

## What became of the v5 files

`build.cmd`, `extract.cmd`, `weather.cmd`, `replace.ps1`, `package.json` and the `setup/`
installers were removed when this folder moved to v6 — they drove a toolchain that no longer
exists. They are in the git history if you ever need to look.

`configuration.json` is gone too. It held a CheckWX API key, which is why `.gitignore` has
always excluded it and why it never reached this public repository. v6 needs no key: a
weather variant declaring `airport_icao` fetches its METAR without one.
