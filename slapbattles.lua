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
    Teleport = Window:AddTab({Title = "Teleport", Icon = "list"}),
    Other = Window:AddTab({Title = "Other", Icon = "settings"})
}

local Settings = Tabs.Main:AddSection("Anti-AFK")


local CameraToggle = Settings:AddToggle("CameraMoveEnabled", {
    Title = "Enable micro-move camera",
    Default = false,
    Callback = function(Value)
        if Value then
            StartCameraMovement()
        else
            StopCameraMovement()
        end
    end
})

IntensitySlider = Settings:AddSlider("Intensity", {
    Title = "Intensity: 1°",
    Min = 1,
    Max = 5,
    Default = 1,
    Rounding = 1,
    Callback = function(Value)
        if IntensitySlider then
            IntensitySlider:SetTitle("Intensity: "..Value.."°")
        else
            warn("IntensitySlider not initialized!")
        end
    end
})

local CameraConnection = nil
local OriginalCFrame = nil

local function MoveCamera()
    if not workspace:FindFirstChildWhichIsA("Camera") then return end
    
    local camera = workspace.CurrentCamera
    local intensity = IntensitySlider.Value
    
    if not OriginalCFrame then
        OriginalCFrame = camera.CFrame
    end
    
    for i = 1, 3 do
        local angle = math.rad(intensity * 0.3)
        camera.CFrame = OriginalCFrame * CFrame.Angles(
            0,
            math.sin(os.clock()) * angle,
            0
        )
        task.wait(0.1)
    end
    
    camera.CFrame = OriginalCFrame
end

function StartCameraMovement()
    if CameraConnection then return end
    
    OriginalCFrame = workspace.CurrentCamera.CFrame
    CameraConnection = RunService.Heartbeat:Connect(function()
        MoveCamera()
        task.wait(math.random(5, 10))
    end)
    
    Fluent:Notify({
        Title = "Micro-movements enabled",
        Content = "Camera will move smoothly",
        Duration = 3
    })
end

function StopCameraMovement()
    if CameraConnection then
        CameraConnection:Disconnect()
        CameraConnection = nil
        workspace.CurrentCamera.CFrame = OriginalCFrame or workspace.CurrentCamera.CFrame
    end
    
    Fluent:Notify({
        Title = "Micro-movements disabled",
        Content = "Camera stopped",
        Duration = 3
    })
end




-- Add to your existing script
local ESpamSection = Tabs.Main:AddSection("E-Spam")

-- Declare variables at higher scope first
local ESpamIntervalSlider = nil
local ESpamConnection = nil

-- Toggle must reference the slider object properly
local ESpamToggle = ESpamSection:AddToggle("ESpamEnabled", {
    Title = "Enable E-Spam",
    Default = false,
    Callback = function(Value)
        if Value then
            StartESpam()
        else
            StopESpam()
        end
    end
})

-- Initialize slider with proper reference
ESpamIntervalSlider = ESpamSection:AddSlider("ESpamInterval", {
    Title = "Spam interval: 0.5s",
    Min = 0.1,
    Max = 5,
    Default = 0.5,
    Rounding = 1,
    Callback = function(Value)
        if ESpamIntervalSlider then -- Safety check
            pcall(function() -- Protected call
                ESpamIntervalSlider:SetTitle("Spam interval: "..Value.."s")
            end)
        end
    end
})

local function PressE()
    pcall(function()
        local VirtualInput = game:GetService("VirtualInputManager")
        VirtualInput:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        task.wait(0.05)
        VirtualInput:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    end)
end

function StartESpam()
    if ESpamConnection then return end
    
    local interval = ESpamIntervalSlider and ESpamIntervalSlider.Value or 0.5
    
    ESpamConnection = RunService.Heartbeat:Connect(function()
        PressE()
        task.wait(interval)
    end)
    
    Fluent:Notify({
        Title = "E-Spam Enabled",
        Content = "Spamming E every "..interval.." seconds",
        Duration = 3
    })
end

function StopESpam()
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
local AFKSECT = Tabs.Teleport:AddSection("Afk/Safe")

-- Add this to your Teleport tab section
local TeleportButtons = Tabs.Teleport:AddSection("Retro/Admin")

-- Retro Start Location
TeleportButtons:AddButton({
    Title = "Retro Start",
    Description = "Teleport to Retro Start location",
    Callback = function()
        TeleportToPosition(Vector3.new(-16875.28, -3.35, 4777.20))
    end
})

-- Admin Location
TeleportButtons:AddButton({
    Title = "Admin Button",
    Description = "Teleport to Admin Button location",
    Callback = function()
        TeleportToPosition(Vector3.new(-16967.21, 797.60, 4907.06))
    end
})

-- Retro Win Location
TeleportButtons:AddButton({
    Title = "Retro Win",
    Description = "Teleport to Retro Win location",
    Callback = function()
        TeleportToPosition(Vector3.new(-27784.59, 168.14, 4832.77))
    end
})

-- Universal teleport function
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





do
    Fluent:Notify({
        Title = "Slap Battles",
        Content = "Script successfully loaded!",
        Duration = 5
    })


local createdParts = {
    safeZone = nil,
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

local function GetFPSColor(fps)
    if fps >= 120 then
        return Color3.fromRGB(255, 0, 255)
    elseif fps >= 60 then
        return Color3.fromRGB(85, 255, 85)
    elseif fps >= 30 then
        return Color3.fromRGB(255, 255, 85)
    else
        return Color3.fromRGB(255, 85, 85)
    end
end

local function GetPingColor(ping)
    if ping < 100 then
        return Color3.fromRGB(85, 255, 85)
    elseif ping < 200 then
        return Color3.fromRGB(255, 255, 85)
    else
        return Color3.fromRGB(255, 85, 85)
    end
end

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
end

Window:SelectTab(1)

do
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)
    
    SaveManager:IgnoreThemeSettings()
    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)
end

SaveManager:LoadAutoloadConfig()
