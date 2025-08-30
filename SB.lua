--[[

THIS CODE OPEN SOURCE

===========================

FlameUINT HUB
By ReTrojan

https://github.com/retrojan/FlameUINT

===========================

RESOURCES FOR U:

Documentation: https://docs.sirius.menu/rayfield
ICONS: https://lucide.dev/icons/

Happy reading!
]]




local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local placeInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
local placeNameok = placeInfo.Name or "Unknown"  


if game.PlaceId ~= 6403373529 and game.PlaceId ~= 9015014224 then
    RayField:Notify({
        Title = "Error!",
        Content = "This script is for Slap Battles",
        Duration = 5
    })
    return
end



local Window = Rayfield:CreateWindow({
   Name = placeNameok .. " | 🔥 FlameUINT HUB",
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



-- BYPASS
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






local Info = Window:CreateTab("Information", "book")
local Main = Window:CreateTab("Main", "code")
local Antis = Window:CreateTab("Antis", "shield")
local Gloves = Window:CreateTab("Gloves", "hand")
local Teleport = Window:CreateTab("Teleport", "eye")
local Mastery = Window:CreateTab("Mastery", "flame")
local Other = Window:CreateTab("Other", "compass")

local SAntis = Antis:CreateSection("Antis")



local SMaster = Mastery:CreateSection("Mastery")
Mastery:CreateLabel("Coming soon...")

local SInfo = Info:CreateSection("Information")

Info:CreateLabel("MEGA UPDATE v5")
Info:CreateLabel("Switched to RayField | Added Bob farm")
Info:CreateLabel("Anti Lag | Improved orb farming")
Info:CreateLabel("Slap Aura | Removed E-Spam")
Info:CreateLabel("Reworked Anti AFK system")

Info:CreateButton({
    Name = "Repository",
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
    

--[[
local AntiLagButton = Main:CreateButton({
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


]]

local SectSlapple = Main:CreateSection("Slapple Farm") 

local originalTransparencies = {}

local Slappleezz = Main:CreateToggle({
    Name = "Auto farm Slapples",
    CurrentValue = false,
    Flag = "SlappleFarmToggle",
    Callback = function(Value)
        SlappleFarm = Value
        
        -- Функция для скрытия/показа только слепплов с Glove
        local function toggleFlyingSlapplesVisibility(hide)
            for i, v in pairs(workspace.Arena.island5.Slapples:GetChildren()) do
                if (v.Name == "Slapple" or v.Name == "GoldenSlapple") and v:FindFirstChild("Glove") then
                    if hide then
                        -- Сохраняем оригинальную прозрачность
                        if not originalTransparencies[v] then
                            originalTransparencies[v] = {}
                        end
                        
                        -- Скрываем все части слеппла
                        for _, part in pairs(v:GetDescendants()) do
                            if part:IsA("BasePart") then
                                originalTransparencies[v][part] = part.Transparency
                                part.Transparency = 1
                            end
                        end
                    else
                        -- Восстанавливаем оригинальную прозрачность
                        if originalTransparencies[v] then
                            for part, transparency in pairs(originalTransparencies[v]) do
                                if part and part.Parent then
                                    part.Transparency = transparency
                                end
                            end
                            originalTransparencies[v] = nil
                        end
                    end
                end
            end
        end
        
        if Value then
            -- Включаем скрытие летящих слепплов
            toggleFlyingSlapplesVisibility(true)
        else
            -- Выключаем скрытие летящих слепплов
            toggleFlyingSlapplesVisibility(false)
        end
        
        while SlappleFarm do
            if game.Players.LocalPlayer.Character:FindFirstChild("entered") then
                for i, v in pairs(workspace.Arena.island5.Slapples:GetChildren()) do
                    if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and 
                       game.Players.LocalPlayer.Character:FindFirstChild("entered") and 
                       (v.Name == "Slapple" or v.Name == "GoldenSlapple") and 
                       v:FindFirstChild("Glove") and 
                       v.Glove:FindFirstChildWhichIsA("TouchTransmitter") then
                        
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Glove, 0)
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Glove, 1)
                    end
                end
            end
            task.wait()
        end
        
        -- При выключении тоггла восстанавливаем видимость
        if not Value then
            toggleFlyingSlapplesVisibility(false)
        end
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


--[[
local FarmSection = Main:CreateSection("Slapple Farming")

local SlappleFarmConfig = {
    Enabled = false,
    Types = {"Slapple", "GoldenSlapple"}, 
    Cooldown = 0.1 
}

local SlappleFarmToggle = Main:CreateToggle({
    Name = "Autofarm Slapples",
    CurrentValue = false,
    Flag = "SlappleFarmToggle",
    Callback = function(Value)
        SlappleFarmConfig.Enabled = Value
        
        if Value then
            coroutine.wrap(function()
                while SlappleFarmConfig.Enabled and task.wait(SlappleFarmConfig.Cooldown) do
                    local character = game.Players.LocalPlayer.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        
                        -- Проверяем остров 5
                        local island5 = workspace.Arena:FindFirstChild("island5")
                        if island5 and island5:FindFirstChild("Slapples") then
                            
                            for _, slapple in pairs(island5.Slapples:GetChildren()) do
                                if not SlappleFarmConfig.Enabled then break end
                                
                                -- Исправлено: TouchTransmitter вместо TuchTransmitter
                                if table.find(SlappleFarmConfig.Types, slapple.Name) 
                                   and slapple:FindFirstChild("Glove") 
                                   and slapple.Glove:FindFirstChildWhichIsA("TouchTransmitter") then
                                    
                                    firetouchinterest(character.HumanoidRootPart, slapple.Glove, 0)
                                    task.wait()
                                    firetouchinterest(character.HumanoidRootPart, slapple.Glove, 1)
                                end
                            end
                        end
                    end
                end
            end)()
            
            Rayfield:Notify({
                Title = "Slapple Farm",
                Content = "Autofarm activated!",
                Duration = 2,
                Image = 4483362458
            })
        else
            Rayfield:Notify({
                Title = "Slapple Farm",
                Content = "Autofarm deactivated",
                Duration = 2,
                Image = 4483362458
            })
        end
    end
})

local SlappleTypesDropdown = Main:CreateDropdown({
    Name = "Slapple Types",
    CurrentOption = {"Slapple", "GoldenSlapple"},
    Options = {"Slapple", "GoldenSlapple"},
    MultipleOptions = true,
    Flag = "SlappleTypesDropdown",
    Callback = function(Selected)
        SlappleFarmConfig.Types = Selected
    end
})

local FarmCooldownSlider = Main:CreateSlider({
    Name = "Farm Cooldown",
    Range = {0.05, 0.5},
    Increment = 0.05,
    Suffix = "seconds",
    CurrentValue = 0.1,
    Flag = "FarmCooldownSlider",
    Callback = function(Value)
        SlappleFarmConfig.Cooldown = Value
    end
})


]]









local AntiRagdollToggle = Antis:CreateToggle({
   Name = "Anti Ragdoll",
   CurrentValue = false,
   Flag = "AntiRagdollToggle",
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


local AntiVoidToggle = Antis:CreateToggle({
   Name = "Anti Void",
   CurrentValue = false,
   Flag = "AntiVoidToggle",
   Callback = function(Value)
        if Value then
            local Platform = Instance.new("Part")
            Platform.Name = "AntiVoidPlatform"
            Platform.Size = Vector3.new(3000, 2, 3000)
            Platform.Position = Vector3.new(0, -10, 0)
            Platform.Anchored = true
            Platform.Transparency = 0.5
            Platform.CanCollide = true
            Platform.Parent = workspace
        else
            local ExistingPlatform = workspace:FindFirstChild("AntiVoidPlatform")
            if ExistingPlatform then
                ExistingPlatform:Destroy()
            end
        end
   end,
})

local AntiAFKToggle = Antis:CreateToggle({
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


local AntiIceBinToggle = Antis:CreateToggle({
    Name = "Anti IceSkate",
    CurrentValue = false,
    Flag = "AntiIceBinToggle",
    Callback = function(Value)
        _G.AntiIceBin = Value
        
        if Value then
            Rayfield:Notify({
                Title = "Anti IceSkate",
                Content = "enable",
                Duration = 3
            })
            
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

local AntiPusherToggle = Antis:CreateToggle({
    Name = "Anti Pusher",
    CurrentValue = false,
    Flag = "AntiPusherToggle",
    Callback = function(Value)
        _G.AntiPusher = Value
        
        if Value then
            Rayfield:Notify({
                Title = "Anti Pusher",
                Content = "Защита от толкающих стен включена",
                Duration = 3
            })
            
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
            Rayfield:Notify({
                Title = "Anti Pusher",
                Content = "Защита от толкающих стен выключена",
                Duration = 3
            })
            
            for _, v in pairs(game.Workspace:GetChildren()) do
                if v.Name == "wall" then
                    v.CanCollide = true
                end
            end
        end
    end
})

local AntiIceAndPotionToggle = Antis:CreateToggle({
    Name = "Anti Ice & Potion",
    CurrentValue = false,
    Flag = "AntiIceAndPotionToggle",
    Callback = function(Value)
        _G.AntiIce = Value
        
        if Value then
            Rayfield:Notify({
                Title = "Anti Ice & Potion",
                Content = "Защита от льда и зелий включена",
                Duration = 3
            })
            
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
            Rayfield:Notify({
                Title = "Anti Ice & Potion", 
                Content = "Защита от льда и зелий выключена",
                Duration = 3
            })
        end
    end
})

local AntiKickToggle = Antis:CreateToggle({
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
                            Rayfield:Notify({
                                Title = "Anti Kick",
                                Content = "Обнаружена попытка кика! Телепортация...",
                                Duration = 3
                            })
                            
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


local AntiAdminToggle = Antis:CreateToggle({
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


local AntiMailToggle = Antis:CreateToggle({
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


local AntiCubeOfDeathToggle = Antis:CreateToggle({
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
        
        if game.Players.LocalPlayer.Character:FindFirstChild("entered") and #game.Players:GetPlayers() >= 7 then
            while _G.AutoTpPlate do
                if game.Players.LocalPlayer.Character and 
                   game.Players.LocalPlayer.Character:FindFirstChild("entered") and 
                   #game.Players:GetPlayers() >= 7 then
                    local plate = game.workspace.Arena.Plate
                    local humanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
                    humanoidRootPart.CFrame = plate.CFrame + Vector3.new(0, 2, 0)
                end
                task.wait()
            end
        elseif _G.AutoTpPlate == true then
            Rayfield:Notify({
                Title = "Error",
                Content = "You need to enter arena, or have 7 people in the server",
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


local PhaseJetToggle = Gloves:CreateToggle({
    Name = "Phase Or Jet Farm",
    CurrentValue = false,
    Flag = "PhaseJetToggle",
    Callback = function(Value)
        _G.PhaseOrJetfarm = Value
        
        if Value then
            task.spawn(function()
                while _G.PhaseOrJetfarm do
                    local character = game.Players.LocalPlayer.Character
                    if character and character:FindFirstChild("Head") then
                        for _, v in pairs(game.Workspace:GetChildren()) do
                            if not _G.PhaseOrJetfarm then break end
                            
                            if v.Name == "JetOrb" or v.Name == "PhaseOrb" then
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
    Name = "Glitch Phase Or Jet",
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
    if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil then
        firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 0)
        firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 1)
        

        wait(0.3)
    end
    
    local humanoidRootPart = Player.Character:WaitForChild("HumanoidRootPart")
    createAFKZone()
    humanoidRootPart.CFrame = CFrame.new(AFK_ZONE.position)
    
    Rayfield:Notify({
        Title = "Safe Spot",
        Content = "You have been teleported to the Safe Spot!",
        Duration = 3
    })
end
    local AFKSECT = Teleport:CreateSection("Safe Spot")
    
    Teleport:CreateButton({
        Name = "Safe Spot",
        Callback = function()
            teleportToAFKZone()
        end
    })

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
            
            Rayfield:Notify({
                Title = "Запуск",
                Content = "Anti-AFK включен! Начинаем фарм рыбы...",
                Duration = 5,
                Image = 4483362458
            })
            

        end
    end)
end)


]]



local OrbSection = Main:CreateSection("Slap Aura")
local SlapAuraToggle = Main:CreateToggle({
    Name = "Slap Aura",
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
    Name = "Auto Farm Bob",
    CurrentValue = false,
    Flag = "AutoFarmBobToggle",
    Callback = function(Value)
        _G.AutoFarmBob = Value
        
        if Value then
            local glove = game.Players.LocalPlayer.leaderstats.Glove.Value
            if glove ~= "Replica" then 
                Rayfield:Notify({
                    Title = "Ошибка",
                    Content = "Нужна перчатка Replica!",
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
                    
                    task.wait(1)
                    
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                    task.wait(1)

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
            print("Auto Farm Bob отключен")
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
                    task.wait(0.1) 
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

local InfoS = Other:CreateSection("Information")



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



local DestroyS = Other:CreateSection("Destroy GUI")


local DestroyButton = Other:CreateButton({
    Name = "Destroy GUI",
    Callback = function()
        Rayfield:Destroy()
        Rayfield:Notify({
            Title = "GUI Destroyed",
            Content = "Interface has been successfully destroyed",
            Duration = 2
        })
    end
})





--[[

local FPSLabel = Other:CreateLabel("FPS: --")
local PingLabel = Other:CreateLabel("Ping: -- ms")

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

        FPSLabel:Set("FPS: " .. CurrentFPS)
    end
end)

local function UpdatePing()
    local Success, Ping = pcall(function()
        return math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
    end)
    if not Success then
        Ping = math.floor(game:GetService("Stats").PerformanceStats.Ping:GetValue() or 0)
    end
    PingLabel:Set("Ping: " .. Ping .. " ms")
end


spawn(function()
    while true do
        UpdatePing()
        task.wait(0.5)
    end
end)
]]




--[[

I want to make a script for Slap Royale later.

]]

