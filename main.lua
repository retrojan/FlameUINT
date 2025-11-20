--[[
                                                                                                                                                                         
                                                                                                                                                                         
                                                                                                                                                                         
FFFFFFFFFFFFFFFFFFFFFFlllllll                                                               UUUUUUUU     UUUUUUUUIIIIIIIIIINNNNNNNN        NNNNNNNNTTTTTTTTTTTTTTTTTTTTTTT
F::::::::::::::::::::Fl:::::l                                                               U::::::U     U::::::UI::::::::IN:::::::N       N::::::NT:::::::::::::::::::::T
F::::::::::::::::::::Fl:::::l                                                               U::::::U     U::::::UI::::::::IN::::::::N      N::::::NT:::::::::::::::::::::T
FF::::::FFFFFFFFF::::Fl:::::l                                                               UU:::::U     U:::::UUII::::::IIN:::::::::N     N::::::NT:::::TT:::::::TT:::::T
  F:::::F       FFFFFF l::::l   aaaaaaaaaaaaa      mmmmmmm    mmmmmmm       eeeeeeeeeeee     U:::::U     U:::::U   I::::I  N::::::::::N    N::::::NTTTTTT  T:::::T  TTTTTT
  F:::::F              l::::l   a::::::::::::a   mm:::::::m  m:::::::mm   ee::::::::::::ee   U:::::D     D:::::U   I::::I  N:::::::::::N   N::::::N        T:::::T        
  F::::::FFFFFFFFFF    l::::l   aaaaaaaaa:::::a m::::::::::mm::::::::::m e::::::eeeee:::::ee U:::::D     D:::::U   I::::I  N:::::::N::::N  N::::::N        T:::::T        
  F:::::::::::::::F    l::::l            a::::a m::::::::::::::::::::::me::::::e     e:::::e U:::::D     D:::::U   I::::I  N::::::N N::::N N::::::N        T:::::T        
  F:::::::::::::::F    l::::l     aaaaaaa:::::a m:::::mmm::::::mmm:::::me:::::::eeeee::::::e U:::::D     D:::::U   I::::I  N::::::N  N::::N:::::::N        T:::::T        
  F::::::FFFFFFFFFF    l::::l   aa::::::::::::a m::::m   m::::m   m::::me:::::::::::::::::e  U:::::D     D:::::U   I::::I  N::::::N   N:::::::::::N        T:::::T        
  F:::::F              l::::l  a::::aaaa::::::a m::::m   m::::m   m::::me::::::eeeeeeeeeee   U:::::D     D:::::U   I::::I  N::::::N    N::::::::::N        T:::::T        
  F:::::F              l::::l a::::a    a:::::a m::::m   m::::m   m::::me:::::::e            U::::::U   U::::::U   I::::I  N::::::N     N:::::::::N        T:::::T        
FF:::::::FF           l::::::la::::a    a:::::a m::::m   m::::m   m::::me::::::::e           U:::::::UUU:::::::U II::::::IIN::::::N      N::::::::N      TT:::::::TT      
F::::::::FF           l::::::la:::::aaaa::::::a m::::m   m::::m   m::::m e::::::::eeeeeeee    UU:::::::::::::UU  I::::::::IN::::::N       N:::::::N      T:::::::::T      
F::::::::FF           l::::::l a::::::::::aa:::am::::m   m::::m   m::::m  ee:::::::::::::e      UU:::::::::UU    I::::::::IN::::::N        N::::::N      T:::::::::T      
FFFFFFFFFFF           llllllll  aaaaaaaaaa  aaaammmmmm   mmmmmm   mmmmmm    eeeeeeeeeeeeee        UUUUUUUUU      IIIIIIIIIINNNNNNNN         NNNNNNN      TTTTTTTTTTT      



https://github.com/retrojan/FlameUINT

===========================

RESOURCES:
Documentation: https://docs.sirius.menu/rayfield
ICONS: https://lucide.dev/icons/
===========================
Some parts of the code are taken from Giang Hub - https://github.com/Giangplay/Slap_Battles
Bypass: https://github.com/Pro666Pro/BypassAntiCheat


Happy reading!
]]









if game.PlaceId == 6403373529 or game.PlaceId == 9015014224 or game.PlaceId == 124596094333302 then

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local ScriptName = "FlameUINT "
local ScriptVersion = "15.10"
local ScriptDev = "ReTrojan"

local AntiToggles = {}
local AntiVoidPlatforms = {}
local SafeZones = {}

local placeInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
local placeNameok = placeInfo.Name or "Unknown"  

local Window = Rayfield:CreateWindow({
   Name = placeNameok .. " | FlameUINT",
   Icon = 0, 
   LoadingTitle = "FlameUINT",
   LoadingSubtitle = "by ReTrojan",
   ShowText = "FlameUINT",
   Theme = "Darker", 

   ToggleUIKeybind = "G",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, 

   Discord = {
      Enabled = false, 
      Invite = "no (yet)", 
      RememberJoins = true 
   },

})


local locationsInOrder = {
    {
        section = "Islands",
        locations = {
            {name = "Main Island", position = Vector3.new(21.27, -5.17, 4.74)},
            {name = "Left Island", position = Vector3.new(-2.39, -5.07, 217.57)},
            {name = "Right Island", position = Vector3.new(-1.50, -5.14, -214.38)},
            {name = "Cube of death Island", position = Vector3.new(-208.20, -5.28, 4.44)},
            {name = "Slapple Island", position = Vector3.new(-390.08, 50.76, -13.84)},
            {name = "Canon Island", position = Vector3.new(275.26, 33.68, 204.05)},
            {name = "Canon Island 2", position = Vector3.new(309.12, 21.63, 206.21)}
        }
    },
    {
        section = "Special",
        locations = {
            {name = "Legal Safe", position = Vector3.new(295.62, 10.74, 216.37)},
            {name = "Legal Danger Safe Slapple", position = Vector3.new(-426.32, 97.87, -35.86)},
            {name = "Slender Position", position = Vector3.new(122.83, 255.30, 1.49)},
            {name = "Tycoon", position = Vector3.new(17897.01, -23.76, -3539.31)},
        }
    }
}



local player = game.Players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats")
local Slaps = leaderstats:WaitForChild("Slaps")
local Glove = leaderstats:WaitForChild("Glove")

local function AutoEnter()
    local char = player.Character or player.CharacterAdded:Wait()
    if not char:FindFirstChild("entered") then
        local head = char:WaitForChild("Head")
        local teleport = workspace.Lobby:WaitForChild("Teleport1")

        firetouchinterest(head, teleport, 0)
        firetouchinterest(head, teleport, 1)
    end
end





local Info = Window:CreateTab("Info", "book")
local Main = Window:CreateTab("Main", "code")
local Antis = Window:CreateTab("Antis", "shield")
local Gloves = Window:CreateTab("Gloves", "hand")
local Teleport = Window:CreateTab("Teleport", "eye")
local Mastery = Window:CreateTab("Mastery", "flame")









Info:CreateSection("Script")
Info:CreateLabel("Name: " .. ScriptName)
Info:CreateLabel("Version: " .. ScriptVersion)
Info:CreateLabel("Dev: " .. ScriptDev)
Info:CreateButton({
    Name = "https://github.com/retrojan/FlameUINT",
    Callback = function()
        setclipboard("https://github.com/retrojan/FlameUINT")
        Rayfield:Notify({
            Title = "Success",
            Content = "Repository link copied to clipboard!",
            Duration = 3,
            Image = 4483362458
        })
    end
})




local SPlayer = Info:CreateSection("Player")

local SlapsLabel      = Info:CreateLabel("Slaps: Loading...")
local GloveLabel      = Info:CreateLabel("Glove: Loading...")
local AgeLabel        = Info:CreateLabel("Account Age: " .. game.Players.LocalPlayer.AccountAge .. " Days")
local ServerTimeLabel = Info:CreateLabel("In Server: Loading...")

local SServer = Info:CreateSection("Server")

local GameIDLabel     = Info:CreateLabel("GameID: " .. game.PlaceId)
local ServerIDLabel   = Info:CreateLabel("ServerID: " .. game.JobId)
local PlayersLabel    = Info:CreateLabel("Players: Loading...")
local ServerAgeLabel  = Info:CreateLabel("Server Age: Loading...")




