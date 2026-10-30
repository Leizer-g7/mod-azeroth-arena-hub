# Azeroth Arena Hub - Riesgos SQL

## Bloques PvP

- 20-35: mapa 559, Nagrand Arena
- 36-51: mapa 562, Blade's Edge Arena
- 55-70: mapa 572, Ruins of Lordaeron
- 74-89: mapa 617, Dalaran Sewers
- 90-105: mapa 618, Ring of Valor

Los bloques originales emplean DELETE e INSERT.

La presencia de filas no demuestra por si sola
que exista una colision: pueden ser registros
originales del core o de una instalacion anterior.

Es necesario comparar su contenido.

## NPC Low Level Arena

- creature_template: 700100
- creature_template_model: 700100
- battlemaster_entry: 700100
- creature: todos los registros con id 700100
- GUID de spawn: 7001001, 7001002, 7001003

El SQL original elimina todos los spawns con
id 700100 antes de introducir tres nuevos.

Esto puede borrar ubicaciones personalizadas.

## NPC Arena 1vs1

- creature_template: 999991
- creature_template_model: 999991
- battlemaster_entry: 999991
- npc_text: 999992

## Comandos

- q1v1
- q1v1 rated
- q1v1 unrated
- q1v1 stats

## Precaucion

Los SQL no deben incorporarse a data/sql
hasta que exista un procedimiento seguro,
compatible con el esquema de destino y
probado en una base de datos de ensayo.

La publicacion tambien tiene una revision
de licencias pendiente.
