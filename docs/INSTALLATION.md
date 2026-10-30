# Azeroth Arena Hub - Installation Guide

## Requirements

- AzerothCore WotLK 3.3.5a
- Compatible mod-playerbots installation
- Working C++ build environment
- World database access
- World database backup

The current implementation has been tested on
a customized Grimfeather-based AzerothCore fork.

## 1. Install module sources

Place the repository inside:

`azerothcore-wotlk/modules/mod-azeroth-arena-hub`

Do not enable these modules simultaneously:

- mod-1v1-arena
- mod-low-level-arena

Only the unified module should register
the arena scripts.

## 2. Compile

Configure and compile AzerothCore using your
existing build environment.

The module uses its CMakeLists.txt.

The exact build procedure depends on the
AzerothCore version and deployment method.

The current Playerbots integration references
mod-playerbots source headers and may require
adaptation for other Playerbots installations.

## 3. Configure

Copy:

`conf/AzerothArenaHub.conf.dist`

to your active module configuration directory
using the filename:

`AzerothArenaHub.conf`

Review all 34 configuration options.

Do not retain duplicate active configurations
from the original arena modules.

## 4. Prepare the world database

Create a complete database backup first.

Review:

`sql-instalacion-manual/README.md`

Execute the read-only diagnostic:

`sql-instalacion-manual/00_preflight_world.sql`

against the intended world database.

Review existing NPC entries, battlemaster
bindings, PvP brackets, spawns, and commands.

Original SQL files are preserved in:

`sql-originales/`

They include DELETE statements and are not
intended for blind execution on databases
containing existing data.

A general-purpose safe SQL installer has
not yet been validated.

For migration from the original arena modules,
preserve existing database records and avoid
reimporting them unnecessarily.

## 5. Deploy

Deploy your newly compiled worldserver using
your normal AzerothCore deployment procedure.

Restart worldserver if necessary.

Check logs for:

- Successful world initialization
- Low Level Arena configuration loading
- Playerbots initialization
- Arena 1v1 Playerbots matchmaking

## 6. Install the addon

Copy:

`client/AzerothArenaHub/`

to:

`World of Warcraft/Interface/AddOns/AzerothArenaHub/`

Enable the addon in character selection.

In-game slash commands:

- /arenas
- /arena

## 7. Verify

Test:

- Low Level Arena NPC 700100
- Arena 1v1 NPC 999991
- .q1v1 rated and unrated
- .lla queue solo and group
- Playerbots automatic 1v1 matchmaking
- Addon buttons and minimap interaction

## Important

Do not overwrite unrelated database records.

Do not enable SQL auto-installation without
reviewing the schema and existing data.

Do not publish credentials, private configs
or server backups.
