if game.PlaceId ~= 14422118326 then
    return
end
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
local OtherTab = Window:CreateTab("Other", 4483362458)

local nullPos = Vector3.new(5459.35, -189.00, 1845.44)
local tinkererPos = Vector3.new(4845.79, -214.00, 799.27)
local robPos = Vector3.new(5261.27, -138.43, 865.91) -- UPDATED POSITION

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
OtherTab:CreateButton({
    Name = "Destroy GUI",
    Callback = function()
        Rayfield:Destroy()
    end
})
