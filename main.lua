--[[
  Универсальный Loader для Roblox
  Загружает разные скрипты в зависимости от ID игры
]]

local currentGameId = game.PlaceId

-- Таблица соответствия ID игр и URL скриптов
local gameScripts = {
    [18550498098] = "https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/guidefight.lua", --Guide Boss Fight
    [6403373529] = "https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/slapbattles.lua", -- Default Slap Battles
    [98726100529621] = "https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/hexa.lua", -- Hexa
    [9015014224] = "https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/slapbattles.lua", -- SLap Battles No OneShot Gloves
}

-- Проверяем, есть ли скрипт для текущей игры
if gameScripts[currentGameId] then
    local scriptUrl = gameScripts[currentGameId]
    
    print("Игра найдена в базе (ID:", currentGameId..")")
    print("Загружаем скрипт:", scriptUrl)
    
    -- Пытаемся загрузить и выполнить скрипт
    local success, errorMsg = pcall(function()
        local scriptContent = game:HttpGet(scriptUrl, true)
        loadstring(scriptContent)()
    end)
    
    if not success then
        warn("Ошибка загрузки скрипта:", errorMsg)
    end
else
    print("Для этой игры нет скрипта (ID:", currentGameId..")")
end

print("Loader завершил работу")
