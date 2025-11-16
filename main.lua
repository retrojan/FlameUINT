--[[
ITS A LOADER
SLAP BATTLES SCRIPT: 
https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/SB.lua

--]]

loadstring(game:HttpGet('https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/bypass.lua'))()

local gameScripts = {
    -- SLAP BATTLES
    [6403373529] = "https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/SB.lua", -- Default
    [9015014224] = "https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/SB.lua", -- No OneShot Gloves
    [124596094333302] = "https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/SB.lua" -- New Players?
    --                                                                                            --
    [18550498098] = "https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/guidefight.lua", --Guide Boss Fight
    [16034567693] = "https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/script/adminglove.lua". -- Admin Glove

}


local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlameUINTLoader"
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 400, 0, 150)
panel.Position = UDim2.new(0.5, -200, 0, -200)
panel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
panel.BorderSizePixel = 0
panel.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 10)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "FlameUINT"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextScaled = true
titleLabel.TextTransparency = 1
titleLabel.Parent = panel

local authorLabel = Instance.new("TextLabel")
authorLabel.Size = UDim2.new(1, 0, 0, 20)
authorLabel.Position = UDim2.new(0, 0, 0, 50)
authorLabel.BackgroundTransparency = 1
authorLabel.Text = "By ReTrojan"
authorLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
authorLabel.Font = Enum.Font.SourceSans
authorLabel.TextScaled = true
authorLabel.TextTransparency = 1
authorLabel.Parent = panel

local idLabel = Instance.new("TextLabel")
idLabel.Size = UDim2.new(1, 0, 0, 20)
idLabel.Position = UDim2.new(0, 0, 0, 80)
idLabel.BackgroundTransparency = 1
idLabel.Text = "Game ID: " .. tostring(game.PlaceId)
idLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
idLabel.Font = Enum.Font.SourceSans
idLabel.TextScaled = true
idLabel.TextTransparency = 1
idLabel.Parent = panel

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 30)
statusLabel.Position = UDim2.new(0, 0, 0, 110)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Loading"
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.Font = Enum.Font.SourceSansBold
statusLabel.TextScaled = true
statusLabel.TextTransparency = 1
statusLabel.Parent = panel

TweenService:Create(panel, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -200, 0, 10)}):Play()

for _, lbl in pairs({titleLabel, authorLabel, idLabel, statusLabel}) do
    TweenService:Create(lbl, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
end

local loadingActive = true
spawn(function()
    local dotCount = 0
    while loadingActive do
        dotCount = (dotCount % 3) + 1
        statusLabel.Text = "Loading" .. string.rep(".", dotCount)
        wait(0.5)
    end
end)

local currentGameId = game.PlaceId

local function fadeOutPanel()
    loadingActive = false
    local tween = TweenService:Create(panel, TweenInfo.new(1, Enum.EasingStyle.Quad), {BackgroundTransparency = 1})
    tween:Play()
    for _, lbl in pairs({titleLabel, authorLabel, idLabel, statusLabel}) do
        TweenService:Create(lbl, TweenInfo.new(1, Enum.EasingStyle.Quad), {TextTransparency = 1}):Play()
    end
    tween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end

if gameScripts[currentGameId] then
    local scriptUrl = gameScripts[currentGameId]
    print("The game was found in the database (ID:", currentGameId..")")
    print("Loading script...", scriptUrl)

    local success, errorMsg = pcall(function()
        local scriptContent = game:HttpGet(scriptUrl, true)
        loadstring(scriptContent)()
    end)

    wait(1)

    if success then
        statusLabel.Text = "Successfully"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        fadeOutPanel()
    else
        statusLabel.Text = "Failed"
        statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        fadeOutPanel()
        warn("ERROR Loading FlameUINT:", errorMsg)
    end
else
    statusLabel.Text = "Game Not Found"
    statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    wait(1)
    fadeOutPanel()
    print("IDK THIS GAME (ID:", currentGameId..")")
end