local player = game.Players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats")
local stats = game:GetService("Stats")


local function formatTime(seconds)
    local h = math.floor(seconds / 3600)
    local m = math.floor(seconds / 60) % 60
    local s = seconds % 60
    return string.format("%02d:%02d:%02d", h, m, s)
end


local function formatNumber(n)
    local formatted = tostring(n)
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
        if k == 0 then break end
    end
    return formatted
end


local function updateLabels()
    if leaderstats:FindFirstChild("Glove") then
        GloveLabel:Set("Glove: " .. tostring(leaderstats.Glove.Value))
    else
        GloveLabel:Set("Glove: Not Found")
    end

    if leaderstats:FindFirstChild("Slaps") then
        SlapsLabel:Set("Slaps: " .. formatNumber(leaderstats.Slaps.Value))
    else
        SlapsLabel:Set("Slaps: Not Found")
    end

    PlayersLabel:Set("Players: " .. tostring(#game.Players:GetPlayers()))

    local lobby = game.Workspace:FindFirstChild("Lobby")
    if lobby and lobby:FindFirstChild("ServerAge") then
        local surf = lobby.ServerAge:FindFirstChild("Text")
        if surf and surf:FindFirstChild("SurfaceGui") and surf.SurfaceGui:FindFirstChild("TextLabel") then
            local txt = surf.SurfaceGui.TextLabel.Text
            local num = string.match(txt, "%d+") or "N/A"
            ServerAgeLabel:Set("Server Age: " .. num .. " Minutes")
        end
    end
end

local function updateServerTime()
    local seconds = math.floor(workspace.DistributedGameTime)
    ServerTimeLabel:Set("Server Time: " .. formatTime(seconds))
end

if leaderstats:FindFirstChild("Glove") then
    leaderstats.Glove:GetPropertyChangedSignal("Value"):Connect(updateLabels)
end

if leaderstats:FindFirstChild("Slaps") then
    leaderstats.Slaps:GetPropertyChangedSignal("Value"):Connect(updateLabels)
end


game.Players.PlayerAdded:Connect(updateLabels)
game.Players.PlayerRemoving:Connect(updateLabels)


task.spawn(function()
    while task.wait(1) do
        updateLabels()
        updateServerTime()
    end
end)


updateLabels()
updateServerTime()













local function TeleportToBrazilPortal()
    if game.Workspace:FindFirstChild("Lobby") and game.Workspace.Lobby:FindFirstChild("brazil") and game.Workspace.Lobby.brazil:FindFirstChild("portal") then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Lobby.brazil.portal.CFrame
        Rayfield:Notify({
            Title = "Teleport",
            Content = "Teleported to Brazil Portal",
            Duration = 3,
            Image = 4483362458
        })
    else
        Rayfield:Notify({
            Title = "Error",
            Content = "Brazil portal not found!",
            Duration = 3,
            Image = 4483362458
        })
        warn("Brazil portal not found!")
    end
end

Teleport:CreateSection("Special Teleports")

Teleport:CreateButton({
    Name = "Brazil Portal",
    Callback = function()
        TeleportToBrazilPortal()
    end
})








local function ServerHop()
    pcall(function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end)
end


--[[ DONT WORKING(New api roblox?)
local function ServerHop()

    local placeId = game.PlaceId
    local servers = {}
    local cursor = ""

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
        print("[ServerHop] Перешёл на новый сервер")
    else
        warn("❌No available servers were found!")
    end
end

]]
local function toggleCharacterFreeze(state)
    local character = game.Players.LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    
    if humanoid and root then
        if state then
            root.Anchored = true
            humanoid.MaxSlopeAngle = 0
        else
            root.Anchored = false
            humanoid.MaxSlopeAngle = 89
        end
    end
end

game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    task.wait(0.1)
    local humanoid = character:WaitForChild("Humanoid")
    local root = character:WaitForChild("HumanoidRootPart")
    
    if humanoid and root and root.Anchored then
        root.Anchored = true
        humanoid.MaxSlopeAngle = 0
    end
end)


local SUtility= Main:CreateSection("Utility")

local TABG Main:CreateToggle({
    Name = "Tab", 
    CurrentValue = false,
    Flag = "FreezeToggle",
    Callback = function(Value)
        toggleCharacterFreeze(Value)
    end
})

Main:CreateButton({
    Name = "Server Hop",
    Callback = function()
        ServerHop()
    end
})

Main:CreateButton({
    Name = "Reset", 
    Callback = function()
        local character = game.Players.LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Health = 0
            end
        end
    end
})


local idkez Main:CreateButton({
    Name = "Enter Arena",
    Callback = function()
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Head") then
            if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil then
                firetouchinterest(game.Players.LocalPlayer.Character.Head, workspace.Lobby.Teleport1, 0)
                task.wait(0.1)
                firetouchinterest(game.Players.LocalPlayer.Character.Head, workspace.Lobby.Teleport1, 1)
                
                Rayfield:Notify({
                    Title = "Arena",
                    Content = "Entering arena...",
                    Duration = 2,
                    Image = 4483362458
                })
            else
                Rayfield:Notify({
                    Title = "Arena",
                    Content = "You are already in arena!",
                    Duration = 2,
                    Image = 4483362458
                })
            end
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Character not found",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})
    



local SectSlapple = Main:CreateSection("Slapple Farm") 

local originalTransparencies = {}

local Slappleezz = Main:CreateToggle({
    Name = "Auto farm Slapples",
    CurrentValue = false,
    Flag = "SlappleFarmToggle",
    Callback = function(Value)
        SlappleFarm = Value
        
        local function toggleFlyingSlapplesVisibility(hide)
            for i, v in pairs(workspace.Arena.island5.Slapples:GetChildren()) do
                if (v.Name == "Slapple" or v.Name == "GoldenSlapple") and v:FindFirstChild("Glove") then
                    if hide then

                        if not originalTransparencies[v] then
                            originalTransparencies[v] = {}
                        end
                        
                        for _, part in pairs(v:GetDescendants()) do
                            if part:IsA("BasePart") then
                                originalTransparencies[v][part] = part.Transparency
                                part.Transparency = 1
                            end
                        end
                    else

                        if originalTransparencies[v] then
                            for part, transparency in pairs(originalTransparencies[v]) do
                                if part and part.Parent then
                                    part.Transparency = transparency
                                end
                            end
                            originalTransparencies[v] = nil
                        end
                        

                        local farAway = Vector3.new(1e6, 1e6, 1e6)
                        v:PivotTo(CFrame.new(farAway))
                    end
                end
            end
        end
        

        toggleFlyingSlapplesVisibility(Value)
        

        while SlappleFarm do
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("entered") then
                for i, v in pairs(workspace.Arena.island5.Slapples:GetChildren()) do
                    if (v.Name == "Slapple" or v.Name == "GoldenSlapple") and v:FindFirstChild("Glove") and v.Glove:FindFirstChildWhichIsA("TouchTransmitter") then
                        firetouchinterest(char.HumanoidRootPart, v.Glove, 0)
                        firetouchinterest(char.HumanoidRootPart, v.Glove, 1)
                    end
                end
            end
            task.wait()
        end
        

        toggleFlyingSlapplesVisibility(false)
    end
})

--[[ WIP
Main:CreateButton({
    Name = "Slapple Server hop",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/ex/ezSlapple.lua"))()
    end
})
]]




----------

local BrickFarmSection = Gloves:CreateSection("TRAP")

local BrickFarmConfig = {
    Enabled = false,
    Mode = "Slow",
    Intervals = {
        Slow = 5.05,
        Fast = 1.5,
        Ultra = 1.1
    }
}

local lastBrickTime = 0
local brickCooldown = 1.1

Gloves:CreateDropdown({
    Name = "Farm Mode",
    CurrentOption = "Slow",
    Options = {"Slow", "Fast", "Ultra"},
    MultipleOptions = false,
    Flag = "BrickFarmModeDropdown",
    Callback = function(value)
        BrickFarmConfig.Mode = value
    end
})

local BrickFarmToggle = Gloves:CreateToggle({
    Name = "Auto Farm Trap",
    CurrentValue = false,
    Flag = "BrickFarmToggle",
    Callback = function(Value)
        BrickFarmConfig.Enabled = Value
        local player = game.Players.LocalPlayer
        local glove = player.leaderstats.Glove.Value

        if Value and glove ~= "Brick" then
            Rayfield:Notify({
                Title = "Brick Farm",
                Content = "You don't have Brick equipped!",
                Duration = 5
            })
            BrickFarmToggle:Set(false)
            return
        end

        if Value then
            coroutine.wrap(function()
                while BrickFarmConfig.Enabled do
                    if player.leaderstats.Glove.Value ~= "Brick" then
                        Rayfield:Notify({
                            Title = "Brick Farm",
                            Content = "Brick glove was unequipped!",
                            Duration = 5
                        })
                        BrickFarmToggle:Set(false)
                        break
                    end

                    local interval = BrickFarmConfig.Intervals[BrickFarmConfig.Mode]
                    local currentTime = tick()

                    if currentTime - lastBrickTime >= brickCooldown then
                        if BrickFarmConfig.Mode == "Slow" then
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                        else
                            local success, err = pcall(function()
                                game:GetService("ReplicatedStorage").lbrick:FireServer()
                                local gui = player.PlayerGui:FindFirstChild("BRICKCOUNT")
                                if gui and gui.ImageLabel and gui.ImageLabel:FindFirstChild("TextLabel") then
                                    local textLabel = gui.ImageLabel.TextLabel
                                    textLabel.Text = tostring((tonumber(textLabel.Text) or 0) + 1)
                                end
                            end)
                            if not success then
                                Rayfield:Notify({
                                    Title = "Brick Farm Error",
                                    Content = "Failed to farm brick: " .. tostring(err),
                                    Duration = 5
                                })
                            end
                        end
                        lastBrickTime = currentTime
                    end

                    task.wait(interval)
                end
            end)()
        end
    end
})


------------

local SAntis = Antis:CreateSection("Buttons")
Antis:CreateButton({
    Name = "Enable all AntiToggles",
    Callback = function()
        for _, toggle in pairs(AntiToggles) do
            if toggle.CurrentValue == false then
                toggle:Set(true)
            end
        end
    end
})

Antis:CreateButton({
    Name = "Disable all AntiToggles",
    Callback = function()
        for _, toggle in pairs(AntiToggles) do
            if toggle.CurrentValue then
                toggle:Set(false)
            end
        end
    end
})

Antis:CreateSection("Player")
AntiToggles.AntiRagdollToggle = Antis:CreateToggle({
   Name = "Anti Ragdoll",
   CurrentValue = false,
   Callback = function(Value)
        getgenv().AntiRagdollEnabled = Value
        
        if getgenv().AntiRagdollConnection then
            getgenv().AntiRagdollConnection:Disconnect()
            getgenv().AntiRagdollConnection = nil
        end
        
        if Value then
            local function setupAntiRagdoll()
                local character = game.Players.LocalPlayer.Character
                if not character then
                    character = game.Players.LocalPlayer.CharacterAdded:Wait()
                end
                
                getgenv().AntiRagdollConnection = game:GetService("RunService").Heartbeat:Connect(function()
                    if not getgenv().AntiRagdollEnabled or not character or not character.Parent then
                        return
                    end
                    
                    local ragdollValue = character:FindFirstChild("Ragdolled")
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    
                    if ragdollValue and ragdollValue.Value and humanoid and humanoid.Health > 0 then
                        local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
                        local root = character:FindFirstChild("HumanoidRootPart")
                        
                        if torso then torso.Anchored = true end
                        if root then root.Anchored = true end
                    else
                        local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
                        local root = character:FindFirstChild("HumanoidRootPart")
                        if torso then torso.Anchored = false end
                        if root then root.Anchored = false end
                    end
                end)
            end
            
            setupAntiRagdoll()
            game.Players.LocalPlayer.CharacterAdded:Connect(function()
                if getgenv().AntiRagdollEnabled then
                    setupAntiRagdoll()
                end
            end)
        else
            local character = game.Players.LocalPlayer.Character
            if character then
                local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
                local root = character:FindFirstChild("HumanoidRootPart")
                if torso then torso.Anchored = false end
                if root then root.Anchored = false end
            end
        end
   end,
})

AntiToggles.AntiVoidToggle = Antis:CreateToggle({
    Name = "Anti Void",
    CurrentValue = false,
    Flag = "AntiVoidToggle",
    Callback = function(Value)
        if Value then
            local Platform1 = Instance.new("Part")
            Platform1.Size = Vector3.new(3000, 2, 3000)
            Platform1.Position = Vector3.new(0, -10, 0)
            Platform1.Anchored = true
            Platform1.Transparency = 0.5
            Platform1.CanCollide = true
            Platform1.Parent = workspace
            table.insert(AntiVoidPlatforms, Platform1)

            -- Tournament
            local Platform2 = Instance.new("Part")
            Platform2.Size = Vector3.new(500, 2, 500)
            Platform2.Position = Vector3.new(3426.54, 239.38, -9.97)
            Platform2.Anchored = true
            Platform2.Transparency = 0.5
            Platform2.CanCollide = true
            Platform2.Parent = workspace
            table.insert(AntiVoidPlatforms, Platform2)
        else
            for _, platform in pairs(AntiVoidPlatforms) do
                if platform and platform.Parent then
                    platform:Destroy()
                end
            end

            AntiVoidPlatforms = {}
        end
    end,
})



AntiToggles.AntiAFKToggle = Antis:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = false,
    Flag = "AntiAFK_Toggle",
    Callback = function(Value)
        _G.AntiAfk = Value
        
        for _, connection in next, getconnections(game.Players.LocalPlayer.Idled) do
            if Value then
                connection:Disable() 
            else
                connection:Enable()  
            end
        end
    end  
}) 

Antis:CreateSection("Gloves")
AntiToggles.AntiIceBinToggle = Antis:CreateToggle({
    Name = "Anti IceSkate",
    CurrentValue = false,
    Flag = "AntiIceBinToggle",
    Callback = function(Value)
        _G.AntiIceBin = Value
        
        if Value then
            task.spawn(function()
                while _G.AntiIceBin do
                    if workspace:FindFirstChild("IceBin") then
                        for _, obj in pairs(workspace.IceBin:GetDescendants()) do
                            if obj:IsA("BasePart") then
                                obj.CanCollide = false
                                obj.CanTouch = false
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        else
            if workspace:FindFirstChild("IceBin") then
                for _, obj in pairs(workspace.IceBin:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        obj.CanCollide = true
                        obj.CanTouch = true
                    end
                end
            end
        end
    end
})


AntiToggles.AntiSquidToggle = Antis:CreateToggle({
    Name = "Anti Squid",
    CurrentValue = false,
    Flag = "AntiSquidToggle",
    Callback = function(Value)
        _G.AntiSquid = Value

        local squidGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("SquidInk")
        if squidGui then
            squidGui.Enabled = not _G.AntiSquid
        end

        -- Подключаем наблюдение за изменением состояния
        if _G.AntiSquid then
            local connection
            connection = game.Players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
                if child.Name == "SquidInk" then
                    child.Enabled = false
                end
            end)

            -- Сохраняем соединение, чтобы отключить его, когда выключаем
            _G.AntiSquidConnection = connection
        else
            if _G.AntiSquidConnection then
                _G.AntiSquidConnection:Disconnect()
                _G.AntiSquidConnection = nil
            end
        end
    end
})



AntiToggles.AntiPusherToggle = Antis:CreateToggle({
    Name = "Anti Pusher",
    CurrentValue = false,
    Flag = "AntiPusherToggle",
    Callback = function(Value)
        _G.AntiPusher = Value
        
        if Value then
            task.spawn(function()
                while _G.AntiPusher do
                    for _, v in pairs(game.Workspace:GetChildren()) do
                        if v.Name == "wall" then
                            v.CanCollide = false
                        end
                    end
                    task.wait(0.3)
                end
            end)
        else
            for _, v in pairs(game.Workspace:GetChildren()) do
                if v.Name == "wall" then
                    v.CanCollide = true
                end
            end
        end
    end
})

AntiToggles.AntiIceAndPotionToggle = Antis:CreateToggle({
    Name = "Anti Ice",
    CurrentValue = false,
    Flag = "AntiIceAndPotionToggle",
    Callback = function(Value)
        _G.AntiIce = Value
        
        if Value then
            task.spawn(function()
                while _G.AntiIce do
                    if game.Players.LocalPlayer.Character then
                        for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                            if v.Name == "Icecube" then
                                v:Destroy()
                                if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                                    game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
                                    game.Players.LocalPlayer.Character.Humanoid.AutoRotate = true
                                end
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
        else
        end
    end
})




AntiToggles.AntiMailToggle = Antis:CreateToggle({
    Name = "Anti Mail",
    CurrentValue = false,
    Flag = "AntiMailToggle",
    Callback = function(Value)
        _G.AntiMail = Value
        
        if Value then
            if game.Players.LocalPlayer.Character and 
               game.Players.LocalPlayer.Character:FindFirstChild("YouHaveGotMail") then
                game.Players.LocalPlayer.Character.YouHaveGotMail.Disabled = true
            end
            
            task.spawn(function()
                while _G.AntiMail do
                    if game.Players.LocalPlayer.Character and 
                       game.Players.LocalPlayer.Character:FindFirstChild("YouHaveGotMail") then
                        game.Players.LocalPlayer.Character.YouHaveGotMail.Disabled = true
                    end
                    task.wait(0.5)
                end
            end)
        else
            if game.Players.LocalPlayer.Character and 
               game.Players.LocalPlayer.Character:FindFirstChild("YouHaveGotMail") then
                game.Players.LocalPlayer.Character.YouHaveGotMail.Disabled = false
            end
        end
    end
})

AntiToggles.AntiKickToggle = Antis:CreateToggle({
    Name = "Anti Kick",
    CurrentValue = false,
    Flag = "AntiKickToggle",
    Callback = function(Value)
        _G.AntiKick = Value
        
        if Value then
            task.spawn(function()
                while _G.AntiKick do
                    for _, v in pairs(game.CoreGui.RobloxPromptGui.promptOverlay:GetDescendants()) do
                        if v.Name == "ErrorPrompt" then
                            game:GetService("TeleportService"):TeleportToPlaceInstance(
                                game.PlaceId, 
                                game.JobId, 
                                game.Players.LocalPlayer
                            )
                            break
                        end
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

Antis:CreateSection("Other")
AntiToggles.AntiAdminToggle = Antis:CreateToggle({
    Name = "Anti Mod | Admin",
    CurrentValue = false,
    Flag = "AntiAdminToggle",
    Callback = function(Value)
        _G.AntiMods = Value
        
        if Value then
            task.spawn(function()
                while _G.AntiMods do
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player:GetRankInGroup(9950771) >= 2 then
                            _G.AntiKick = false
                            
                            Rayfield:Notify({
                                Title = "Anti Admin",
                                Content = "DETECTED: " .. player.Name,
                                Duration = 3
                            })
                            
                            task.wait(1)
                            game.Players.LocalPlayer:Kick("High Rank Player Detected. [ " .. player.Name .. " ]")
                            break
                        end
                    end
                    task.wait(1)
                end
            end)
        end
    end
})
Antis:CreateSection("Objects")

AntiToggles.AntiLava = Antis:CreateToggle({
    Name = "Anti Lava (Cannon Island)",
    CurrentValue = false,
    Flag = "Lavatogglecannon",
    Callback = function(Value)
        local trap1 = workspace.Arena.CannonIsland["Cannon Island [OLD]"].Traps:GetChildren()[2].Hitbox
        local trap2 = workspace.Arena.CannonIsland["Cannon Island [OLD]"].Traps.TrapEmitter.Hitbox

        trap1.CanQuery = not Value and true or false
        trap1.CanTouch = not Value and true or false
        trap2.CanQuery = not Value and true or false
        trap2.CanTouch = not Value and true or false
    end,
})


AntiToggles.AntiCubeOfDeathToggle = Antis:CreateToggle({
    Name = "Anti Cube Of Death",
    CurrentValue = false,
    Flag = "AntiCubeOfDeathToggle",
    Callback = function(Value)
        if Value then
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


local AutoSection = Gloves:CreateSection("AUTO")
local AutoTycoonToggle = Gloves:CreateToggle({
    Name = "Get Tycoon",
    CurrentValue = false,
    Flag = "AutoTycoonToggle",
    Callback = function(Value)
        _G.AutoTpPlate = Value
        
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local plate = workspace.Arena:WaitForChild("Plate")

        while _G.AutoTpPlate do
            char = player.Character or player.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")
            if not char:FindFirstChild("entered") then
                local head = char:WaitForChild("Head")
                local teleport = workspace.Lobby:WaitForChild("Teleport1")
                firetouchinterest(head, teleport, 0)
                firetouchinterest(head, teleport, 1)
                task.wait(0.5)
            end

            if char:FindFirstChild("entered") and #game.Players:GetPlayers() >= 7 then
                hrp.CFrame = plate.CFrame + Vector3.new(0, 2, 0)
            end
            if char:FindFirstChild("entered") then
                local distance = (hrp.Position - plate.Position).Magnitude
                if distance > 25 then
                    hrp.CFrame = plate.CFrame + Vector3.new(0, 2, 0)
                end
            end

            task.wait(0.2)
        end
        if _G.AutoTpPlate == true and (not char:FindFirstChild("entered") or #game.Players:GetPlayers() < 7) then
            Rayfield:Notify({
                Title = "Error",
                Content = "You need have 7 people in the server",
                Duration = 5
            })
            task.wait(0.05)
            AutoTycoonToggle:Set(false)
        end
    end
})


Gloves:CreateButton({
	Name = "Get Admin",
	Callback = function()
		local teleportFunc = queueonteleport or queue_on_teleport
		if teleportFunc then
			teleportFunc([[
				if not game:IsLoaded() then
					game.Loaded:Wait()
				end
                if game.PlaceId ~= 16034567693 then
                    return
                end
				repeat wait() until game.Players.LocalPlayer
				wait(13.5)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(502, 76, 59)
				task.wait(6)
				if getconnections then
					for i,v in next, getconnections(game.Players.LocalPlayer.Idled) do
						v:Disable() 
					end
				end
                local player = game.Players.LocalPlayer
                local playerGui = player:WaitForChild("PlayerGui")

                local screenGui = Instance.new("ScreenGui")
                screenGui.Name = "AntiAfkGui"
                screenGui.Parent = playerGui

                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(0, 200, 0, 100)
                frame.Position = UDim2.new(0.8, 0, 0.05, 0)
                frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                frame.BorderSizePixel = 0
                frame.BackgroundTransparency = 0.3
                frame.Parent = screenGui
                frame.AnchorPoint = Vector2.new(0.5, 0.5)

                local statusLabel = Instance.new("TextLabel")
                statusLabel.Size = UDim2.new(1, -10, 0.5, -5)
                statusLabel.Position = UDim2.new(0, 5, 0, 5)
                statusLabel.Text = "Anti-AFK: ON"
                statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                statusLabel.Font = Enum.Font.GothamBold
                statusLabel.TextSize = 20
                statusLabel.BackgroundTransparency = 1
                statusLabel.Parent = frame

                local timerLabel = Instance.new("TextLabel")
                timerLabel.Size = UDim2.new(1, -10, 0.5, -5)
                timerLabel.Position = UDim2.new(0, 5, 0.5, 0)
                timerLabel.Text = "00:00"
                timerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                timerLabel.Font = Enum.Font.GothamBold
                timerLabel.TextSize = 18
                timerLabel.BackgroundTransparency = 1
                timerLabel.Parent = frame

                local secondsElapsed = 0

                spawn(function()
                    while true do
                        secondsElapsed = secondsElapsed + 1
                        local minutes = math.floor(secondsElapsed / 60)
                        local seconds = secondsElapsed % 60
                        timerLabel.Text = string.format("%02d:%02d", minutes, seconds)
                        wait(1)
                    end
                end)

			]])
		end

        local retro = game.ReplicatedStorage.Assets:FindFirstChild("Retro")
        if retro and not game.Workspace:FindFirstChild("Retro") then
            retro.Parent = game.Workspace
            wait(1)
        end
        
        local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        char.HumanoidRootPart.CFrame = CFrame.new(-16970.99, 797.60, 4908.73)
            Rayfield:Notify({
            Title = "CLICK ON GREEN BUTTON",
            Content = "CLICK ON GREEN BUTTON",
            Duration = 10
        })
	end    
})

Gloves:CreateButton({
   Name = "Get Glovel",
   Callback = function()
        AutoEnter()
        task.wait(0.5)
      local player = game.Players.LocalPlayer
      local char = player.Character

      if char and char:FindFirstChild("entered") then
         repeat task.wait()
            char.HumanoidRootPart.CFrame = CFrame.new(289, 13, 261)
            game:GetService("ReplicatedStorage").DigEvent:FireServer({
               ["index"] = 2,
               ["cf"] = CFrame.new(42.7222366, -6.17449856, 91.5175781, -0.414533257, 1.72594355e-05, -0.91003418, -5.57037238e-05, 1, 4.4339522e-05, 0.91003418, 6.90724992e-05, -0.414533257)
            })
         until game.Workspace:FindFirstChild("TreasureChestFolder") 
         and game.Workspace.TreasureChestFolder:FindFirstChild("TreasureChest")

         task.wait(1)
         game.Workspace.TreasureChestFolder.TreasureChest.OpenRemote:FireServer()
         task.wait(0.9)
         game.ReplicatedStorage.HumanoidDied:FireServer(char, false)
         task.wait(3.75)
         char.HumanoidRootPart.CFrame = workspace.BountyHunterRoom.BountyHunterBooth._configPart.CFrame * CFrame.new(-5,0,0)
      end
   end
})

Gloves:CreateButton({
    Name = "Get Iceskate",
    Callback = function()
        if not game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2906002612987222) then
            game:GetService("ReplicatedStorage").IceSkate:FireServer("Freeze")
            
        else
        Rayfield:Notify({
            Title = "FlameUINT",
            Content = "U have this glove",
            Duration = 3
        })
        end
    end
})



Gloves:CreateButton({
    Name = "Get Plank",
    Callback = function()
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
                                                    --and not game:GetService("BadgeService"):UserHasBadgeAsync(player.UserId, 4031317971987872)        
        if player.leaderstats.Glove.Value == "Fort" then
            if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil then
            firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 0)
            firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 1)
            wait(0.5)
            end
            local OGL = hrp.CFrame
            hrp.CFrame = CFrame.new(7000, 97, 4)
            task.wait(0.2)
            hrp.Anchored = true
            task.wait(0.3)
            game:GetService("ReplicatedStorage").Fortlol:FireServer()
            task.wait(3.5)
            hrp.Anchored = false
            task.wait(0.1)
            hrp.CFrame = CFrame.new(7000, 106, -6)
            task.wait(0.5)
            hrp.CFrame = OGL
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "You don't have Fort equipped, or you have owner badge [ Don't turn on shiftlock ]",
                Duration = 5,
                Image = 7733658504
            })
        end
    end,
})




Gloves:CreateButton({
    Name = "Get Frostbite",
    Callback = function()
        if not (queueonteleport or queue_on_teleport) then
            return
        end
        
        local teleportFunc = queueonteleport or queue_on_teleport
        
        teleportFunc([[
            if not game:IsLoaded() then
                game.Loaded:Wait()
            end
            if game.PlaceId ~= 17290438723 then
                return
            end
            local player = game.Players.LocalPlayer
            repeat wait() until player
            
            while not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") do
                wait(0.5)
            end
            
            player.Character.HumanoidRootPart.CFrame = CFrame.new(-554, 177, 56)
            wait(1.5)
            
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("ProximityPrompt") then
                    fireproximityprompt(obj)
                    wait(0.3)
                end
            end
            
            print("FrostBite glove automation completed!")
        ]])
        
        Rayfield:Notify({
            Title = "Teleporting",
            Content = "Going to Get FrostBite",
            Duration = 3
        })
        
        local ts = game:GetService("TeleportService")
        ts:Teleport(17290438723)
    end    
})


Gloves:CreateButton({
    Name = "Get Elude",
    Callback = function()
        local teleportFunc = queueonteleport or queue_on_teleport
        
        if teleportFunc then
            teleportFunc([[
                if not game:IsLoaded() then
                    game.Loaded:Wait()
                end

                if game.PlaceId ~= 11828384869 then
                    return
                end

                wait(2)
                
                if workspace:FindFirstChild("Ruins") and workspace.Ruins:FindFirstChild("Elude") and workspace.Ruins.Elude:FindFirstChild("Glove") then
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Ruins.Elude.Glove, 0)
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Ruins.Elude.Glove, 1)
                end
                
                if workspace:FindFirstChild("Maze") then
                    for _, v in pairs(workspace.Maze:GetDescendants()) do
                        if v:IsA("ClickDetector") then
                            fireclickdetector(v)
                        end
                    end
                end
            ]])
            
            game:GetService("TeleportService"):Teleport(11828384869)
            
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Your executor doesn't support auto teleport",
                Duration = 5
            })
        end
    end    
})


