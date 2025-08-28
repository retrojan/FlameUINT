local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local BadgeService = game:GetService("BadgeService")

local AutoFarmBob = true
local BobBadgeId = 2125950512
local FarmThread

-- ===== ServerHop =====
local function ServerHop()
    local placeId = game.PlaceId
    local servers = {}
    local cursor = ""

    local success, response = pcall(function()
        return game:HttpGet(
            string.format(
                "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100%s",
                placeId,
                cursor ~= "" and "&cursor=" .. cursor or ""
            )
        )
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
        print("[ServerHop] Teleporting to new server...")
        TeleportService:TeleportToPlaceInstance(placeId, servers[math.random(1, #servers)], LocalPlayer)
    else
        warn("[ServerHop] No available servers, retrying in 10 seconds...")
        task.wait(10)
        ServerHop()
    end
end

-- ===== AutoFarm =====
local function StartAutoFarm()
    if AutoFarmBob then return end
    AutoFarmBob = true

    FarmThread = spawn(function()
        local arenaEmptyTime = 0
        local timerDisplay = 30

        -- GUI для таймера
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "AutoFarmTimerGui"
        ScreenGui.Parent = game:GetService("CoreGui")

        local TimerLabel = Instance.new("TextLabel")
        TimerLabel.Size = UDim2.new(0, 200, 0, 50)
        TimerLabel.Position = UDim2.new(0, 220, 0, 10)
        TimerLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
        TimerLabel.TextColor3 = Color3.fromRGB(255,255,255)
        TimerLabel.TextScaled = true
        TimerLabel.Text = ""
        TimerLabel.Parent = ScreenGui

        while AutoFarmBob do
            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

            -- Проверка игроков на сервере
            local totalPlayers = #Players:GetPlayers()
            if totalPlayers <= 1 then
                print("[AutoBob] You're alone on the server, hopping...")
                AutoFarmBob = false
                ServerHop()
                break
            end

            -- Проверка игроков на арене (ниже 255.3)
            local playersOnArena = {}
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local yPos = p.Character.HumanoidRootPart.Position.Y
                    if yPos <= 255.3 then
                        table.insert(playersOnArena, p)
                    end
                end
            end

            if #playersOnArena == 0 then
                arenaEmptyTime = arenaEmptyTime + 1
                timerDisplay = 30 - arenaEmptyTime
                TimerLabel.Text = "ServerHop in: " .. timerDisplay .. "s"
            else
                arenaEmptyTime = 0
                timerDisplay = 30
                TimerLabel.Text = ""
            end

            if arenaEmptyTime >= 30 then
                print("[AutoBob] Arena empty for 30 seconds, hopping...")
                AutoFarmBob = false
                ServerHop()
                break
            end

            -- Телепорт в арену
            firetouchinterest(character:WaitForChild("Head"), workspace.Lobby.Teleport1, 0)
            firetouchinterest(character:WaitForChild("Head"), workspace.Lobby.Teleport1, 1)
            task.wait(0.5)

            -- Жмём E
            game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
            task.wait(0.5)

            -- Проверка бейджа
            local ok, gotBadge = pcall(function()
                return BadgeService:UserHasBadgeAsync(LocalPlayer.UserId, BobBadgeId)
            end)
            if ok and gotBadge then
                print("[AutoBob] Badge obtained!")
                task.wait(30)
                LocalPlayer:Kick("U GOT BOB, CONGRATULATIONS!")
                break
            end

            -- Ресет персонажа
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Health = 0
            else
                character:BreakJoints()
            end

            LocalPlayer.CharacterAdded:Wait()
            task.wait(0.5)
        end

        TimerLabel:Destroy()
    end)
end

local function StopAutoFarm()
    AutoFarmBob = false
    print("[AutoBob] Auto Farm stopped by user")
end

-- ===== GUI =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoFarmGui"
ScreenGui.Parent = game:GetService("CoreGui")

local StopButton = Instance.new("TextButton")
StopButton.Size = UDim2.new(0, 200, 0, 50)
StopButton.Position = UDim2.new(0, 10, 0, 10)
StopButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopButton.Text = "Stop Auto Farm"
StopButton.Parent = ScreenGui
StopButton.MouseButton1Click:Connect(StopAutoFarm)

local StartButton = Instance.new("TextButton")
StartButton.Size = UDim2.new(0, 200, 0, 50)
StartButton.Position = UDim2.new(0, 10, 0, 70)
StartButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
StartButton.TextColor3 = Color3.fromRGB(0, 0, 0)
StartButton.Text = "Start Auto Farm"
StartButton.Parent = ScreenGui
StartButton.MouseButton1Click:Connect(StartAutoFarm)

-- ===== Авто запуск =====
StartAutoFarm()
