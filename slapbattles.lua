local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local placeInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
local placeName = placeInfo.Name or "Unknown"  

if game.PlaceId ~= 6403373529 and game.PlaceId ~= 9015014224 then
    Fluent:Notify({
        Title = "Error!",
        Content = "This script is for Slap Battles",
        Duration = 5
    })
    return
end

local Window = Fluent:CreateWindow({
    Title = placeName,
    SubTitle = "by FlameUINT Hub",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    
    Main = Window:AddTab({Title = "Main", Icon = "code"}),
    Teleport = Window:AddTab({Title = "Teleport", Icon = "map-pin"}),
    antiafk = Window:AddTab({Title = "Anti-Afk", Icon = "flag"}),
    antihelp = Window:AddTab({Title = "Antis", Icon = "shield"}),
    farm = Window:AddTab({Title = "Farm (NEW)", Icon = "user"}),
    Visual = Window:AddTab({Title = "Visual", Icon = "eye"}),
    Gloves = Window:AddTab({Title = "Gloves", Icon = "hand"}),
    Other = Window:AddTab({Title = "Other", Icon = "code"}),
}

local Options = {
    BadgeId = 0,
    Action = "nothing"
}
--[[
local autoclicksec = Tabs.Main.AddSection("Tycoon")
autoclicksec:AddToggle("AutoClickTycoon", {
    Title = "Auto Click Tycoon",
    Default = false,
    Callback = function(Value)
        _G.AutoTycoon = Value
        
        if Value then
            Fluent:Notify({
                Title = "Status",
                Content = "Auto Click Tycoon: Enabled",
                Duration = 3
            })
        end
        
        while _G.AutoTycoon do
            -- Получаем конкретный тайкун игрока
            local playerName = game.Players.LocalPlayer.Name
            local tycoon = workspace["ÅTycoon"..playerName]
            
            -- Альтернативный вариант, если имя начинается с Atycoon
            if not tycoon then
                tycoon = workspace["Atycoon"..playerName]
            end
            
            if tycoon then
                -- Проверяем все возможные варианты клик-частей
                local clickPart = tycoon:FindFirstChild("Click") or
                                 tycoon:FindFirstChild("Dropper2") or
                                 tycoon:FindFirstChild("Dropper3")
                
                if clickPart and clickPart:FindFirstChildOfClass("ClickDetector") then
                    for _ = 1, 3 do -- Тройной клик для надежности
                        fireclickdetector(clickPart.ClickDetector)
                        task.wait(0.05)
                    end
                else
                    warn("Не найдена кликабельная часть в тайкуне")
                end
            else
                warn("Тайкун не найден в workspace")
            end
            
            task.wait(0.2) -- Общая задержка между циклами
        end
    end
})
]]

local EnterSection = Tabs.Main:AddSection("Auto Arena Enter")

-- Настройки
local AutoEnterConfig = {
    Enabled = false,
    Mode = "Arena", -- По умолчанию обычная арена
    Teleports = {
        ["Arena"] = workspace.Lobby.Teleport1,
        ["Arena Default"] = workspace.Lobby.Teleport2
    }
}

-- Функция для входа на арену
local function enterArena(teleport)
    local character = game.Players.LocalPlayer.Character
    if not character then return false end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    local head = character:FindFirstChild("Head")
    
    if not humanoidRootPart or not head then return false end
    
    -- Телепортируемся к точке входа
    humanoidRootPart.CFrame = teleport.CFrame + Vector3.new(0, 3, 0)
    
    -- Активируем телепорт
    firetouchinterest(head, teleport, 0)
    task.wait()
    firetouchinterest(head, teleport, 1)
    
    return true
end

-- Создаем элементы UI
EnterSection:AddDropdown("ArenaType", {
    Title = "Arena Type",
    Description = "Select arena to auto-enter",
    Values = {"Arena", "Arena Default"},
    Default = "Arena",
    Callback = function(value)
        AutoEnterConfig.Mode = value
    end
})

EnterSection:AddToggle("AutoEnterToggle", {
    Title = "Enable Auto Enter",
    Description = "Automatically enters selected arena",
    Default = false,
    Callback = function(state)
        AutoEnterConfig.Enabled = state
        
        if state then
            coroutine.wrap(function()
                while AutoEnterConfig.Enabled do
                    -- Проверяем что персонаж загрузился
                    local character = game.Players.LocalPlayer.Character
                    if not character then
                        game.Players.LocalPlayer.CharacterAdded:Wait()
                        character = game.Players.LocalPlayer.Character
                    end
                    
                    -- Если уже на арене - пропускаем
                    if not character:FindFirstChild("entered") then
                        local teleport = AutoEnterConfig.Teleports[AutoEnterConfig.Mode]
                        if teleport and teleport.Parent then
                            enterArena(teleport)
                        end
                    end
                    
                    task.wait(1) -- Проверяем раз в секунду
                end
            end)()
            
            Fluent:Notify({
                Title = "Auto Enter",
                Content = "Enabled for " .. AutoEnterConfig.Mode,
                Duration = 3
            })
        else
            Fluent:Notify({
                Title = "Auto Enter",
                Content = "Disabled",
                Duration = 2
            })
        end
    end
})


-- Создаем секцию (например, "Void Protection")
local AntiSection = Tabs.antihelp:AddSection("Antis")


-- Anti Ragdoll
local AntiRagdollToggle = AntiSection:AddToggle("AntiRagdoll", {
    Title = "Anti Ragdoll",
    Description = "Prevents ragdoll effect on your character",
    Default = false,
    Callback = function(state)
        getgenv().AntiRagdollEnabled = state
        
        -- Wait for character if needed
        if not game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.CharacterAdded:Wait()
        end
        local character = game.Players.LocalPlayer.Character

        -- Main loop
        coroutine.wrap(function()
            while getgenv().AntiRagdollEnabled and character do
                -- Safe check for Ragdolled value
                local ragdollValue = character:FindFirstChild("Ragdolled")
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                
                if ragdollValue and ragdollValue.Value and humanoid and humanoid.Health > 0 then
                    -- Anchor torso parts
                    local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
                    local root = character:FindFirstChild("HumanoidRootPart")
                    
                    if torso then torso.Anchored = true end
                    if root then root.Anchored = true end
                    
                    -- Wait until ragdoll ends
                    repeat
                        task.wait()
                        ragdollValue = character:FindFirstChild("Ragdolled")
                    until not getgenv().AntiRagdollEnabled or not ragdollValue or not ragdollValue.Value or not character
                    
                    -- Unanchor when done
                    if character then
                        if torso and torso.Parent then torso.Anchored = false end
                        if root and root.Parent then root.Anchored = false end
                    end
                end
                task.wait(0.1)
            end
            
            -- Cleanup when disabled
            if character then
                local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
                local root = character:FindFirstChild("HumanoidRootPart")
                if torso then torso.Anchored = false end
                if root then root.Anchored = false end
            end
        end)()
    end
})

-- Connection for character changes
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    if getgenv().AntiRagdollEnabled then
        -- Reapply the effect if enabled
        AntiRagdollToggle:Set(true)
    end
end)