Gloves:CreateButton({
    Name = "Get Lamp",
    Callback = function()
        if game.Players.LocalPlayer.leaderstats.Glove.Value == "ZZZZZZZ" and not game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 490455814138437) then
            Rayfield:Notify({
                Title = "Free Lamp",
                Content = "Starting to get free lamp...",
                Duration = 3
            })
            
            task.spawn(function()
                repeat 
                    task.wait()
                    game:GetService("ReplicatedStorage").nightmare:FireServer("LightBroken")
                until game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 490455814138437)
                
                Rayfield:Notify({
                    Title = "Success",
                    Content = "Free lamp obtained successfully!",
                    Duration = 5
                })
            end)
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "You don't have ZZZZZZZ equipped, or already have Owner badge",
                Duration = 5
            })
        end
    end 
})


-- Siphon fixed
local OrbSection = Gloves:CreateSection("ORBS")

local SiphonFarmToggle = Gloves:CreateToggle({
    Name = "Siphon Farm",
    CurrentValue = false,
    Flag = "SiphonFarmToggle",
    Callback = function(Value)
        _G.Siphonfarm = Value
        while _G.Siphonfarm do
            if game.Workspace:FindFirstChild("SiphonOrb") then
                for _, v in pairs(game.Workspace:GetChildren()) do
                    if v.Name == "SiphonOrb" then
                        firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), v, 0)
                        firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), v, 1)
                    end
                end
            end
            task.wait()
        end
    end
})


