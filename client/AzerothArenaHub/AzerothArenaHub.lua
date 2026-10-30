-- Azeroth Arena Hub v0.2.0
-- Cliente WoW 3.3.5a (Interface 30300). Sin dependencias externas.
-- Los comandos son procesados por el servidor; el addon no crea ni modifica colas.

local ADDON = "Azeroth Arena Hub"
local PREFIX = "|cffffd36e[Arenas]|r "
local function inform(msg)
    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage(PREFIX .. msg)
    end
end

local function sendCommand(command)
    -- El worldserver AzerothCore interpreta los comandos de chat que comienzan con un punto.
    -- Enviar por SAY evita necesitar permisos de GM y funciona con comandos SEC_PLAYER.
    if not UnitExists("player") then
        inform("Debes entrar al mundo para usar las colas.")
        return
    end
    SendChatMessage(command, "SAY")
    inform("Solicitud enviada. La inscripcion se confirma solo si el servidor muestra el aviso de cola.")
end

local f = CreateFrame("Frame", "AzerothArenaHubFrame", UIParent)
f:SetWidth(345)
f:SetHeight(282)
f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
f:SetFrameStrata("DIALOG")
f:SetMovable(true)
f:EnableMouse(true)
f:RegisterForDrag("LeftButton")
f:SetScript("OnDragStart", function(self) self:StartMoving() end)
f:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
f:SetClampedToScreen(true)
f:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 8, right = 8, top = 8, bottom = 8 },
})
f:Hide()

local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOP", f, "TOP", 0, -20)
title:SetText("ARENAS DE AZEROTH")

local sub = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
sub:SetPoint("TOP", title, "BOTTOM", 0, -8)
sub:SetWidth(310)
sub:SetText("1vs1, cola individual o grupo desde cualquier lugar")

local function makeButton(name, label, y, description, callback, enabled)
    local b = CreateFrame("Button", name, f, "UIPanelButtonTemplate")
    b:SetSize(284, 35)
    b:SetPoint("TOP", f, "TOP", 0, y)
    b:SetText(label)
    if enabled then
        b:SetScript("OnClick", callback)
    else
        b:Disable()
    end
    b:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(label, 1, 0.82, 0.3)
        GameTooltip:AddLine(description, 1, 1, 1, true)
        GameTooltip:Show()
    end)
    b:SetScript("OnLeave", function() GameTooltip:Hide() end)
    return b
end

makeButton(
    "AzerothArenaHubSoloButton",
    "INSCRIBIRME SOLO  (cola 2vs2)",
    -74,
    "Envia .lla queue solo. Te inscribe sin grupo en la cola 2vs2; NO es un combate 1vs1.",
    function() sendCommand(".lla queue solo") end,
    true
)

makeButton(
    "AzerothArenaHubGroupButton",
    "INSCRIBIR MI GRUPO  (2/3/5)",
    -117,
    "Envia .lla queue group. Debes ser lider de un grupo de 2, 3 o 5. Los Playerbots deben cumplir las condiciones de cola del servidor.",
    function() sendCommand(".lla queue group") end,
    true
)

makeButton(
    "AzerothArenaHub1v1Button",
    "ARENA 1vs1  (no clasificada)",
    -160,
    "Envia .q1v1 unrated. Enfrentamiento 1 contra 1 sin clasificacion (nivel minimo 10). Necesita otro jugador en cola; no inscribe Playerbots automaticamente.",
    function() sendCommand(".q1v1 unrated") end,
    true
)

local note = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
note:SetPoint("TOP", f, "TOP", 0, -206)
note:SetWidth(302)
note:SetJustifyH("CENTER")
note:SetText("Los NPC de arena en las capitales siguen disponibles.")

local close = CreateFrame("Button", "AzerothArenaHubCloseButton", f, "UIPanelCloseButton")
close:SetPoint("TOPRIGHT", f, "TOPRIGHT", -6, -6)

local function toggle()
    if f:IsShown() then f:Hide() else f:Show() end
end

SLASH_AZEROTHARENAHUB1 = "/arenas"
SLASH_AZEROTHARENAHUB2 = "/arena"
SlashCmdList["AZEROTHARENAHUB"] = toggle

-- Boton junto al minimapa; sin librerias externas.
local mini = CreateFrame("Button", "AzerothArenaHubMinimapButton", Minimap)
mini:SetSize(29, 29)
mini:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -10, -7)
mini:SetFrameStrata("MEDIUM")
mini:SetNormalTexture("Interface\\Icons\\Achievement_Arena_2v2_1")
mini:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
mini:SetScript("OnClick", toggle)
mini:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText(ADDON, 1, 0.82, 0.3)
    GameTooltip:AddLine("Clic para abrir o cerrar las arenas.", 1, 1, 1)
    GameTooltip:AddLine("Tambien disponible con /arenas", 0.7, 0.7, 0.7)
    GameTooltip:Show()
end)
mini:SetScript("OnLeave", function() GameTooltip:Hide() end)

local events = CreateFrame("Frame")
events:RegisterEvent("PLAYER_LOGIN")
events:SetScript("OnEvent", function()
    inform("Addon cargado. Usa |cffffffff/arenas|r o el boton del minimapa.")
end)