-- Добавляем AntiVoid Toggle внутрь этой секции
AntiSection:AddToggle("AntiVoid", {
    Title = "Enable AntiVoid",
    Description = "Spawns a large platform to prevent falling into the void.",
    Default = false,
    Callback = function(State)
        if State then
            -- Создаем платформу, если включено
            local Platform = Instance.new("Part")
            Platform.Name = "AntiVoidPlatform"
            Platform.Size = Vector3.new(3000, 2, 3000)
            Platform.Position = Vector3.new(0, -10, 0) -- X=0, Y=3, Z=0 (центр карты)
            Platform.Anchored = true
            Platform.Transparency = 0.5
            Platform.CanCollide = true
            Platform.Parent = workspace
        else
            -- Удаляем платформу, если выключено
            local ExistingPlatform = workspace:FindFirstChild("AntiVoidPlatform")
            if ExistingPlatform then
                ExistingPlatform:Destroy()
            end
        end
    end
})





-- Anti Megarock/CUSTOM
AntiSection:AddToggle("AntiMegarock", {
    Title = "Anti Megarock/CUSTOM",
    Description = "Блокирует взаимодействие с камнями",
    Default = false,
    Callback = function(state)
        getgenv().antimegarocksb = state
        task.spawn(function()
            while getgenv().antimegarocksb do
                for _, v in pairs(Players:GetPlayers()) do
                    if v.Character and v.Character:FindFirstChild("rock") then
                        v.Character.rock.CanTouch = false
                        v.Character.rock.CanQuery = false
                    end
                end
                task.wait()
            end
        end)
    end
})

