local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")

local placeInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
local placeName = placeInfo.Name or "Unknown"  

if game.PlaceId ~= 18550498098 then
    -- game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(17944, -130, -3540)
    return
end




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
local AttackDelay = 0.1
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
