local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")




if game.PlaceId ~= 18550498098 then
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(17944, -130, -3540)
    Fluent:Notify({
        Title = "Error!",
        Content = "Go through the portal teleport to get into the boss fight!(Solo the boss to get nah i'd win badge)",
        Duration = 5
    })
	return
end



-- Настройки атаки
local AutoAttackEnabled = false
local AttackDelay = 0.1
local AttackConnection = nil
local ClickConnection = nil

-- Функция для клика
local function DoClick()
    -- Вариант 1: Через инструмент (если есть фонарь)
    if player.Character then
        local lantern = player.Character:FindFirstChild("Lantern") or player.Backpack:FindFirstChild("Lantern")
        if lantern then
            if not player.Character:FindFirstChild("Lantern") then
                player.Character.Humanoid:EquipTool(lantern)
                task.wait(0.2)
            end
            if player.Character:FindFirstChild("Lantern") then
                player.Character.Lantern:Activate()
            end
        end
    end
end

-- Функция для автоматического клика
local function AutoClickLoop()
    while AutoAttackEnabled do
        DoClick()
        task.wait(0.1) -- Кликаем каждую секунду
    end
end

-- Оптимизированная автоатака
local function FullAutoAttack()
    while AutoAttackEnabled and task.wait(AttackDelay) do
        if not player.Character then continue end

        local lantern = player.Character:FindFirstChild("Lantern")
        if not lantern then continue end
        
        local network = lantern:FindFirstChild("Network")
        if not network then continue end

        -- Оптимизированный поиск NPC
        for _, npc in ipairs(workspace:GetDescendants()) do
            if not AutoAttackEnabled then break end
            
            local targetPart
            if npc.Name == "ReplicaNPC" or npc.Name == "GuideNPC" then
                targetPart = npc:FindFirstChild("HumanoidRootPart")
            elseif npc.Name == "golem" then
                targetPart = npc:FindFirstChild("Hitbox")
            elseif npc.Name == "TrackGloveMissile" then
                targetPart = npc
            end
            
            if targetPart then
                network:FireServer("Hit", targetPart)
                task.wait(0.05)
            end
        end
    end
end

