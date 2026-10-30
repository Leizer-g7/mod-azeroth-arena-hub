/*
 * Azeroth Arena Hub
 *
 * Combined loader for:
 * - Low Level Arena
 * - Arena 1v1
 * - Playerbots automatic queue integration
 *
 * Original module credits and licenses
 * must be preserved in the final repository.
 */

void AddLowLevelArenaScripts();
void AddSC_LowLevelArena();

void AddSC_npc_1v1arena();
void AddSC_arena1v1_commandscript();

void Addmod_azeroth_arena_hubScripts()
{
    // Low Level Arena
    AddLowLevelArenaScripts();
    AddSC_LowLevelArena();

    // Arena 1v1
    // Includes existing Playerbots bridge registration.
    AddSC_npc_1v1arena();

    // Arena 1v1 commands
    AddSC_arena1v1_commandscript();
}
