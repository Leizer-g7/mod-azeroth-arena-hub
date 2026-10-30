# Azeroth Arena Hub - Instalacion SQL

## Estado

Preparacion de instalacion manual.

Los instaladores definitivos todavia no estan
validados para distribucion publica.

## Archivos

- 00_preflight_world.sql: comprobaciones de solo lectura
- INFORME_RIESGOS.md: identificadores y riesgos

Los SQL originales permanecen en
`../sql-originales/` exclusivamente como referencia.

## Instalacion nueva

1. Realizar una copia de seguridad de la base world.
2. Verificar compatibilidad del core y su esquema.
3. Ejecutar el preflight de solo lectura.
4. Comparar los registros existentes con los esperados.
5. Resolver las colisiones sin eliminar datos ajenos.
6. Aplicar un instalador validado para ese esquema.
7. Reiniciar worldserver y comprobar los NPC.

IMPORTANTE: un AzerothCore sin estos modulos
puede contener registros en los mismos rangos
de pvpdifficulty_dbc. No asumir que estan libres.

## Migracion desde los modulos originales

1. Conservar los registros ya instalados.
2. Verificar la identidad de cada NPC y binding.
3. Revisar los rangos PvP y los comandos existentes.
4. No repetir los DELETE de los SQL originales.
5. Conservar los spawns personalizados.
6. Sustituir los modulos compilados por Arena Hub.
7. Consolidar la configuracion en
   AzerothArenaHub.conf.

Si las tablas ya contienen los datos correctos,
no es necesario eliminarlos ni recrearlos.

## NPC 1vs1

El SQL original define la plantilla 999991,
pero no incluye una insercion en creature
para colocarlo automaticamente en el mundo.

La ubicacion del NPC debe configurarse aparte.

## Seguridad

No ejecutar los SQL originales directamente
sobre bases de datos existentes.

No utilizar INSERT IGNORE para ocultar conflictos.

No ejecutar el preflight en una base incorrecta.

No almacenar credenciales en el repositorio.

Los scripts de esta carpeta NO estan destinados
a importacion automatica del Database Updater.
