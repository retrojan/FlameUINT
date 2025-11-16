-- SCRIPT BY Pro666pro, edited by ReTrojan
-- SOURCE(original) BYPASS: https://github.com/Pro666Pro/BypassAntiCheat

if getgenv().AntiMultiRun then return end
getgenv().AntiMultiRun = true

local RequireService = cloneref or function(obj) return obj end

local function BlockInstance(ez)
    if not ez or not ez.Parent then return end
    ez.Name = "BlockedInstance_" .. math.random(0, 500000)
    ez.Parent = RequireService(game:GetService("LogService"))
    ez:Destroy()
end

local Players = RequireService(game:GetService("Players"))
local Player = Players.LocalPlayer
local PlayerScripts = Player:WaitForChild("PlayerScripts")
local StarterPlayer = RequireService(game:GetService("StarterPlayer"))
local StarterPlayerScripts = StarterPlayer:WaitForChild("StarterPlayerScripts")
local ReplicatedStorage = RequireService(game:GetService("ReplicatedStorage"))
local ReplicatedFirst = RequireService(game:GetService("ReplicatedFirst"))
local StarterGui = game:GetService("StarterGui")


local function DestroyGrabLocalScript()
    local rf = ReplicatedFirst:FindFirstChild("Client")
    if rf and rf:FindFirstChild("GrabLocal") then
        BlockInstance(rf.GrabLocal)
    end
end

local function BypassMobileClientAntiCheat()
    local anti = StarterPlayerScripts:FindFirstChild("ClientAnticheat")
    if anti then
        if anti:FindFirstChild("AntiMobileExploits") then
            BlockInstance(anti.AntiMobileExploits)
        end
        BlockInstance(anti)
    end
end

local function HookBypass(remoteNames)
    if not (hookmetamethod and getnamecallmethod) then return false end
    
    local OldNamecall
    OldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        if method == "FireServer" and remoteNames[tostring(self)] then
            return
        end
        return OldNamecall(self, ...)
    end)

    return true
end


if game.PlaceId == 9431156611 then

    local BlockList = {Ban = true, WalkSpeedChanged = true, WS = true, WS2 = true}
    local usedHook = HookBypass(BlockList)

    if usedHook then
        StarterGui:SetCore("SendNotification", {
            Title = "Bypassed Ban Remotes!",
            Text = "Total Blocked: 4/4",
            Icon = "",
            Duration = 3,
            Button1 = "Alright!"
        })
    else
        local amount = 0
        for name in pairs(BlockList) do
            local evt = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild(name)
            if evt then
                BlockInstance(evt)
                amount += 1
            end
        end

        StarterGui:SetCore("SendNotification", {
            Title = "Bypassed!",
            Text = "Total Blocked: "..amount.."/4",
            Icon = "",
            Duration = 3,
            Button1 = "Alright!"
        })
    end

    DestroyGrabLocalScript()
    BypassMobileClientAntiCheat()


elseif game.PlaceId == 11520107397 or game.PlaceId == 9015014224 or game.PlaceId == 6403373529 or game.PlaceId == 124596094333302 then

    local BlockList = {
        Ban = true,
        WalkSpeedChanged = true,
        AdminGUI = true,
        GRAB = true,
        SpecialGloveAccess = true
    }

    local usedHook = HookBypass(BlockList)

    if usedHook then
        StarterGui:SetCore("SendNotification", {
            Title = "Bypassed!",
            Text = "Total Blocked: 5/5",
            Icon = "",
            Duration = 3,
            Button1 = "Alright!"
        })
    else
        local amount = 0
        for name in pairs(BlockList) do
            local evt = ReplicatedStorage:FindFirstChild(name)
            if evt then
                BlockInstance(evt)
                amount += 1
            end
        end

        StarterGui:SetCore("SendNotification", {
            Title = "Bypassed!",
            Text = "Total Blocked: "..amount.."/5",
            Icon = "",
            Duration = 3,
            Button1 = "Alright!"
        })
    end

    DestroyGrabLocalScript()
    BypassMobileClientAntiCheat()
end
