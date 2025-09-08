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

Happy reading!
]]







local ScriptName = "FlameUINT REVOLUTION"
local ScriptVersion = "13.4"
local ScriptDev = "ReTrojan"

local AntiToggles = {}
local AntiVoidPlatforms = {}







local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local placeInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
local placeNameok = placeInfo.Name or "Unknown"  


if game.PlaceId ~= 6403373529 and game.PlaceId ~= 9015014224 and game.PlaceId ~= 124596094333302 then
    RayField:Notify({
        Title = "Error!",
        Content = "This script is for Slap Battles",
        Duration = 5
    })
    return
end



local Window = Rayfield:CreateWindow({
   Name = placeNameok .. " | 🔥 FlameUINT",
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












local function SetupBypass()
    local function safeHook()
        local success, result = pcall(function()
            local bypass
            bypass = hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()
                if method == "FireServer" then
                    if self == game.ReplicatedStorage:FindFirstChild("Ban") then
                        return nil
                    elseif self == game.ReplicatedStorage:FindFirstChild("AdminGUI") then
                        return nil
                    elseif self == game.ReplicatedStorage:FindFirstChild("WalkSpeedChanged") then
                        return nil
                    end
                end
                return bypass(self, ...)
            end)
            return bypass
        end)
        
        if not success then
            warn("Bypass hook failed:", result)
        end
    end

    task.spawn(safeHook)
end

SetupBypass()






local Info = Window:CreateTab("Info", "book")
local Main = Window:CreateTab("Main", "code")
local Antis = Window:CreateTab("Antis", "shield")
local Gloves = Window:CreateTab("Gloves", "hand")
local Teleport = Window:CreateTab("Teleport", "eye")
local Mastery = Window:CreateTab("Mastery", "flame")
local Other = Window:CreateTab("Other", "compass")






local OtherS = Other:CreateSection("Other")

Other:CreateButton({
    Name = "FlyGUIV3",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
    end
})


Other:CreateButton({
    Name = "Infinity Yield",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})

local AntiLagButton = Other:CreateButton({
    Name = "Anti Lag",
    Callback = function()

        Rayfield:Notify({
            Title = "Anti Lag",
            Content = "Optimizing game performance...",
            Duration = 3,
            Image = 4483362458
        })
        

        _G.Settings = {
            Players = {
                ["Ignore Me"] = true, 
                ["Ignore Others"] = true
            },
            Meshes = {
                Destroy = false,
                LowDetail = true
            },
            Images = {
                Invisible = true,
                LowDetail = false,
                Destroy = false
            },
            Other = {
                ["No Particles"] = true,
                ["No Camera Effects"] = true,
                ["No Explosions"] = true,
                ["No Clothes"] = true,
                ["Low Water Graphics"] = true,
                ["No Shadows"] = true,
                ["Low Rendering"] = true,
                ["Low Quality Parts"] = true
            }
        }
        

        local success, error = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/FPSBooster.lua"))()
            print("test")
        end)
        
        if success then
            Rayfield:Notify({
                Title = "Success",
                Content = "Anti-Lag activated successfully!",
                Duration = 5,
                Image = 4483362458
            })
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Failed to load FPS Booster: " .. tostring(error),
                Duration = 5,
                Image = 4483362458
            })
        end
    end
})



