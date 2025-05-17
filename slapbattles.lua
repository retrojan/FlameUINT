local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

if game.PlaceId ~= 6403373529 then
    Fluent:Notify({
        Title = "Error!",
        Content = "This script is for Slap Battles",
        Duration = 5
    })
    return
end

local Window = Fluent:CreateWindow({
    Title = "Slap Battles",
    SubTitle = "by FlameUINT Hub",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({Title = "Main", Icon = "home"}),
    Teleport = Window:AddTab({Title = "Teleport", Icon = "map-pin"}),
    antiafk = Window:AddTab({Title = "Anti-Afk", Icon = "list"}),
    Other = Window:AddTab({Title = "Other", Icon = "settings"}),
    Farm = Window:AddTab({Title = "Farm", Icon = "list"})
}

local ESpamSection = Tabs.Main:AddSection("E-Spam Turbo")
local ESpamConnection = nil
local VirtualInput = game:GetService("VirtualInputManager")

local function PressE()
    pcall(function()
        VirtualInput:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        task.wait(0.02)
        VirtualInput:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    end)
end

local function StartESpam()
    if ESpamConnection then
        ESpamConnection:Disconnect()
    end
    
    ESpamConnection = RunService.Heartbeat:Connect(function()
        PressE()
        task.wait(0.1)
    end)
    
    Fluent:Notify({
        Title = "E-Spam Turbo Enabled",
        Content = "Ultra-fast E spamming (0.1s interval)",
        Duration = 3
    })
end

local TeleportSection = Tabs.Teleport:AddSection("Arena")

TeleportSection:AddButton({
    Title = "TP to Arena Plate",
    Description = "Teleport to the arena plate",
    Callback = function()
        local character = player.Character
        local arenaPlate = workspace:FindFirstChild("Arena"):FindFirstChild("Plate")
        
        if not arenaPlate then
            Fluent:Notify({
                Title = "Ошибка",
                Content = "Arena Plate не найдена!",
                Duration = 3
            })
            return
        end
        
        if character and character:FindFirstChild("HumanoidRootPart") then
            local position = arenaPlate.Position + Vector3.new(0, 5, 0)
            character.HumanoidRootPart.CFrame = CFrame.new(position)
            Fluent:Notify({
                Title = "Успех",
                Content = "Телепортирован на Arena Plate!",
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

local function StopESpam()
    if ESpamConnection then
        ESpamConnection:Disconnect()
        ESpamConnection = nil
    end
    
    Fluent:Notify({
        Title = "E-Spam Disabled",
        Content = "Stopped spamming E",
        Duration = 3
    })
end

ESpamSection:AddToggle("ESpamTurboEnabled", {
    Title = "Enable Turbo E-Spam",
    Description = "Spams E every 0.1 seconds",
    Default = false,
    Callback = function(Value)
        if Value then
            StartESpam()
        else
            StopESpam()
        end
    end
})

local KeypadSection = Tabs.Main:AddSection("Keypad Tools")
local keypad = nil
local keypadDetected = false
local teleportPart = nil
local DetectButton = nil

local function UpdateButton(title, desc)
    pcall(function()
        if DetectButton then
            DetectButton:SetTitle(title)
            DetectButton:SetDescription(desc or "")
        end
    end)
end

DetectButton = KeypadSection:AddButton({
    Title = "Поиск кейпада",
    Description = "Ищет кейпад в workspace",
    Callback = function()
        keypad = workspace:FindFirstChild("Keypad")
        
        if keypad then
            keypadDetected = true
            UpdateButton("Кейпад: DETECTED", "Кейпад найден в workspace")
            
            if not teleportPart then
                teleportPart = Instance.new("Part")
                teleportPart.Name = "KeypadTeleportSpot"
                teleportPart.Size = Vector3.new(4, 1, 4)
                teleportPart.Anchored = true
                teleportPart.CanCollide = true
                teleportPart.Transparency = 0.5
                teleportPart.Color = Color3.fromRGB(0, 255, 0)
                teleportPart.Position = keypad.Position + Vector3.new(0, 0, -5)
                teleportPart.Parent = workspace
            end
            
            Fluent:Notify({
                Title = "Кейпад найден",
                Content = "Кейпад успешно обнаружен",
                Duration = 3
            })
        else
            keypadDetected = false
            UpdateButton("Поиск кейпада", "Кейпад не найден")
            Fluent:Notify({
                Title = "Ошибка",
                Content = "Кейпад не найден в workspace",
                Duration = 3
            })
        end
    end
})

KeypadSection:AddButton({
    Title = "Узнать код",
    Description = "Рассчитывает код для кейпада",
    Callback = function()
        if not keypadDetected then
            Fluent:Notify({
                Title = "Ошибка",
                Content = "Сначала найдите кейпад",
                Duration = 3
            })
            return
        end
        
        local playerCount = #game:GetService("Players"):GetPlayers()
        local code = playerCount * 25 + 1100 - 7
        
        Fluent:Notify({
            Title = "Код кейпада",
            Content = "Расчетный код: "..tostring(code),
            Duration = 5
        })
    end
})

KeypadSection:AddButton({
    Title = "Телепорт к кейпаду",
    Description = "Телепортирует вас к кейпаду",
    Callback = function()
        if not keypadDetected or not keypad or not keypad.Parent then
            Fluent:Notify({
                Title = "Ошибка",
                Content = "Сначала найдите кейпад",
                Duration = 3
            })
            return
        end

        local keypadPart = keypad:FindFirstChildWhichIsA("BasePart") or keypad.PrimaryPart
        if not keypadPart then
            Fluent:Notify({
                Title = "Ошибка",
                Content = "Не найдена основная часть кейпада",
                Duration = 3
            })
            return
        end

        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
        if not humanoidRootPart then
            Fluent:Notify({
                Title = "Ошибка",
                Content = "HumanoidRootPart не найден",
                Duration = 3
            })
            return
        end

        local targetPosition
        if teleportPart and teleportPart.Parent then
            targetPosition = teleportPart.Position + Vector3.new(0, 3, 0)
        else
            targetPosition = keypadPart.Position + Vector3.new(0, 5, -5)
        end

        pcall(function()
            humanoidRootPart.CFrame = CFrame.new(targetPosition)
            
            task.wait(0.1)
            if (humanoidRootPart.Position - targetPosition).Magnitude > 10 then
                Fluent:Notify({
                    Title = "Ошибка",
                    Content = "Телепортация не удалась",
                    Duration = 3
                })
                return
            end
            
            Fluent:Notify({
                Title = "Телепортация",
                Content = "Вы успешно телепортированы к кейпаду",
                Duration = 3
            })
        end)
    end
})

task.spawn(function()
    task.wait(2)
    pcall(function()
        keypad = workspace:FindFirstChild("Keypad")
        if keypad and DetectButton then
            keypadDetected = true
            UpdateButton("Кейпад: DETECTED", "Кейпад найден автоматически")
        end
    end)
end)




local Locations = loadstring(game:HttpGet("https://raw.githubusercontent.com/retrojan/FlameUINT/main/locations.lua"))()
local TeleportSection = Tabs.Teleport:AddSection("Islands Teleport")
local AFKSECT = Tabs.Teleport:AddSection("Afk")
function TeleportToPosition(position)
    local character = game.Players.LocalPlayer.Character
    if character then
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(position)
            Fluent:Notify({
                Title = "Teleport Success",
                Content = "Teleported to selected location!",
                Duration = 3
            })
        else
            Fluent:Notify({
                Title = "Teleport Failed",
                Content = "HumanoidRootPart not found!",
                Duration = 3
            })
        end
    else
        Fluent:Notify({
            Title = "Teleport Failed",
            Content = "Character not found!",
            Duration = 3
        })
    end
end

for name, position in pairs(Locations) do
    TeleportSection:AddButton({
        Title = name,
        Description = string.format("X: %.2f, Y: %.2f, Z: %.2f", position.X, position.Y, position.Z),
        Callback = function()
            TeleportToPosition(position)
        end
    })
end
-- Секция для анти-AFK
local AntiAFKSection = Tabs.antiafk:AddSection("Анти-AFK (WASD)")

-- Переменные
local AntiAFK_Enabled = false
local AntiAFK_Thread = nil
local MovementInterval = 2 -- Интервал между движениями (секунды)
local MovementDuration = 0.2 -- Длительность нажатия клавиш (секунды)

-- Список клавиш для имитации ходьбы
local MovementKeys = {
    Enum.KeyCode.W,
    Enum.KeyCode.A,
    Enum.KeyCode.S,
    Enum.KeyCode.D
}

-- Функция для нажатия клавиш
local function SimulateMovement()
    local randomKey = MovementKeys[math.random(1, #MovementKeys)]
    
    -- Нажимаем клавишу
    VirtualInput:SendKeyEvent(true, randomKey, false, game)
    task.wait(MovementDuration)
    
    -- Отпускаем клавишу
    VirtualInput:SendKeyEvent(false, randomKey, false, game)
end

-- Запуск анти-AFK
local function StartAntiAFK()
    if AntiAFK_Thread then return end
    
    AntiAFK_Thread = task.spawn(function()
        while AntiAFK_Enabled do
            SimulateMovement()
            task.wait(MovementInterval)
        end
        AntiAFK_Thread = nil
    end)
    
    Fluent:Notify({
        Title = "Анти-AFK",
        Content = "Имитация движения включена (WASD)",
        Duration = 3
    })
end

-- Остановка анти-AFK
local function StopAntiAFK()
    if AntiAFK_Thread then
        task.cancel(AntiAFK_Thread)
        AntiAFK_Thread = nil
        
        -- Отпускаем все клавиши на случай, если одна была зажата
        for _, key in ipairs(MovementKeys) do
            VirtualInput:SendKeyEvent(false, key, false, game)
        end
    end
    
    Fluent:Notify({
        Title = "Анти-AFK",
        Content = "Имитация движения отключена",
        Duration = 3
    })
end

-- Добавляем тоггл
AntiAFKSection:AddToggle("AntiAFK_Toggle", {
    Title = "Включить анти-AFK (WASD)",
    Default = false,
    Callback = function(Value)
        AntiAFK_Enabled = Value
        if Value then
            StartAntiAFK()
        else
            StopAntiAFK()
        end
    end
})

-- Опционально: Добавляем настройки интервала
AntiAFKSection:AddSlider("MovementIntervalSlider", {
    Title = "Интервал движений: " .. MovementInterval .. " сек",
    Min = 1,
    Max = 10,
    Default = MovementInterval,
    Rounding = 1,
    Callback = function(Value)
        MovementInterval = Value
    end
})TeleportSection:AddButton({
    Title = "Copy All Coordinates",
    Description = "Copy all locations to clipboard",
    Callback = function()
        local text = ""
        for name, pos in pairs(Locations) do
            text = text .. string.format("%s = Vector3.new(%.2f, %.2f, %.2f)\n", name, pos.X, pos.Y, pos.Z)
        end
        
        if setclipboard then
            setclipboard(text)
            Fluent:Notify({
                Title = "Copied!",
                Content = "All coordinates copied to clipboard",
                Duration = 3
            })
        else
            Fluent:Notify({
                Title = "Error",
                Content = "Clipboard function not available",
                Duration = 3
            })
        end
    end
})

Fluent:Notify({
    Title = "Slap Battles",
    Content = "Script successfully loaded!",
    Duration = 5
})

local createdParts = {
    afkZone = {
        floor = nil,
        walls = {}
    }
}

local function createAFKZone()
    local targetPosition = Vector3.new(50000, 100, 50000)
    local floorSize = Vector3.new(200, 1, 200)
    local wallHeight = 40

    if not createdParts.afkZone.floor or not createdParts.afkZone.floor.Parent then
        local floor = Instance.new("Part")
        floor.Name = "AFK_Floor"
        floor.Anchored = true
        floor.Size = floorSize
        floor.Transparency = 0.5
        floor.CanCollide = true
        floor.Position = targetPosition - Vector3.new(0, 0.5, 0)
        floor.Parent = workspace
        createdParts.afkZone.floor = floor
    end

    local wallsConfig = {
        {Name = "AFK_Wall_Front", Size = Vector3.new(floorSize.X, wallHeight, 1),
         Position = targetPosition + Vector3.new(0, wallHeight/2 - 0.5, floorSize.Z/2)},
        {Name = "AFK_Wall_Back", Size = Vector3.new(floorSize.X, wallHeight, 1),
         Position = targetPosition + Vector3.new(0, wallHeight/2 - 0.5, -floorSize.Z/2)},
        {Name = "AFK_Wall_Left", Size = Vector3.new(1, wallHeight, floorSize.Z),
         Position = targetPosition + Vector3.new(-floorSize.X/2, wallHeight/2 - 0.5, 0)},
        {Name = "AFK_Wall_Right", Size = Vector3.new(1, wallHeight, floorSize.Z),
         Position = targetPosition + Vector3.new(floorSize.X/2, wallHeight/2 - 0.5, 0)},
        {Name = "AFK_Ceiling", Size = Vector3.new(floorSize.X, 1, floorSize.Z),
         Position = targetPosition + Vector3.new(0, wallHeight - 0.5, 0)}
    }

    for _, config in ipairs(wallsConfig) do
        if not createdParts.afkZone.walls[config.Name] or not createdParts.afkZone.walls[config.Name].Parent then
            local wall = Instance.new("Part")
            wall.Name = config.Name
            wall.Anchored = true
            wall.Size = config.Size
            wall.Transparency = 0.5
            wall.CanCollide = true
            wall.Material = Enum.Material.SmoothPlastic
            wall.Position = config.Position
            wall.Parent = workspace
            createdParts.afkZone.walls[config.Name] = wall
        end
    end
end
    
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local AFK_ZONE = {
    position = Vector3.new(50000, 100, 50000),
    floorSize = Vector3.new(200, 1, 200),
    wallHeight = 40,
    parts = {}
}

local function createAFKZone()
    if AFK_ZONE.parts.floor and AFK_ZONE.parts.floor.Parent then
        return AFK_ZONE.parts.floor
    end

    AFK_ZONE.parts.floor = Instance.new("Part")
    local floor = AFK_ZONE.parts.floor
    floor.Name = "AFK_Zone_Floor"
    floor.Size = AFK_ZONE.floorSize
    floor.Anchored = true
    floor.Transparency = 0.5
    floor.CanCollide = true
    floor.Position = AFK_ZONE.position - Vector3.new(0, 0.5, 0)
    floor.Parent = workspace

    local wallsConfig = {
        {name = "FrontWall", size = Vector3.new(AFK_ZONE.floorSize.X, AFK_ZONE.wallHeight, 1),
         pos = AFK_ZONE.position + Vector3.new(0, AFK_ZONE.wallHeight/2 - 0.5, AFK_ZONE.floorSize.Z/2)},
        {name = "BackWall", size = Vector3.new(AFK_ZONE.floorSize.X, AFK_ZONE.wallHeight, 1),
         pos = AFK_ZONE.position + Vector3.new(0, AFK_ZONE.wallHeight/2 - 0.5, -AFK_ZONE.floorSize.Z/2)},
        {name = "LeftWall", size = Vector3.new(1, AFK_ZONE.wallHeight, AFK_ZONE.floorSize.Z),
         pos = AFK_ZONE.position + Vector3.new(-AFK_ZONE.floorSize.X/2, AFK_ZONE.wallHeight/2 - 0.5, 0)},
        {name = "RightWall", size = Vector3.new(1, AFK_ZONE.wallHeight, AFK_ZONE.floorSize.Z),
         pos = AFK_ZONE.position + Vector3.new(AFK_ZONE.floorSize.X/2, AFK_ZONE.wallHeight/2 - 0.5, 0)},
        {name = "Ceiling", size = Vector3.new(AFK_ZONE.floorSize.X, 1, AFK_ZONE.floorSize.Z),
         pos = AFK_ZONE.position + Vector3.new(0, AFK_ZONE.wallHeight - 0.5, 0)}
    }

    for _, config in ipairs(wallsConfig) do
        AFK_ZONE.parts[config.name] = Instance.new("Part")
        local wall = AFK_ZONE.parts[config.name]
        wall.Name = "AFK_Zone_" .. config.name
        wall.Size = config.size
        wall.Anchored = true
        wall.Transparency = 0.5
        wall.CanCollide = true
        wall.Material = Enum.Material.SmoothPlastic
        wall.Position = config.pos
        wall.Parent = workspace
    end

    return floor
end

local function teleportToAFKZone()
    if not Player.Character then
        Player.CharacterAdded:Wait()
    end
    
    local humanoidRootPart = Player.Character:WaitForChild("HumanoidRootPart")
    createAFKZone()
    humanoidRootPart.CFrame = CFrame.new(AFK_ZONE.position)
    
    if Fluent then
        Fluent:Notify({
            Title = "AFK Zone",
            Content = "You have been teleported to the AFK zone!",
            Duration = 3
        })
    end
end

if Tabs and Tabs.Teleport then
    AFKSECT:AddButton({
        Title = "AFK Zone",
        Description = "Teleport to personal AFK zone",
        Callback = teleportToAFKZone
    })
end

Player.Chatted:Connect(function(message)
    if message:lower() == "/afk" then
        teleportToAFKZone()
    end
end)

local PingLabel = Tabs.Other:AddParagraph({
    Title = "Ping: -- ms",
    Content = "Network latency"
})

local FPSLabel = Tabs.Other:AddParagraph({
    Title = "FPS: --",
    Content = "Frames per second"
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

local LastTick = tick()
local FrameCount = 0
local CurrentFPS = 0

game:GetService("RunService").RenderStepped:Connect(function()
    FrameCount += 1
    local Now = tick()
    if Now - LastTick >= 0.5 then
        CurrentFPS = math.floor(FrameCount / (Now - LastTick))
        FrameCount = 0
        LastTick = Now
        FPSLabel:SetTitle("FPS: " .. CurrentFPS)
    end
end)

local function UpdatePing()
    local Success, Ping = pcall(function()
        return math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
    end)
    if not Success then
        Ping = math.floor(game:GetService("Stats").PerformanceStats.Ping:GetValue() or 0)
    end
    PingLabel:SetTitle("Ping: " .. Ping .. " ms")
end

while true do
    UpdatePing()
    task.wait(0.5)
end



SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
SaveManager:LoadAutoloadConfig()
