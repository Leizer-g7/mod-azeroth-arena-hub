/*
 * Low Level Arena - Ildourol + AzerothCore integration
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */
#include "LowLevelArena.h"
#include "Chat.h"
#include "Config.h"
#include "Group.h"
#include "Player.h"
#include "ScriptMgr.h"

using namespace Acore::ChatCommands;

class LLACombinedCommands : public CommandScript
{
public:
    LLACombinedCommands() : CommandScript("LLACombinedCommands") {}

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable queueCommands =
        {
            { "solo", HandleSolo, SEC_PLAYER, Console::No },
            { "group", HandleGroup, SEC_PLAYER, Console::No }
        };

        static ChatCommandTable llaCommands =
        {
            { "queue", queueCommands }
        };

        static ChatCommandTable commands =
        {
            { "lla", llaCommands }
        };

        return commands;
    }

    static bool Enabled(ChatHandler* handler)
    {
        if (!sConfigMgr->GetOption<bool>("LowLevelArena.Enable", false))
        {
            handler->PSendSysMessage("Low Level Arena skirmish esta desactivado.");
            return false;
        }
        return true;
    }

    static bool HandleSolo(ChatHandler* handler)
    {
        Player* player = handler->GetSession()->GetPlayer();
        if (!player)
            return false;

        if (!Enabled(handler))
            return true;

        // Solo queue: nunca incluir al grupo actual.
        sLLA->AddQueue(player, true);
        return true;
    }

    static bool HandleGroup(ChatHandler* handler)
    {
        Player* player = handler->GetSession()->GetPlayer();
        if (!player)
            return false;

        if (!Enabled(handler))
            return true;

        Group* group = player->GetGroup();
        if (!group)
        {
            handler->PSendSysMessage("Necesitas un grupo para este comando.");
            return true;
        }

        if (group->GetLeaderGUID() != player->GetGUID())
        {
            handler->PSendSysMessage("Debes ser el lider del grupo.");
            return true;
        }

        uint32 count = group->GetMembersCount();
        if (count != 2 && count != 3 && count != 5)
        {
            handler->PSendSysMessage(
                "El grupo debe tener exactamente 2, 3 o 5 integrantes.");
            return true;
        }

        const char* option = count == 2 ? "LowLevelArena.Enable2v2" :
                             count == 3 ? "LowLevelArena.Enable3v3" :
                                          "LowLevelArena.Enable5v5";

        if (!sConfigMgr->GetOption<bool>(option, true))
        {
            handler->PSendSysMessage("Este formato de arena esta desactivado.");
            return true;
        }

        sLLA->AddQueue(player, false);
        return true;
    }
};

void AddSC_LowLevelArena()
{
    new LLACombinedCommands();
}
