local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Проверка флага
if _G.FlameUINTFlag == "RunFlameUINT" then
    print("[Control] Flag valid, launching FlameUINT...")
    
    -- Сбрасываем флаг, чтобы больше не выполнялось
    _G.FlameUINTFlag = nil

    -- Запускаем FlameUINT
    loadstring(game:HttpGet("https://raw.githubusercontent.com/retrojan/FlameUINT/main/main.lua", true))()
else
    print("[Control] Flag invalid, ignoring...")
end
