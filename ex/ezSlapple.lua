if game.PlaceId == 6403373529 then

    local q = queueonteleport or queue_on_teleport or (syn and syn.queue_on_teleport)
    if q then
        q([[
            if not game:IsLoaded() then game.Loaded:Wait() end
            repeat task.wait() until game.Players.LocalPlayer
            wait(0.2)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/ex/ezSlapple.lua"))()
        ]])
    end

    local lp = game.Players.LocalPlayer
    local ts = game:GetService("TeleportService")
    local http = game:GetService("HttpService")

    local function serverHop()
        local servers = {}

        local ok, data = pcall(function()
            return http:JSONDecode(
                game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
            )
        end)

        if not ok or not data or not data.data then
            task.wait(1)
            return serverHop()
        end

        for _, v in ipairs(data.data) do
            if v.playing < v.maxPlayers and v.id ~= game.JobId then
                table.insert(servers, v.id)
            end
        end

        if #servers == 0 then
            task.wait(1)
            return serverHop()
        end

        ts:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], lp)
    end

    local function farmOnce()
        local char = lp.Character or lp.CharacterAdded:Wait()

        if not char:FindFirstChild("entered") then
            local head = char:WaitForChild("Head")
            local teleport = workspace.Lobby:WaitForChild("Teleport1")
            firetouchinterest(head, teleport, 0)
            firetouchinterest(head, teleport, 1)

            repeat task.wait() until char:FindFirstChild("entered")
        end

        for _, v in pairs(workspace.Arena.island5.Slapples:GetChildren()) do
            if (v.Name == "Slapple" or v.Name == "GoldenSlapple")
            and v:FindFirstChild("Glove")
            and v.Glove:FindFirstChildWhichIsA("TouchTransmitter") then
                firetouchinterest(char.HumanoidRootPart, v.Glove, 0)
                firetouchinterest(char.HumanoidRootPart, v.Glove, 1)
            end
        end

        task.wait(0.7)
        serverHop()
    end

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Slapple Farm",
        Text = "Started",
        Duration = 3
    })

    farmOnce()
end
