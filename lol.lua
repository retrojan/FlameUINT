local Player = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AdvancedPositionTracker"
ScreenGui.Parent = game:GetService("CoreGui") or Player:WaitForChild("PlayerGui")

-- Create main frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 220)
MainFrame.Position = UDim2.new(0.5, -175, 0, 10)
MainFrame.AnchorPoint = Vector2.new(0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Create title bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 25)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, 0, 1, 0)
TitleText.Text = "Advanced Position Tracker (Alt to toggle)"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.BackgroundTransparency = 1
TitleText.Font = Enum.Font.GothamMedium
TitleText.TextSize = 14
TitleText.Parent = TitleBar

-- Create text box
local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -20, 1, -80)
TextBox.Position = UDim2.new(0, 10, 0, 35)
TextBox.BackgroundTransparency = 1
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextSize = 14
TextBox.Font = Enum.Font.Code
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.TextWrapped = true
TextBox.ClearTextOnFocus = false
TextBox.TextEditable = false
TextBox.Parent = MainFrame

-- Create copy buttons frame
local ButtonFrame = Instance.new("Frame")
ButtonFrame.Size = UDim2.new(1, -20, 0, 30)
ButtonFrame.Position = UDim2.new(0, 10, 1, -40)
ButtonFrame.BackgroundTransparency = 1
ButtonFrame.Parent = MainFrame

-- Create copy position button
local CopyPosButton = Instance.new("TextButton")
CopyPosButton.Size = UDim2.new(0.48, 0, 1, 0)
CopyPosButton.Position = UDim2.new(0, 0, 0, 0)
CopyPosButton.Text = "Copy Position"
CopyPosButton.Font = Enum.Font.Gotham
CopyPosButton.TextSize = 12
CopyPosButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
CopyPosButton.Parent = ButtonFrame

-- Create copy all button
local CopyAllButton = Instance.new("TextButton")
CopyAllButton.Size = UDim2.new(0.48, 0, 1, 0)
CopyAllButton.Position = UDim2.new(0.52, 0, 0, 0)
CopyAllButton.Text = "Copy All"
CopyAllButton.Font = Enum.Font.Gotham
CopyAllButton.TextSize = 12
CopyAllButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
CopyAllButton.Parent = ButtonFrame

-- Initial visibility state
local isVisible = true

-- Function to get game name
local function getGameName()
    local success, result = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId).Name
    end)
    return success and result or "Unknown Game"
end

-- Function to update position text
local function updatePosition()
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then 
        TextBox.Text = "Waiting for character..."
        return
    end
    
    local rootPart = Player.Character.HumanoidRootPart
    local position = rootPart.Position
    local orientation = rootPart.Orientation
    local placeId = game.PlaceId
    local gameName = getGameName()
    
    TextBox.Text = string.format(
        "Game: %s\n"..
        "PlaceID: %d\n\n"..
        "Position (X, Y, Z):\n"..
        "%.2f, %.2f, %.2f\n\n"..
        "Orientation (X, Y, Z):\n"..
        "%.2f, %.2f, %.2f",
        gameName,
        placeId,
        position.X,
        position.Y,
        position.Z,
        orientation.X,
        orientation.Y,
        orientation.Z
    )
end

-- Toggle visibility function
local function toggleVisibility()
    isVisible = not isVisible
    MainFrame.Visible = isVisible
end

-- Copy functions
local function copyToClipboard(content)
    local success, err = pcall(function()
        if setclipboard then
            setclipboard(content)
        elseif writeclipboard then
            writeclipboard(content)
        else
            error("Clipboard function not available")
        end
        local originalText = TextBox.Text
        TextBox.Text = "Copied to clipboard!\n" .. originalText
        task.wait(1)
        TextBox.Text = originalText
    end)
    
    if not success then
        TextBox.Text = "Copy failed: " .. err
        task.wait(2)
        updatePosition()
    end
end

-- Button click handlers
CopyPosButton.MouseButton1Click:Connect(function()
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local pos = Player.Character.HumanoidRootPart.Position
        copyToClipboard(string.format("Vector3.new(%.2f, %.2f, %.2f)", pos.X, pos.Y, pos.Z))
    end
end)

CopyAllButton.MouseButton1Click:Connect(function()
    copyToClipboard(TextBox.Text)
end)

-- Connect input handler
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
        toggleVisibility()
    end
end)

-- Update position every frame
game:GetService("RunService").Heartbeat:Connect(updatePosition)

-- Initial update
updatePosition()
