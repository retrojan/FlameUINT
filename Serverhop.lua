local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- Проверяем флаг
if _G.FlameUINTFlag ~= "RunFlameUINT" then
    print("[Control] Flag invalid, ignoring")
    return
end

-- Сбрасываем флаг
_G.FlameUINTFlag = nil

-- ===== Здесь весь ServerHop с teleportFunc =====
local teleportFunc = queueonteleport or queue_on_teleport
if teleportFunc then
    teleportFunc([[
        -- Код на следующем сервере, проверка флага
        if _G.FlameUINTFlag ~= "RunFlameUINT" then return end
        _G.FlameUINTFlag = nil
        loadstring(game:HttpGet("https://raw.githubusercontent.com/retrojan/FlameUINT/main/main.lua", true))()
    ]])
end

-- Поиск серверов и телепорт
local servers = {}
local cursor = ""
local placeId = game.PlaceId

local success, response = pcall(function()
    return game:HttpGet(string.format(
        "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100%s",
        placeId, cursor ~= "" and "&cursor=" .. cursor or ""
    ))
end)

if success and response then
    local data = HttpService:JSONDecode(response)
    if data and data.data then
        for _, server in ipairs(data.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                table.insert(servers, server.id)
            end
        end
    end
end

if #servers > 0 then
    TeleportService:TeleportToPlaceInstance(placeId, servers[math.random(1, #servers)], LocalPlayer)
else
    warn("❌No available servers were found!")
end