local PhaseToggle = Gloves:CreateToggle({
    Name = "Phase Farm",
    CurrentValue = false,
    Flag = "PhaseToggle",
    Callback = function(Value)
        _G.PhaseFarm = Value

        if Value then
            task.spawn(function()
                while _G.PhaseFarm do
                    local character = game.Players.LocalPlayer.Character
                    if character and character:FindFirstChild("Head") then
                        for _, v in pairs(game.Workspace:GetChildren()) do
                            if not _G.PhaseFarm then break end
                            if v.Name == "PhaseOrb" then
                                firetouchinterest(character.Head, v, 0)
                                task.wait()
                                firetouchinterest(character.Head, v, 1)
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})

local JetToggle = Gloves:CreateToggle({
    Name = "Jet Farm",
    CurrentValue = false,
    Flag = "JetToggle",
    Callback = function(Value)
        _G.JetFarm = Value

        if Value then
            task.spawn(function()
                while _G.JetFarm do
                    local character = game.Players.LocalPlayer.Character
                    if character and character:FindFirstChild("Head") then
                        for _, v in pairs(game.Workspace:GetChildren()) do
                            if not _G.JetFarm then break end
                            if v.Name == "JetOrb" then
                                firetouchinterest(character.Head, v, 0)
                                task.wait()
                                firetouchinterest(character.Head, v, 1)
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})



local PhaseJetGlitchToggle = Gloves:CreateToggle({
    Name = "Glitch Farm",
    CurrentValue = false,
    Flag = "PhaseJetGlitchToggle",
    Callback = function(Value)
        _G.Glitchfarm = Value
        
        if Value then
            spawn(function()
                while _G.Glitchfarm do
                    if game.Players.LocalPlayer.leaderstats.Glove.Value == "Error" then
                        if game.Workspace:FindFirstChild("JetOrb") or game.Workspace:FindFirstChild("PhaseOrb") then
                            for _, v in pairs(game.Workspace:GetChildren()) do
                                if v.Name == "JetOrb" or v.Name == "PhaseOrb" then
                                    game.ReplicatedStorage.Errorhit:FireServer(v)
                                end
                            end
                        end
                    end
                    task.wait()
                end
            end)
        end
    end
})





game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    if getgenv().HideNameTag then
        task.wait(1)
        local head = character:WaitForChild("Head", 5)
        if head then
            local nameTag = head:FindFirstChild("Nametag") or head:FindFirstChildWhichIsA("BillboardGui")
            if nameTag then
                nameTag.Enabled = false
            end
        end
    end
end)

local function findAndUseGlove()
    local player = game.Players.LocalPlayer
    
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then return end
    
    local gloveStat = leaderstats:FindFirstChild("Glove")
    if not gloveStat then return end
    
    local targetGloveName = gloveStat.Value
    if not targetGloveName or targetGloveName == "" then return end
    
    if player.Character then
        local equippedTool = player.Character:FindFirstChildOfClass("Tool")
        if equippedTool and equippedTool.Name == targetGloveName then
            pcall(function() equippedTool:Activate() end)
            return
        end
    end
    
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        for _, tool in ipairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == targetGloveName then
                if player.Character then
                    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid:EquipTool(tool)
                        task.wait(0.1)
                        pcall(function() tool:Activate() end)
                    end
                end
                return
            end
        end
    end
end

local autoUseEnabled = false
local autoUseDelay = 0.5
local autoUseConnection = nil

local Sgeneral = Mastery:CreateSection("Auto Slap")

Mastery:CreateToggle({
    Name = "Auto Slap",
    CurrentValue = false,
    Flag = "AutoGloveToggle",
    Callback = function(value)
        autoUseEnabled = value

        if autoUseConnection then
            autoUseConnection:Disconnect()
            autoUseConnection = nil
        end

        if value then
            autoUseConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if autoUseEnabled then
                    findAndUseGlove()
                    task.wait(autoUseDelay)
                end
            end)
        end
    end,
})

