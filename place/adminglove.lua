if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.PlaceId ~= 16034567693 then
    return
end

repeat task.wait() until game.Players.LocalPlayer
task.wait(13.5)

local player = game.Players.LocalPlayer
player.Character.HumanoidRootPart.CFrame = CFrame.new(502, 76, 59)
task.wait(6)

if getconnections then
    for _, conn in pairs(getconnections(player.Idled)) do
        conn:Disable()
    end
end

local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AntiAfkGui"
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.8, 0, 0.05, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BackgroundTransparency = 0.3
frame.BorderSizePixel = 0
frame.Parent = screenGui

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

task.spawn(function()
    while true do
        secondsElapsed += 1
        local minutes = math.floor(secondsElapsed / 60)
        local seconds = secondsElapsed % 60
        timerLabel.Text = string.format("%02d:%02d", minutes, seconds)
        task.wait(1)
    end
end)