-- Anti Cube Of Death
AntiSection:AddToggle("AntiCubeOfDeath", {
    Title = "Anti Cube Of Death",
    Description = "Death = false",
    Default = false,
    Callback = function(state)
        if state then
            local cube = workspace:FindFirstChild("Arena") and workspace.Arena:FindFirstChild("CubeOfDeathArea") 
                      and workspace.Arena.CubeOfDeathArea:FindFirstChild("the cube of death(i heard it kills)")
            if cube then
                cube.CanTouch = false
            end
        else
            local cube = workspace:FindFirstChild("Arena") and workspace.Arena:FindFirstChild("CubeOfDeathArea") 
                      and workspace.Arena.CubeOfDeathArea:FindFirstChild("the cube of death(i heard it kills)")
            if cube then
                cube.CanTouch = true
            end
        end
    end
})





local ESpamSection = Tabs.Main:AddSection("E-Spam")
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
        Title = "E-Spam Enabled",
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
TeleportSection:AddButton({
    Title = "TP to Barzil",
    Description = "Teleporting to barzil portal",
    Callback = function()
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Lobby.brazil.portal.CFrame
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
    Title = "Enable E-Spam",
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
    Title = "Search keypad",
    Description = "Searching keypad in workspace",
    Callback = function()
        keypad = workspace:FindFirstChild("Keypad")
        
        if keypad then
            keypadDetected = true
            UpdateButton("Keypad: detected", "Keypad detected in workspace")
            
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
                Title = "Keypad detected",
                Content = "Keypad sucesffuly detected",
                Duration = 3
            })
        else
            keypadDetected = false
            UpdateButton("Keypad: not detected", "Keypad was not found")
            Fluent:Notify({
                Title = "Error",
                Content = "Keypad not detected in workspace",
                Duration = 3
            })
        end
    end
})

KeypadSection:AddButton({
    Title = "Find code",
    Description = "Calculates the code for keypad",
    Callback = function()
        if not keypadDetected then
            Fluent:Notify({
                Title = "Error",
                Content = "First, find keypad",
                Duration = 3
            })
            return
        end
        
        local playerCount = #game:GetService("Players"):GetPlayers()
        local code = playerCount * 25 + 1100 - 7
        
        Fluent:Notify({
            Title = "Keypad code",
            Content = "Code: "..tostring(code),
            Duration = 10
        })
    end
})