Mastery:CreateSlider({
    Name = "Auto Slap Delay",
    Range = {0.1, 2},
    Increment = 0.1,
    Suffix = "s",
    CurrentValue = autoUseDelay,
    Flag = "AutoGloveDelay",
    Callback = function(value)
        autoUseDelay = value
    end,
})

local Sgeneral = Mastery:CreateSection("Spam E")

local autoPressE = false
local pressInterval = 0.1

local ESpam = Mastery:CreateToggle({
    Name = "Auto spam E",
    CurrentValue = false,
    Flag = "AutoEToggle",
    Callback = function(Value)
        autoPressE = Value
        if Value then

        end
    end,
})

local function pressE()
    local virtualInput = game:GetService("VirtualInputManager")
    virtualInput:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    virtualInput:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

task.spawn(function()
    while true do
        if autoPressE then
            pressE()
        end
        task.wait(pressInterval)
    end
end)

local ESlider = Mastery:CreateSlider({
    Name = "Speed click",
    Range = {0.05, 2},
    Increment = 0.05,
    Suffix = "S",
    CurrentValue = pressInterval,
    Flag = "SpeedSlider",
    Callback = function(Value)
        pressInterval = Value
    end,
})


local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local AFK_ZONE = {
    position = Vector3.new(0, -497, 0), 
    floorSize = Vector3.new(200, 4, 200),
    wallHeight = 40,
    parts = {}
}


