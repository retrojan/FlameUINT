-- Загрузка библиотек
local Fluent, SaveManager, InterfaceManager

local success, err = pcall(function()
    Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
    InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
end)

if not success then
    warn("Ошибка загрузки библиотек: "..tostring(err))
    return
end

-- Основные сервисы
local player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")

-- Проверка игры (замените на реальный ID)
if game.PlaceId ~= 98726100529621  then
    Fluent:Notify({
        Title = "Ошибка!",
        Content = "Этот скрипт для Hexa",
        Duration = 5
    })
    return
end

-- Создание окна
local Window = Fluent:CreateWindow({
    Title = placeName,
    SubTitle = "by FlameUINT Hub",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Вкладки
local Tabs = {
    Teleport = Window:AddTab({Title = "Teleport", Icon = "list"}),
    Other = Window:AddTab({Title = "Other", Icon = "settings"}),
    Settings = Window:AddTab({Title = "Settings", Icon = "gear"})
}

-- Телепорт на Psycho
local PsychoSection = Tabs.Teleport:AddSection("Psycho Location")

PsychoSection:AddButton({
    Title = "TP to Psycho",
    Description = "Teleport to (1569.85, 33.04, -291.63)",
    Callback = function()
        local position = Vector3.new(1569.85, 33.04, -291.63)
        local character = player.Character
        
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(position)
            Fluent:Notify({
                Title = "Успех",
                Content = "Телепортирован на Psycho!",
                Duration = 3
            })
        else
            Fluent:Notify({
                Title = "Ошибка",
                Content = "Персонаж не найден!",
                Duration = 3
            })
        end
    end
})

-- Другие функции
local function SetupPerformanceUI()
    local PingLabel = Tabs.Other:AddParagraph({
        Title = "Ping: -- ms",
        Content = "Задержка сети"
    })

    local FPSLabel = Tabs.Other:AddParagraph({
        Title = "FPS: --",
        Content = "Кадры в секунду"
    })

    -- Обновление FPS
    local lastTick = tick()
    local frameCount = 0
    RunService.RenderStepped:Connect(function()
        frameCount += 1
        local now = tick()
        if now - lastTick >= 0.5 then
            FPSLabel:SetTitle("FPS: "..math.floor(frameCount/(now-lastTick)))
            frameCount = 0
            lastTick = now
        end
    end)

    -- Обновление Ping
    task.spawn(function()
        while true do
            local ping = math.floor(game:GetService("Stats").PerformanceStats.Ping:GetValue())
            PingLabel:SetTitle("Ping: "..ping.." ms")
            task.wait(1)
        end
    end)
end


    Tabs.Other:AddButton({
        Title = "FlyGUIV3",
        Description = "Activates FlyGuiV3 (Flight Script)",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
            
            Fluent:Notify({
                Title = "FlyGUIV3",
                Content = "Successfully activated!",
                Duration = 2
            })
        end
    })
    Tabs.Other:AddButton({
        Title = "Infinity Yield",
        Description = "Activates Infinity Yield",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
            
            Fluent:Notify({
                Title = "FlyGUIV3",
                Content = "Successfully activated!",
                Duration = 2
            })
        end
    })




-- Инициализация
SetupPerformanceUI()

-- Настройки SaveManager
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
SaveManager:LoadAutoloadConfig()

-- Завершение
Window:SelectTab(1)
Fluent:Notify({
    Title = "Готово",
    Content = "Скрипт успешно загружен!",
    Duration = 5
})
