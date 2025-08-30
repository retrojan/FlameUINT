--[[
    LOADER BY ReTrojan
]]

local currentGameId = game.PlaceId

-- ID
local gameScripts = {
      [6403373529] = "https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/SB.lua", -- Default Slap Battles
      [9015014224] = "https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/SB.lua", -- SLap Battles No OneShot Gloves
  
    --[18550498098] = "https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/guidefight.lua", --Guide Boss Fight REMOVED: TEMPORARILY REMOVED: REWORK
    --[98726100529621] = "https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/hexa.lua", -- Hexa REMOVED: TEMPORARILY REMOVED: REWORK
    --[124596094333302] = "https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/slapbattles.lua" -- New Players. REMOVED: HAVE BUGS AND PROBLEMS
} 


if gameScripts[currentGameId] then
    local scriptUrl = gameScripts[currentGameId]
    
    print("The game was found in the database (ID:", currentGameId..")")
    print("Loading script...", scriptUrl)
    
    -- Пытаемся загрузить и выполнить скрипт
    local success, errorMsg = pcall(function()
        local scriptContent = game:HttpGet(scriptUrl, true)
        loadstring(scriptContent)()
    end)
    
    if not success then
        warn("ERROR Loading FlameUINT:", errorMsg)
    end
else
    print("IDK THIS GAME (ID:", currentGameId..")")
end