local function getRandomAFKPosition()
    local x = math.random(5000, 30000)
    local z = math.random(5000, 30000)
    local y = math.random(-18000, 0) 
    return Vector3.new(x, y, z)
end

local function createAFKZone()

    if AFK_ZONE.parts.floor then
        for _, part in pairs(AFK_ZONE.parts) do
            if part and part.Parent then
                part:Destroy()
            end
        end
        AFK_ZONE.parts = {} 
    end

    AFK_ZONE.position = getRandomAFKPosition()


    local floor = Instance.new("Part")
    floor.Name = "AFK_Zone_Floor"
    floor.Size = AFK_ZONE.floorSize
    floor.Anchored = true
    floor.Transparency = 0.5
    floor.CanCollide = true
    floor.Position = AFK_ZONE.position - Vector3.new(0, 0.5, 0)
    floor.Parent = workspace
    AFK_ZONE.parts.floor = floor


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
        local wall = Instance.new("Part")
        wall.Name = "AFK_Zone_" .. config.name
        wall.Size = config.size
        wall.Anchored = true
        wall.Transparency = 0.5
        wall.CanCollide = true
        wall.Position = config.pos
        wall.Parent = workspace
        AFK_ZONE.parts[config.name] = wall
    end
    table.insert(SafeZones, floor)
    return floor
end

local function teleportToAFKZone()
    if not Player.Character then
        Player.CharacterAdded:Wait()
    end

    local humanoidRootPart = Player.Character:WaitForChild("HumanoidRootPart")
    AutoEnter()
    wait(0.5)
    createAFKZone()
    humanoidRootPart.CFrame = CFrame.new(AFK_ZONE.position)
    

    if Rayfield then
        Rayfield:Notify({
            Title = "Safe Spot",
            Content = "You have been teleported to the Safe Spot!",
            Duration = 3
        })
    end
end




local DUO_AFK_ZONE = {
    position = Vector3.new(50000, -15000, 50000),
    floorSize = Vector3.new(200, 4, 200),
    wallHeight = 40,
    parts = {}
}

local function createDUOAFKZone()
    if DUO_AFK_ZONE.parts.floor and DUO_AFK_ZONE.parts.floor.Parent then
        return DUO_AFK_ZONE.parts.floor
    end

    DUO_AFK_ZONE.parts.floor = Instance.new("Part")
    local floor = DUO_AFK_ZONE.parts.floor
    floor.Name = "DUO_AFK_Zone_Floor"
    floor.Size = DUO_AFK_ZONE.floorSize
    floor.Anchored = true
    floor.Transparency = 0.5
    floor.CanCollide = true
    floor.Position = DUO_AFK_ZONE.position - Vector3.new(0, 0.5, 0)
    floor.Parent = workspace

    local wallsConfig = {
        {name = "FrontWall", size = Vector3.new(DUO_AFK_ZONE.floorSize.X, DUO_AFK_ZONE.wallHeight, 1),
         pos = DUO_AFK_ZONE.position + Vector3.new(0, DUO_AFK_ZONE.wallHeight/2 - 0.5, DUO_AFK_ZONE.floorSize.Z/2)},
        {name = "BackWall", size = Vector3.new(DUO_AFK_ZONE.floorSize.X, DUO_AFK_ZONE.wallHeight, 1),
         pos = DUO_AFK_ZONE.position + Vector3.new(0, DUO_AFK_ZONE.wallHeight/2 - 0.5, -DUO_AFK_ZONE.floorSize.Z/2)},
        {name = "LeftWall", size = Vector3.new(1, DUO_AFK_ZONE.wallHeight, DUO_AFK_ZONE.floorSize.Z),
         pos = DUO_AFK_ZONE.position + Vector3.new(-DUO_AFK_ZONE.floorSize.X/2, DUO_AFK_ZONE.wallHeight/2 - 0.5, 0)},
        {name = "RightWall", size = Vector3.new(1, DUO_AFK_ZONE.wallHeight, DUO_AFK_ZONE.floorSize.Z),
         pos = DUO_AFK_ZONE.position + Vector3.new(DUO_AFK_ZONE.floorSize.X/2, DUO_AFK_ZONE.wallHeight/2 - 0.5, 0)},
        {name = "Ceiling", size = Vector3.new(DUO_AFK_ZONE.floorSize.X, 1, DUO_AFK_ZONE.floorSize.Z),
         pos = DUO_AFK_ZONE.position + Vector3.new(0, DUO_AFK_ZONE.wallHeight - 0.5, 0)}
    }

    for _, config in ipairs(wallsConfig) do
        DUO_AFK_ZONE.parts[config.name] = Instance.new("Part")
        local wall = DUO_AFK_ZONE.parts[config.name]
        wall.Name = "DUO_AFK_Zone_" .. config.name
        wall.Size = config.size
        wall.Anchored = true
        wall.Transparency = 0.5
        wall.CanCollide = true
        wall.Material = Enum.Material.SmoothPlastic
        wall.Position = config.pos
        wall.Parent = workspace
    end
    table.insert(SafeZones, floor)
    return floor
