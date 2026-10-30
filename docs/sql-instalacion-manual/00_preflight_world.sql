-- Azeroth Arena Hub - Preflight SQL
-- SOLO LECTURA: no modifica tablas.
-- Ejecutar en la base de datos world.
-- Revisar resultados antes de instalar o migrar.

SELECT DATABASE() AS base_de_datos;

-- Rangos de PvP: filas existentes.
SELECT 'PvP IDs 20-35' AS comprobacion,
       COUNT(*) AS filas_existentes
FROM `pvpdifficulty_dbc`
WHERE `ID` BETWEEN 20 AND 35;

SELECT 'PvP IDs 36-51' AS comprobacion,
       COUNT(*) AS filas_existentes
FROM `pvpdifficulty_dbc`
WHERE `ID` BETWEEN 36 AND 51;

SELECT 'PvP IDs 55-70' AS comprobacion,
       COUNT(*) AS filas_existentes
FROM `pvpdifficulty_dbc`
WHERE `ID` BETWEEN 55 AND 70;

SELECT 'PvP IDs 74-89' AS comprobacion,
       COUNT(*) AS filas_existentes
FROM `pvpdifficulty_dbc`
WHERE `ID` BETWEEN 74 AND 89;

SELECT 'PvP IDs 90-105' AS comprobacion,
       COUNT(*) AS filas_existentes
FROM `pvpdifficulty_dbc`
WHERE `ID` BETWEEN 90 AND 105;

-- Otros registros que deben comprobarse.

SELECT 'NPC templates' AS comprobacion,
       COUNT(*) AS filas_existentes
FROM `creature_template`
WHERE `entry` IN (700100, 999991);

SELECT 'NPC models' AS comprobacion,
       COUNT(*) AS filas_existentes
FROM `creature_template_model`
WHERE `CreatureID` IN (700100, 999991);

SELECT 'Battlemaster bindings' AS comprobacion,
       COUNT(*) AS filas_existentes
FROM `battlemaster_entry`
WHERE `entry` IN (700100, 999991);

SELECT 'Low Level Arena spawns' AS comprobacion,
       COUNT(*) AS filas_existentes
FROM `creature`
WHERE `id` = 700100 OR `guid` IN (7001001,7001002,7001003);

SELECT '1v1 command definitions' AS comprobacion,
       COUNT(*) AS filas_existentes
FROM `command`
WHERE `name` IN ('q1v1','q1v1 rated','q1v1 unrated','q1v1 stats');

SELECT '1v1 NPC text' AS comprobacion,
       COUNT(*) AS filas_existentes
FROM `npc_text`
WHERE `id` = 999992;

-- Detalle de los rangos PvP existentes.
SELECT `ID`, `MapID`, `RangeIndex`,
       `MinLevel`, `MaxLevel`, `Difficulty`
FROM `pvpdifficulty_dbc`
WHERE `ID` BETWEEN 20 AND 35 OR `ID` BETWEEN 36 AND 51 OR `ID` BETWEEN 55 AND 70 OR `ID` BETWEEN 74 AND 89 OR `ID` BETWEEN 90 AND 105
ORDER BY `ID`;

-- Detalle de los spawns existentes o colisionantes.
SELECT `guid`, `id`, `map`,
       `position_x`, `position_y`, `position_z`
FROM `creature`
WHERE `id` = 700100
   OR `guid` IN (7001001,7001002,7001003)
ORDER BY `guid`;

-- Identificadores de NPC existentes.
SELECT `entry`, `name`, `ScriptName`
FROM `creature_template`
WHERE `entry` IN (700100,999991);

-- Comandos existentes.
SELECT `name`, `security`, `help`
FROM `command`
WHERE `name` IN
('q1v1','q1v1 rated','q1v1 unrated','q1v1 stats');