-- Создаем окно Fluent
local Window = Fluent:CreateWindow({
    Title = "The Guide Boss",
    SubTitle = "by FlameUINT Hub",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Создаем вкладки
local Tabs = {
    Main = Window:AddTab({ Title = "Combat", Icon = "sword" }),
    Teleport = Window:AddTab({Title = "Teleport", Icon = "list"}),
    Other = Window:AddTab({Title = "Other", Icon = "settings"})
}

-- Основная функциональность
do
    Fluent:Notify({
        Title = "Guide Boss Script",
        Content = "Script successfully loaded!",
        Duration = 5
    })

    -- Раздел телепортации
    Tabs.Teleport:AddParagraph({
        Title = "Teleportation",
        Content = "Teleport to key locations"
    })

    -- Кнопка телепорта к боссу
    Tabs.Teleport:AddButton({
        Title = "Teleport to Boss",
        Description = "Teleport to the boss arena",
        Callback = function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(3273, -75, 822)
                Fluent:Notify({
                    Title = "Teleport",
                    Content = "Teleported to boss area!",
                    Duration = 2
                })
            end
        end
    })


    -- Кнопка телепорта в безопасную зону
    Tabs.Teleport:AddButton({
        Title = "Teleport to SafeZone",
        Description = "Teleport to the safe zone",
        Callback = function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local existingSafeZone = workspace:FindFirstChild("OMOSafeZone")
                if not existingSafeZone then
                    local safeZonePart = Instance.new("Part")
                    safeZonePart.Name = "OMOSafeZone"
                    safeZonePart.Size = Vector3.new(400, 5, 400)
                    safeZonePart.Transparency = 0.8
                    safeZonePart.Anchored = true
                    safeZonePart.CanCollide = true
                    safeZonePart.Position = Vector3.new(595, 146, -330)
                    safeZonePart.Parent = workspace
                end
                
                player.Character.HumanoidRootPart.CFrame = CFrame.new(595, 150, -330)
                Fluent:Notify({
                    Title = "Teleport",
                    Content = "Teleported to safe zone!",
                    Duration = 2
                })
            end
        end
    })

    -- Раздел автоматизации
    Tabs.Main:AddParagraph({
        Title = "Automation",
        Content = "Auto combat features"
    })
    -- Тоггл автоатаки
    Tabs.Main:AddToggle("AutoAttackToggle", {
        Title = "Enable Auto Attack",
        Default = false,
        Callback = function(Value)
            AutoAttackEnabled = Value
            if Value then
                if AttackConnection then task.cancel(AttackConnection) end
                if ClickConnection then task.cancel(ClickConnection) end
                
                AttackConnection = task.spawn(FullAutoAttack)
                ClickConnection = task.spawn(AutoClickLoop)
                
                Fluent:Notify({
                    Title = "Auto Attack",
                    Content = "Auto attack has been enabled",
                    Duration = 3
                })
            else
                if AttackConnection then
                    task.cancel(AttackConnection)
                    AttackConnection = nil
                end
                if ClickConnection then
                    task.cancel(ClickConnection)
                    ClickConnection = nil
                end
                
                Fluent:Notify({
                    Title = "Auto Attack",
                    Content = "Auto attack has been disabled",
                    Duration = 3
                })
            end
        end
    })


    -- Слайдер задержки атаки
    Tabs.Main:AddSlider("AttackDelaySlider", {
        Title = "Attack Delay",
        Description = "Delay between attacks (seconds)",
        Default = 0.05,
        Min = 0.05,
        Max = 1,
        Rounding = 2,
        Callback = function(Value)
            AttackDelay = Value
        end
    })
end

    

    




-- Создаем метки
local PingLabel = Tabs.Other:AddParagraph({
    Title = "Ping: -- ms",
    Content = "Сетевая задержка"
})

local FPSLabel = Tabs.Other:AddParagraph({
    Title = "FPS: --",
    Content = "Кадры в секунду"
})

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





-- Цвета для FPS
local function GetFPSColor(fps)
    if fps >= 120 then
        return Color3.fromRGB(255, 0, 255) -- Ярко-розовый
    elseif fps >= 60 then
        return Color3.fromRGB(85, 255, 85) -- Зеленый
    elseif fps >= 30 then
        return Color3.fromRGB(255, 255, 85) -- Желтый
    else
        return Color3.fromRGB(255, 85, 85) -- Красный
    end
end

-- Цвета для Ping
local function GetPingColor(ping)
    if ping < 100 then
        return Color3.fromRGB(85, 255, 85) -- Зеленый
    elseif ping < 200 then
        return Color3.fromRGB(255, 255, 85) -- Желтый
    else
        return Color3.fromRGB(255, 85, 85) -- Красный
    end
end

-- Переменные для FPS
local LastTick = tick()
local FrameCount = 0
local CurrentFPS = 0

-- Подсчет FPS
game:GetService("RunService").RenderStepped:Connect(function()
    FrameCount += 1
    local Now = tick()
    if Now - LastTick >= 0.5 then
        CurrentFPS = math.floor(FrameCount / (Now - LastTick))
        FrameCount = 0
        LastTick = Now
        FPSLabel:SetTitle("FPS: " .. CurrentFPS) -- Просто текст без цвета
    end
end)

-- Обновление Ping
local function UpdatePing()
    local Success, Ping = pcall(function()
        return math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
    end)
    if not Success then
        Ping = math.floor(game:GetService("Stats").PerformanceStats.Ping:GetValue() or 0)
    end
    PingLabel:SetTitle("Ping: " .. Ping .. " ms") -- Просто текст без цвета
end

-- Основной цикл
while true do
    UpdatePing()
    task.wait(0.5)
end






    Window:SelectTab(1)
-- Настройки
do
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)
    
    SaveManager:IgnoreThemeSettings()
    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)
end

-- Инициализация

SaveManager:LoadAutoloadConfig()