end


local function teleportToDUOAFKZone()
    if not Player.Character then
        Player.CharacterAdded:Wait()
    end

    local humanoidRootPart = Player.Character:WaitForChild("HumanoidRootPart")
    AutoEnter()
    wait(0.5)
    createDUOAFKZone()
    humanoidRootPart.CFrame = CFrame.new(DUO_AFK_ZONE.position)
    

    if Rayfield then
        Rayfield:Notify({
            Title = "Safe Spot",
            Content = "You have been teleported to the Safe Spot!",
            Duration = 3
        })
    end
end






local AFKSECT = Teleport:CreateSection("Safe Spot")

Teleport:CreateButton({
    Name = "Solo Safe Spot",
    Callback = function()
        teleportToAFKZone()
    end
})

Teleport:CreateButton({
    Name = "Duo Safe Spot",
    Callback = function()
        teleportToDUOAFKZone()
    end
})

local function TeleportTo(position)
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

for _, sectionData in ipairs(locationsInOrder) do
    local section = Teleport:CreateSection(sectionData.section)
    
    for _, location in ipairs(sectionData.locations) do
        Teleport:CreateButton({
            Name = location.name,
            Callback = function()
                if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil then
                    firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 0)
                    firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 1)
                    task.wait(0.5)
                end

                TeleportTo(location.position)
                Rayfield:Notify({
                    Title = "Teleport",
                    Content = "Teleported to " .. location.name,
                    Duration = 3,
                    Image = 4483362458
                })
            end
        })
    end
end




--[[


=========== COMING SOON ===========

local TimeG = Gloves:CreateSection("Time Gloves")


local fishfarm Gloves:CreateButton("Get fish", function()

    if game.Players.LocalPlayer.leaderstats.Glove.Value ~= "ZZZZZZZ" then
        Rayfield:Notify({
            Title = "Error",
            Content = "u dont have ZZZZZZZ!",
            Duration = 5,
            Image = 4483362458
        })
        return
    end
    
    if not Player.Character then
        Player.CharacterAdded:Wait()
    end
    
    local humanoidRootPart = Player.Character:WaitForChild("HumanoidRootPart")
    createAFKZone()
    humanoidRootPart.CFrame = CFrame.new(AFK_ZONE.position)
    
    Rayfield:Notify({
        Title = "Succes",
        Content = "teleported to Safe Spot",
        Duration = 5,
        Image = 4483362458
    })
    
    local EConnection
    EConnection = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.E then
            EConnection:Disconnect() 
            

            if not _G.antiAfkEnabled then
                Rayfield.Flags["AntiAFK_Toggle"]:Set(true) 
            end

        end
    end)
end)


]]

_G.ReachValue = 10

local OrbSection = Main:CreateSection("Slap Aura")
local AuraToggle = Main:CreateToggle({
    Name = "Slap Aura",
    CurrentValue = false,
    Flag = "AuraToggle",
    Callback = function(Value)
        _G.SlapAuraEnabled = Value
        _G.HitboxesEnabled = Value
        
        if Value then
            
            if _G.ReachValue == nil then
                _G.ReachValue = 10
            end
            
            
            spawn(function()
                while _G.SlapAuraEnabled do
                    for i, v in pairs(game.Players:GetPlayers()) do
                        if v ~= game.Players.LocalPlayer then
                            local character = v.Character
                            local localChar = game.Players.LocalPlayer.Character
                            
                            if character and localChar and localChar:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("HumanoidRootPart") then
                                local canSlap = character:FindFirstChild("entered") and 
                                              character.Ragdolled.Value == false and 
                                              character:FindFirstChild("Torso") and 
                                              character.Torso.Anchored ~= false and 
                                              character:FindFirstChild("Mirage") == nil
                                
                                if canSlap then
                                    local Magnitude = (localChar.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
                                    if _G.ReachValue and _G.ReachValue >= Magnitude then
                                        game.ReplicatedStorage.KSHit:FireServer(character:WaitForChild("HumanoidRootPart"), true)
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.15)
                end
            end)
            
            
            spawn(function()
                while _G.HitboxesEnabled do
                    for i, v in pairs(game.Players:GetPlayers()) do
                        if v ~= game.Players.LocalPlayer then
                            local character = v.Character
                            if character and character:FindFirstChild("HumanoidRootPart") then
                                
                                local hitboxSize = _G.ReachValue or 10
                                
                                character.HumanoidRootPart.Size = Vector3.new(hitboxSize * 0.8, hitboxSize * 0.8, hitboxSize * 0.8)
                                character.HumanoidRootPart.Transparency = 0.9 -- Почти прозрачная
                                character.HumanoidRootPart.Material = Enum.Material.Neon
                                character.HumanoidRootPart.Color = Color3.fromRGB(255, 255, 255)
                                character.HumanoidRootPart.BrickColor = BrickColor.new("Institutional white")
                                
                                if not character.HumanoidRootPart:FindFirstChild("HitboxOutline") then
                                    
                                    local selectionBox = Instance.new("SelectionBox")
                                    selectionBox.Name = "HitboxOutline"
                                    selectionBox.Adornee = character.HumanoidRootPart
                                    selectionBox.LineThickness = 0.05
                                    selectionBox.Color3 = Color3.fromRGB(255, 255, 255)
                                    selectionBox.Transparency = 0
                                    selectionBox.Parent = character.HumanoidRootPart
                                else

                                    local selectionBox = character.HumanoidRootPart:FindFirstChild("HitboxOutline")
                                    if selectionBox then
                                        selectionBox.Adornee = character.HumanoidRootPart
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.3)
                end
            end)
        else
            for i, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer then
                    local character = v.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                        character.HumanoidRootPart.Transparency = 1
                        character.HumanoidRootPart.Material = Enum.Material.Plastic
                        character.HumanoidRootPart.Color = Color3.fromRGB(255, 255, 255)
                        
                        local outline = character.HumanoidRootPart:FindFirstChild("HitboxOutline")
                        if outline then
                            outline:Destroy()
                        end
                    end
                end
            end
        end
    end
})

local ReachSlider = Main:CreateSlider({
    Name = "Reach & Hitbox Size",
    Range = {5, 20},
    Increment = 1,
    Suffix = "studs",
    CurrentValue = _G.ReachValue,
    Flag = "ReachSliderez",
    Callback = function(Value)
        _G.ReachValue = Value
        if _G.HitboxesEnabled then
            for i, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer then
                    local character = v.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        character.HumanoidRootPart.Size = Vector3.new(Value * 0.8, Value * 0.8, Value * 0.8)
                    end
                end
            end
        end
    end
})