Other:CreateSection("Destroy GUI")
Other:CreateButton({
    Name = "Destroy GUI",
    Callback = function()
        -- Удаляем все платформы
        for _, platform in pairs(AntiVoidPlatforms) do
            if platform and platform.Parent then
                platform:Destroy()
            end
        end
        AntiVoidPlatforms = {}

        -- Удаляем GUI
        Rayfield:Destroy()

        -- Уведомление
        Rayfield:Notify({
            Title = "GUI Destroyed",
            Content = "Interface has been successfully destroyed",
            Duration = 2
        })
    end
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








local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local BadgeService = game:GetService("BadgeService")
local LocalPlayer = Players.LocalPlayer
local PlaceId = 6403373529


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


local freezeEnabled = false
local originalMaxSlopeAngle = 89 

local function toggleCharacterFreeze(state)
    freezeEnabled = state
    
    local character = game.Players.LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    
    if humanoid and root then
        if state then

            originalMaxSlopeAngle = humanoid.MaxSlopeAngle
            

            root.Anchored = true
            humanoid.MaxSlopeAngle = 0 
        else

            root.Anchored = false
            humanoid.MaxSlopeAngle = originalMaxSlopeAngle
        end
    end
end


game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    if freezeEnabled then
        task.wait(0.1)
        local humanoid = character:WaitForChild("Humanoid")
        local root = character:WaitForChild("HumanoidRootPart")
        
        if humanoid and root then
            root.Anchored = true
            humanoid.MaxSlopeAngle = 0
        end
    end
end)

local SUtility= Main:CreateSection("Utility")

Main:CreateButton({
    Name = "Server Hop",
    Callback = function()
        ServerHop()
    end
})


local TABG Main:CreateToggle({
    Name = "Tab", 
    CurrentValue = false,
    Flag = "FreezeToggle",
    Callback = function(Value)
        toggleCharacterFreeze(Value)
    end
})
Main:CreateButton({
Name = "reset", 
    Callback = function()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid then 
                        humanoid.Health = 0 
                    else 
                        character:BreakJoints() 
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


local ModeDropdown = Gloves:CreateDropdown({
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
        
        local glove = game.Players.LocalPlayer.leaderstats.Glove.Value
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
                while BrickFarmConfig.Enabled and game.Players.LocalPlayer.leaderstats.Glove.Value == "Brick" do
                    local interval = BrickFarmConfig.Intervals[BrickFarmConfig.Mode]
                    local currentTime = tick()
                    
                    if currentTime - lastBrickTime >= brickCooldown then
                        if BrickFarmConfig.Mode == "Slow" then
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                            lastBrickTime = currentTime
                        else
                            local success, err = pcall(function()
                                game:GetService("ReplicatedStorage").lbrick:FireServer()
                                lastBrickTime = currentTime
                                
                                task.wait(0.1) 
                                local gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("BRICKCOUNT")
                                if gui and gui:FindFirstChild("ImageLabel") then
                                    local textLabel = gui.ImageLabel:FindFirstChild("TextLabel")
                                    if textLabel then
                                        local currentCount = tonumber(textLabel.Text) or 0
                                        textLabel.Text = tostring(currentCount + 1)
                                    end
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
                    end
                    
                    task.wait(interval)
                end
                
                if BrickFarmConfig.Enabled and game.Players.LocalPlayer.leaderstats.Glove.Value ~= "Brick" then
                    Rayfield:Notify({
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


local function setupBrickTracking()
    local player = game.Players.LocalPlayer
    local lastBrickCount = 0
    

    local function checkBrickCount()
        local gui = player.PlayerGui:FindFirstChild("BRICKCOUNT")
        if gui and gui:FindFirstChild("ImageLabel") then
            local textLabel = gui.ImageLabel:FindFirstChild("TextLabel")
            if textLabel then
                local currentCount = tonumber(textLabel.Text) or 0
                if currentCount > lastBrickCount then
                    lastBrickCount = currentCount
                    return true
                end
            end
        end
        return false
    end
    

    task.spawn(function()
        while BrickFarmConfig.Enabled do
            if checkBrickCount() then
                lastBrickTime = tick()
            end
            task.wait(0.1)
        end
    end)
end


local function setupGloveTracking()
    local player = game.Players.LocalPlayer
    if not player then return end

    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then return end

    local gloveStat = leaderstats:FindFirstChild("Glove")
    if not gloveStat then return end

    local function onGloveChanged()
        if BrickFarmConfig.Enabled and gloveStat.Value ~= "Brick" then
            Rayfield:Notify({
                Title = "Brick Farm",
                Content = "Brick glove was unequipped!",
                Duration = 5
            })
            BrickFarmToggle:Set(false)
        end
    end
    
    gloveStat:GetPropertyChangedSignal("Value"):Connect(onGloveChanged)
    onGloveChanged() 
end


coroutine.wrap(setupGloveTracking)()




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


-- Пример тоггла Anti Void
AntiToggles.AntiVoidToggle = Antis:CreateToggle({
    Name = "Anti Void",
    CurrentValue = false,
    Flag = "AntiVoidToggle",
    Callback = function(Value)
        if Value then
            -- Платформа внизу
            local Platform1 = Instance.new("Part")
            Platform1.Size = Vector3.new(3000, 2, 3000)
            Platform1.Position = Vector3.new(0, -10, 0)
            Platform1.Anchored = true
            Platform1.Transparency = 0.5
            Platform1.CanCollide = true
            Platform1.Parent = workspace
            table.insert(AntiVoidPlatforms, Platform1)

            -- Платформа на заданной позиции
            local Platform2 = Instance.new("Part")
            Platform2.Size = Vector3.new(3000, 2, 3000)
            Platform2.Position = Vector3.new(3426.54, 239.38, -9.97)
            Platform2.Anchored = true
            Platform2.Transparency = 0.5
            Platform2.CanCollide = true
            Platform2.Parent = workspace
            table.insert(AntiVoidPlatforms, Platform2)
        else
            -- Удаляем все платформы, созданные этим тогглом
            for _, platform in pairs(AntiVoidPlatforms) do
                if platform and platform.Parent then
                    platform:Destroy()
                end
            end
            -- Очищаем таблицу
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
        
        while _G.AutoTpPlate do
            char = player.Character or player.CharacterAdded:Wait()
            
            -- Если игрок ещё не зашёл в арену, телепорт через touch
            if not char:FindFirstChild("entered") then
                local head = char:WaitForChild("Head")
                local teleport = workspace.Lobby:WaitForChild("Teleport1")
                firetouchinterest(head, teleport, 0)
                firetouchinterest(head, teleport, 1)
                task.wait(0.5)
            end

            -- Если в арену зашёл и достаточно игроков — телепорт к Plate
            if char:FindFirstChild("entered") and #game.Players:GetPlayers() >= 7 then
                local plate = workspace.Arena:WaitForChild("Plate")
                local hrp = char:WaitForChild("HumanoidRootPart")
                hrp.CFrame = plate.CFrame + Vector3.new(0, 2, 0)
            end

            task.wait()
        end

        -- Ошибка, если условия не выполнены
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

        if player.leaderstats.Glove.Value == "Fort" and not game:GetService("BadgeService"):UserHasBadgeAsync(player.UserId, 4031317971987872) then
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


-- The orb siphon has a bug ( this is not a script issue )
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


-- Phase Orb Farm
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

-- Jet Orb Farm
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
    floorSize = Vector3.new(200, 1, 200),
    wallHeight = 40,
    parts = {}
}


local function getRandomAFKPosition()
    local x = math.random(5000, 25000)
    local z = math.random(5000, 25000)
    local y = math.random(-497, 0) 
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
    position = Vector3.new(50000, 0, 50000),
    floorSize = Vector3.new(200, 1, 200),
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
    Name = "DUO Safe Spot",
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



local OrbSection = Main:CreateSection("Slap Aura (BETA)")
local SlapAuraToggle = Main:CreateToggle({
    Name = "Slap Aura (BETA)",
    CurrentValue = false,
    Flag = "SlapAuraToggle",
    Callback = function(Value)
        SlapAura = Value
        if Value then
            spawn(function()
                while SlapAura and SlapAuraFriend == "Fight" do
                    for i,v in pairs(game.Players:GetPlayers()) do
                        if v ~= game.Players.LocalPlayer then
                            local character = v.Character or v.CharacterAdded:Wait()
                            local localChar = game.Players.LocalPlayer.Character
                            
                            if character and localChar and localChar:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("HumanoidRootPart") then
                                if character:FindFirstChild("entered") and character.Ragdolled.Value == false and character:FindFirstChild("Torso") and character.Torso.Anchored ~= false and character:FindFirstChild("Mirage") == nil then
                                    local Magnitude = (localChar.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
                                    if _G.ReachValue and _G.ReachValue >= Magnitude then
                                        game.ReplicatedStorage.KSHit:FireServer(character:WaitForChild("HumanoidRootPart"), true)
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.2)
                end
            end)
            

            spawn(function()
                while SlapAura and SlapAuraFriend == "Not Fight" do
                    for i,v in pairs(game.Players:GetPlayers()) do
                        if v ~= game.Players.LocalPlayer then
                            local character = v.Character or v.CharacterAdded:Wait()
                            local localChar = game.Players.LocalPlayer.Character
                            
                            if character and localChar and localChar:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("HumanoidRootPart") then
                                if character:FindFirstChild("entered") and not game.Players.LocalPlayer:IsFriendsWith(v.UserId) and character.Ragdolled.Value == false and character:FindFirstChild("Torso") and character.Torso.Anchored ~= false and character:FindFirstChild("Mirage") == nil then
                                    local Magnitude = (localChar.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
                                    if _G.ReachValue and _G.ReachValue >= Magnitude then
                                        game.ReplicatedStorage.KSHit:FireServer(character:WaitForChild("HumanoidRootPart"), true)
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.2)
                end
            end)
        end
    end
})


local HitboxPlayerToggle = Main:CreateToggle({
    Name = "Hitbox Player",
    CurrentValue = false,
    Flag = "HitboxPlayerToggle",
    Callback = function(Value)
        _G.HitboxPlayer = Value
        if Value then
            spawn(function()
                while _G.HitboxPlayer do
                    for i,v in pairs(game.Players:GetPlayers()) do
                        if v ~= game.Players.LocalPlayer then
                            local character = v.Character
                            if character and character:FindFirstChild("HumanoidRootPart") then
                                character.HumanoidRootPart.Size = Vector3.new(_G.ReachValue, _G.ReachValue, _G.ReachValue)
                                character.HumanoidRootPart.Transparency = 0.75
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        else
            for i,v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer then
                    local character = v.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                        character.HumanoidRootPart.Transparency = 1
                    end
                end
            end
        end
    end
})

local ReachSlider = Main:CreateSlider({
    Name = "Reach & Hitbox Size",
    Range = {2, 30},
    Increment = 1,
    Suffix = "studs",
    CurrentValue = 10,
    Flag = "ReachSlider",
    Callback = function(Value)
        _G.ReachValue = Value
    end
})

local Sbob = Gloves:CreateSection("BOB")

local AutoFarmBobToggle = Gloves:CreateToggle({
    Name = "Auto Farm Bob (dont working on mobile)",
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


-- DANGER
Gloves:CreateSection("! DANGER ! (BUT WORKING!)")

Gloves:CreateLabel("Possible ban (if you do this on your main account = don't take any chances)")

local GetAllBadges = Gloves:CreateButton({
    Name = "Get All Badge Gloves",
    Flag = "GABG",
    Callback = function()
           loadstring(game:HttpGet("https://raw.githubusercontent.com/IncognitoScripts/SlapBattles/refs/heads/main/InstantGloves"))()
    end,
})




--[[

FPS AND PING STATS COMPLETELY REMOVED
reason: a lot of errors
]]





