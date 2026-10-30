# Azeroth Arena Hub

Unified arena system for AzerothCore WotLK 3.3.5a.

Azeroth Arena Hub combines Low Level Arena and Arena 1v1
into a single module with Playerbots integration and
a companion World of Warcraft addon.

## Features

- Arena 1v1, rated and unrated
- Low-level 2v2, 3v3 and 5v5 arenas
- Arena brackets from level 10 to 80
- Solo and group arena queues
- Automatic 1v1 matchmaking with Playerbots
- Dedicated battlemaster NPCs
- Unified configuration file
- Companion addon for WoW 3.3.5a
- In-game arena commands
- Configurable Playerbots matchmaking

## Commands

| Command | Description |
|---|---|
| `.q1v1 unrated` | Join an unrated 1v1 arena |
| `.q1v1 rated` | Join a rated 1v1 arena |
| `.q1v1 stats` | Show 1v1 statistics |
| `.lla queue solo` | Join a solo arena queue |
| `.lla queue group` | Join a group arena queue |

## NPC entries

| Entry | NPC |
|---|---|
| 700100 | Low Level Arena Master |
| 999991 | Arena Battlemaster 1v1 |

The original Low Level Arena SQL includes three
optional world spawns.

The original Arena 1v1 SQL defines its battlemaster
template but does not place the NPC in the world.

## Configuration

All module settings are located in:

`conf/AzerothArenaHub.conf.dist`

The configuration retains the original key families:

- `LowLevelArena.*`
- `Arena1v1.*`

Automatic Playerbots matchmaking is controlled by:

`Arena1v1.Playerbots.AutoQueue = 1`

There are 34 configuration options in total.

## Playerbots integration

The module includes automatic 1v1 matchmaking
against compatible Playerbots.

The integration uses RandomPlayerbotMgr from
mod-playerbots.

The current implementation depends on the
custom Playerbots interfaces used by the
tested AzerothCore installation.

## Compatibility

- World of Warcraft WotLK 3.3.5a
- AzerothCore
- mod-playerbots
- Custom Grimfeather-based AzerothCore environment

The combined module was tested successfully on
a customized AzerothCore server.

Compatibility with an unmodified upstream
AzerothCore build has not yet been verified.

Do not compile this module at the same time as
the two original arena modules.

## Installation

See:

[Installation guide](docs/INSTALLATION.md)

SQL installation is manual and requires reviewing
the target world's existing data.

The repository does not automatically import SQL.

## WoW addon

The companion addon is included in:

`client/AzerothArenaHub/`

Copy the complete AzerothArenaHub folder to:

`World of Warcraft/Interface/AddOns/`

The addon supports WoW interface version 30300.

It provides an arena interface and supports
the `/arenas` and `/arena` slash commands.

## SQL

Original SQL files are preserved in:

`docs/sql-originales/`

These are reference files and contain DELETE
statements that can replace existing database data.

A read-only SQL preflight is available at:

`docs/sql-instalacion-manual/00_preflight_world.sql`

Do not execute the original SQL scripts directly
against an existing database without reviewing
their effects and creating a backup.

A general-purpose automatic SQL installer has
not yet been validated.

## Source structure

- `src/`: C++ scripts
- `conf/`: unified configuration
- `client/`: WoW addon
- `docs/`: installation and SQL documentation
- `LICENSES/`: original license texts

## Credits

This project integrates work from:

- Ildourol - Low Level Arena
- AzerothCore contributors
- WarheadCore contributors
- Teiby
- fr4z3n
- XDev
- Emu-Devstore contributors
- mod-playerbots contributors

Additional custom integration includes the
unified loader, configuration consolidation
and Playerbots 1v1 matchmaking.

See THIRD_PARTY_NOTICES.md for source references.

## Licenses

The combined distribution includes code with
AGPL-3.0 and GPL-3.0 license notices.

Original copyright notices are retained.

See LICENSE and LICENSES/ for license texts.