local Sbob = Gloves:CreateSection("BOB")
Gloves:CreateButton({
    Name = "Farm bob (NEW)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/ex/bobfarm.lua"))()
    end
})
--[[
local AutoFarmBobToggle = Gloves:CreateToggle({
    Name = "Auto Farm Bob (Classic)",
    CurrentValue = false,
    Flag = "AutoFarmBobToggle",
    Callback = function(Value)
        _G.AutoFarmBob = Value
        
        if Value then
            local glove = game.Players.LocalPlayer.leaderstats.Glove.Value
            if glove ~= "Replica" then 
                Rayfield:Notify({
                    Title = "Error",
                    Content = "Need Replica!",
                    Duration = 5
                })
                AutoFarmBobToggle:Set(false)
                return
            end
            
            spawn(function()
                while _G.AutoFarmBob do
                    local character = game.Players.LocalPlayer.Character
                    if not character then
                        character = game.Players.LocalPlayer.CharacterAdded:Wait()
                    end
                    
                    if not _G.AutoFarmBob then break end
                    
                    local currentGlove = game.Players.LocalPlayer.leaderstats.Glove.Value
                    if currentGlove ~= "Replica" then
                        Rayfield:Notify({
                            Title = "Error",
                            Content = "Changed glove",
                            Duration = 5
                        })
                        AutoFarmBobToggle:Set(false)
                        break
                    end


                    local teleport = workspace.Lobby:FindFirstChild("Teleport1")
                    if teleport then
                        firetouchinterest(character:WaitForChild("Head"), teleport, 0)
                        firetouchinterest(character:WaitForChild("Head"), teleport, 1)
                    end
                    
                    task.wait(0.6)
                    
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                    task.wait(0.5)

                    local success, hasBadge = pcall(function()
                        return game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2125950512)
                    end)
                    
                    if success and hasBadge then
                        Rayfield:Notify({
                            Title = "Auto Bob",
                            Content = "U got bob!",
                            Duration = 5
                        })
                        AutoFarmBobToggle:Set(false)
                        break
                    end


                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid then 
                        humanoid.Health = 0 
                    else 
                        character:BreakJoints() 
                    end


                    if _G.AutoFarmBob then
                        game.Players.LocalPlayer.CharacterAdded:Wait()
                        task.wait(0.5)
                    else
                        break
                    end
                end
            end)
        else
        end
    end
})
]]










local NameTagSection = Main:CreateSection("NameTag Settings")


local RemoveNameTagToggle = Main:CreateToggle({
    Name = "Remove NameTag",
    CurrentValue = false,
    Flag = "RemoveNameTag",
    Callback = function(State)
        getgenv().HideNameTag = State


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


        UpdateNameTagVisibility()

        if State then
            coroutine.wrap(function()
                while getgenv().HideNameTag do
                    UpdateNameTagVisibility()
                    task.wait(0.3)  
                end
            end)()
        end
    end,
})

local RemoveAllNameTagsToggle = Main:CreateToggle({
    Name = "Remove All NameTags",
    CurrentValue = false,
    Flag = "RemoveAllNameTags",
    Callback = function(State)
        getgenv().HideAllNameTags = State

        local Players = game:GetService("Players")

        local function UpdateAllNameTags()
            for _, player in pairs(Players:GetPlayers()) do
                local character = player.Character
                if character then
                    local head = character:FindFirstChild("Head")
                    if head then
                        local nameTag = head:FindFirstChild("Nametag") or head:FindFirstChildWhichIsA("BillboardGui")
                        if nameTag then
                            nameTag.Enabled = not State
                        end
                    end
                end
            end
        end


        UpdateAllNameTags()


        if State then
            coroutine.wrap(function()
                while getgenv().HideAllNameTags do
                    UpdateAllNameTags()
                    task.wait(0.3)
                end
            end)()
        end

        if State then
            Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function()
                    UpdateAllNameTags()
                end)
            end)
        end
    end,
})


game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    if getgenv().HideNameTag then
        task.wait(1)  
        local head = character:WaitForChild("Head", 5)
        if head then
            local nameTag = head:FindFirstChild("Nametag") or head:FindFirstChildWhichIsA("BillboardGui")
            if nameTag then
                nameTag.Enabled = false
            end
        end
    end
end)

local function LoadModule(url)
    local source = game:HttpGet(url)
    local fn = loadstring(source)
    return fn()
end

local Other = LoadModule("https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/modules/other.lua")
Other(Window, Rayfield)

end

if game.PlaceId == 18550498098 then
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")

local placeInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
local placeNameok = placeInfo.Name or "Unknown"  

local Window = Rayfield:CreateWindow({
   Name = placeNameok .. " | FlameUINT",
   Icon = 0, 
   LoadingTitle = "FlameUINT",
   LoadingSubtitle = "by ReTrojan",
   ShowText = "FlameUINT",
   Theme = "Darker", 

   ToggleUIKeybind = "G",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, 

   Discord = {
      Enabled = false, 
      Invite = "no (yet)", 
      RememberJoins = true 
   },

})

local AutoAttackEnabled = false
local AttackDelay = 0.05
local AttackConnection = nil
local ClickConnection = nil

local function DoClick()
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

local function AutoClickLoop()
    while AutoAttackEnabled do
        DoClick()
        task.wait(0.1)
    end
end

local function FullAutoAttack()
    while AutoAttackEnabled and task.wait(AttackDelay) do
        if not player.Character then continue end

        local lantern = player.Character:FindFirstChild("Lantern")
        if not lantern then continue end
        
        local network = lantern:FindFirstChild("Network")
        if not network then continue end

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
local MainTab = Window:CreateTab("Combat", "sword")


do
    Rayfield:Notify({
        Title = "Guide Boss Script",
        Content = "Script successfully loaded!",
        Duration = 5
    })


    MainTab:CreateSection("Teleportation")


    MainTab:CreateButton({
        Name = "Teleport to Boss",
        Callback = function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(3273, -75, 822)
                Rayfield:Notify({
                    Title = "Teleport",
                    Content = "Teleported to boss area!",
                    Duration = 2
                })
            end
        end,
    })


    MainTab:CreateButton({
        Name = "Teleport to SafeZone",
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
                Rayfield:Notify({
                    Title = "Teleport",
                    Content = "Teleported to safe zone!",
                    Duration = 2
                })
            end
        end,
    })


    MainTab:CreateSection("Automation")
    

    MainTab:CreateToggle({
        Name = "Enable Auto Attack",
        CurrentValue = false,
        Flag = "AutoAttackToggle",
        Callback = function(Value)
            AutoAttackEnabled = Value
            if Value then
                if AttackConnection then task.cancel(AttackConnection) end
                if ClickConnection then task.cancel(ClickConnection) end
                
                AttackConnection = task.spawn(FullAutoAttack)
                ClickConnection = task.spawn(AutoClickLoop)
                
                Rayfield:Notify({
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
                
                Rayfield:Notify({
                    Title = "Auto Attack",
                    Content = "Auto attack has been disabled",
                    Duration = 3
                })
            end
        end,
    })

    MainTab:CreateSlider({
        Name = "Attack Delay",
        Range = {0.05, 1},
        Increment = 0.05,
        Suffix = "seconds",
        CurrentValue = 0.05,
        Flag = "AttackDelaySlider",
        Callback = function(Value)
            AttackDelay = Value
        end,
    })
end


local function LoadModule(url)
    local source = game:HttpGet(url)
    local fn = loadstring(source)
    return fn()
end

local Other = LoadModule("https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/modules/other.lua")
Other(Window, Rayfield)

end


if game.PlaceId == 14422118326 then -- NULL

local placeInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
local placeNameok = placeInfo.Name or "Unknown"  
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = placeNameok .. " | FlameUINT v" .. ScriptVersion,
   Icon = 0, 
   LoadingTitle = "FlameUINT",
   LoadingSubtitle = "by ReTrojan",
   ShowText = "FlameUINT",
   Theme = "Darker", 

   ToggleUIKeybind = "G",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, 

   Discord = {
      Enabled = false, 
      Invite = "no (yet)", 
      RememberJoins = true 
   },

})

local Tab = Window:CreateTab("Teleports", 4483362458)

local nullPos = Vector3.new(5459.35, -189.00, 1845.44)
local tinkererPos = Vector3.new(4845.79, -214.00, 799.27)
local robPos = Vector3.new(5261.27, -138.43, 865.91)

local function tpTo(pos)
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    char:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(pos)
end

Tab:CreateButton({
    Name = "Get Null",
    Callback = function()
        tpTo(nullPos)
    end
})

Tab:CreateButton({
    Name = "Get Tinkerer",
    Callback = function()
        tpTo(tinkererPos)
    end
})

Tab:CreateButton({
    Name = "Get Rob Plushie",
    Callback = function()
        tpTo(robPos)
    end
})
local Other = LoadModule("https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/modules/other.lua")
Other(Window, Rayfield)

end