KeypadSection:AddButton({
    Title = "Teleport to keypad",
    Description = "Teleports you to keypad",
    Callback = function()
        if not keypadDetected or not keypad or not keypad.Parent then
            Fluent:Notify({
                Title = "Error",
                Content = "First, find keypad",
                Duration = 3
            })
            return
        end

        local keypadPart = keypad:FindFirstChildWhichIsA("BasePart") or keypad.PrimaryPart
        if not keypadPart then
            Fluent:Notify({
                Title = "Error",
                Content = "The main part of keypad was not found",
                Duration = 3
            })
            return
        end

        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
        if not humanoidRootPart then
            Fluent:Notify({
                Title = "Error",
                Content = "HumanoidRootPart not found",
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
                    Title = "Error",
                    Content = "Teleportation failed",
                    Duration = 3
                })
                return
            end
            
            Fluent:Notify({
                Title = "Teleportation",
                Content = "You have been successfully teleported to Keypad",
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
            UpdateButton("Keypad: detected", "Keypad found automatic")
        end
    end)
end)





local NameTagSection = Tabs.Visual:AddSection("NameTag Settings")

-- Toggle для скрытия Nametag
NameTagSection:AddToggle("RemoveNameTag", {
    Title = "Remove NameTag",
    Description = "Hides your nametag (good for recordings)",
    Default = false,
    Callback = function(State)
        getgenv().HideNameTag = State

        -- Проверяем, существует ли персонаж
        local function UpdateNameTagVisibility()
            local character = game.Players.LocalPlayer.Character
            if not character then return end

            local head = character:FindFirstChild("Head")
            if not head then return end

            local nameTag = head:FindFirstChild("Nametag") or head:FindFirstChildWhichIsA("BillboardGui")
            if nameTag then
                nameTag.Enabled = not State
            end
        end

        -- Применяем сразу при включении
        UpdateNameTagVisibility()

        -- Цикл для обработки изменений (если Nametag reappears)
        if State then
            coroutine.wrap(function()
                while getgenv().HideNameTag do
                    UpdateNameTagVisibility()
                    task.wait(0.3)  -- Проверка каждые 0.3 секунды
                end
            end)()
        end
    end
})


local AutoTycoon = Tabs.Gloves:AddToggle("AutoTycoon", {
    Title = "Get Tycoon",
    Default = false,
    Callback = function(Value)
        _G.AutoTpPlate = Value
        if game.Players.LocalPlayer.Character:FindFirstChild("entered") and #game.Players:GetPlayers() >= 7 then
            while _G.AutoTpPlate do
                if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("entered") and #game.Players:GetPlayers() >= 7 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Arena.Plate.CFrame
                end
                task.wait()
            end
        elseif _G.AutoTpPlate == true then
            Fluent:Notify({
                Title = "Error",
                Content = "You need to enter arena, or have 7 people in the server",
                Duration = 5
            })
            task.wait(0.05)
            AutoTycoon:Set(false)
        end
    end
})

-- Автоматическое обновление при появлении нового персонажа
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    if getgenv().HideNameTag then
        task.wait(1)  -- Ждем загрузки модели
        local head = character:WaitForChild("Head", 5)
        if head then
            local nameTag = head:FindFirstChild("Nametag") or head:FindFirstChildWhichIsA("BillboardGui")
            if nameTag then
                nameTag.Enabled = false
            end
        end
    end
end)





local Locations = loadstring(game:HttpGet("https://raw.githubusercontent.com/retrojan/FlameUINT/main/locations.lua"))()
local TeleportSection = Tabs.Teleport:AddSection(" Teleport")
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


local BrickFarmSection = Tabs.Gloves:AddSection("Brick Farm Settings")

-- Настройки фарма с фиксированными интервалами
local BrickFarmConfig = {
    Enabled = false,
    Mode = "Slow",
    Intervals = {
        Slow = 5.05,  -- Фиксированный интервал для медленного режима
        Fast = 1.5     -- Фиксированный интервал для быстрого режима
    }
}

-- Элементы UI (только переключатель режима и тоггл)
local ModeDropdown = BrickFarmSection:AddDropdown("BrickFarmMode", {
    Title = "Farm Mode",
    Description = "Slow: 5.05s | Fast: 1.5s",  -- Добавили интервалы в описание
    Values = {"Slow", "Fast"},
    Default = "Slow",
    Callback = function(value)
        BrickFarmConfig.Mode = value
    end
})

local BrickFarmToggle = BrickFarmSection:AddToggle("BrickFarmEnabled", {
    Title = "Auto Farm Brick",
    Description = "Automatically farm bricks when equipped",
    Default = false,
    Callback = function(state)
        BrickFarmConfig.Enabled = state
        
        -- Проверка перчатки
        local glove = game.Players.LocalPlayer.leaderstats.Glove.Value
        if state and glove ~= "Brick" then
            Fluent:Notify({
                Title = "Brick Farm",
                Content = "You don't have Brick equipped!",
                Duration = 5
            })
            BrickFarmToggle:Set(false)
            return
        end

        -- Основной цикл фарма
        if state then
            coroutine.wrap(function()
                while BrickFarmConfig.Enabled and game.Players.LocalPlayer.leaderstats.Glove.Value == "Brick" do
                    local interval = BrickFarmConfig.Intervals[BrickFarmConfig.Mode]
                    
                    if BrickFarmConfig.Mode == "Slow" then
                        game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                    else
                        local success, err = pcall(function()
                            game:GetService("ReplicatedStorage").lbrick:FireServer()
                            -- Обновляем GUI счетчик
                            local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("BRICKCOUNT")
                            if gui then
                                local textLabel = gui.ImageLabel.TextLabel
                                textLabel.Text = tostring(tonumber(textLabel.Text) + 1)
                            end
                        end)
                        
                        if not success then
                            Fluent:Notify({
                                Title = "Brick Farm Error",
                                Content = "Failed to farm brick!",
                                Duration = 5
                            })
                        end
                    end
                    
                    task.wait(interval)  -- Используем фиксированный интервал
                end
                
                -- Если вышли из цикла из-за смены перчатки
                if BrickFarmConfig.Enabled and game.Players.LocalPlayer.leaderstats.Glove.Value ~= "Brick" then
                    Fluent:Notify({
                        Title = "Brick Farm",
                        Content = "Brick glove was unequipped!",
                        Duration = 5
                    })
                    BrickFarmToggle:Set(false)
                end
            end)()
        end
    end
})

-- Трекер смены перчатки (оптимизированная версия)
local function setupGloveTracking()
    local player = game.Players.LocalPlayer
    if not player then return end

    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then return end

    local gloveStat = leaderstats:FindFirstChild("Glove")
    if not gloveStat then return end

    local function onGloveChanged()
        if BrickFarmConfig.Enabled and gloveStat.Value ~= "Brick" then
            Fluent:Notify({
                Title = "Brick Farm",
                Content = "Brick glove was unequipped!",
                Duration = 5
            })
            BrickFarmToggle:Set(false)
        end
    end

    gloveStat:GetPropertyChangedSignal("Value"):Connect(onGloveChanged)
    onGloveChanged()  -- Первоначальная проверка
end

-- Запускаем трекер
coroutine.wrap(setupGloveTracking)()


local FarmSection = Tabs.farm:AddSection("Slapple Farming")

-- Конфигурация
local SlappleFarmConfig = {
    Enabled = false,
    Types = {"Slapple", "GoldenSlapple"}, -- Типы собираемых яблок
    Cooldown = 0.1 -- Задержка между проверками
}

-- Тоггл для автоферма
FarmSection:AddToggle("SlappleFarmToggle", {
    Title = "Autofarm Slapples",
    Description = "Automatically collects Slapples and Golden Slapples",
    Default = false,
    Callback = function(Value)
        SlappleFarmConfig.Enabled = Value
        
        if Value then
            coroutine.wrap(function()
                while SlappleFarmConfig.Enabled do
                    -- Проверяем что игрок на арене
                    local character = game.Players.LocalPlayer.Character
                    if character and character:FindFirstChild("entered") then
                        -- Ищем все яблоки на карте
                        for _, slapple in pairs(workspace.Arena.island5.Slapples:GetChildren()) do
                            if not SlappleFarmConfig.Enabled then break end
                            
                            -- Проверяем тип яблока и наличие TouchTransmitter
                            if table.find(SlappleFarmConfig.Types, slapple.Name) 
                               and slapple:FindFirstChild("Glove") 
                               and slapple.Glove:FindFirstChildWhichIsA("TouchTransmitter") then
                               
                                -- Активируем TouchInterest
                                firetouchinterest(character.HumanoidRootPart, slapple.Glove, 0)
                                task.wait()
                                firetouchinterest(character.HumanoidRootPart, slapple.Glove, 1)
                            end
                        end
                    end
                    task.wait(SlappleFarmConfig.Cooldown)
                end
            end)()
            
            Fluent:Notify({
                Title = "Slapple Farm",
                Content = "Autofarm activated!",
                Duration = 2
            })
        else
            Fluent:Notify({
                Title = "Slapple Farm",
                Content = "Autofarm deactivated",
                Duration = 2
            })
        end
    end
})

-- Дропдаун для выбора типа яблок
FarmSection:AddDropdown("SlappleTypes", {
    Title = "Slapple Types",
    Description = "Select which slapples to collect",
    Values = {"Slapple", "GoldenSlapple"},
    Default = {"Slapple", "GoldenSlapple"}, -- По умолчанию оба типа
    Multi = true, -- Можно выбрать несколько
    Callback = function(Selected)
        SlappleFarmConfig.Types = Selected
    end
})

-- Слайдер для настройки задержки
FarmSection:AddSlider("FarmCooldown", {
    Title = "Farm Cooldown",
    Description = "Delay between checks (seconds)",
    Default = 0.1,
    Min = 0.05,
    Max = 0.5,
    Rounding = 2,
    Callback = function(Value)
        SlappleFarmConfig.Cooldown = Value
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





local OtSection = Tabs.Other:AddSection("Other Fuctions")


local PingLabel = OtSection:AddParagraph({
    Title = "Ping: -- ms",
    Content = "Network latency"
})

local FPSLabel = OtSection:AddParagraph({
    Title = "FPS: --",
    Content = "Frames per second"
})

OtSection:AddButton({
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

OtSection:AddButton({
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


-- Перехват получения бейджа
local BadgeService = game:GetService("BadgeService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

while true do
    task.wait(1)
    
    if Options.BadgeId > 0 then
        local hasBadge = pcall(function()
            return BadgeService:UserHasBadgeAsync(LocalPlayer.UserId, Options.BadgeId)
        end)
        
        if hasBadge then
            if Options.Action == "kick" then
                LocalPlayer:Kick("Вы получили бейдж и были кикнуты!")
            elseif Options.Action == "reset" then
                LocalPlayer:LoadCharacter()
            end
            break
        end
    end
end





SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
