if game.PlaceId == 6403373529 then

    local lp = game.Players.LocalPlayer
    local ts = game:GetService("TeleportService")

    -- Старый JobId для проверки при хопе
    local oldJob = game.JobId

    -- Код, который выполнится после телепорта
    local q = queueonteleport or queue_on_teleport or (syn and syn.queue_on_teleport)
    if q then
        q([[
            if not game:IsLoaded() then game.Loaded:Wait() end
            repeat task.wait() until game.Players.LocalPlayer
            wait(0.2)

            -- Если попали на тот же сервер — повторяем телепорт
            if game.JobId == "]]..oldJob..[[" then
                local ts = game:GetService("TeleportService")
                local lp = game.Players.LocalPlayer
                ts:Teleport(game.PlaceId, lp)
            end

            -- Загружаем скрипт фарма
            loadstring(game:HttpGet("https://raw.githubusercontent.com/retrojan/FlameUINT/refs/heads/main/ex/ezSlapple.lua"))()
        ]])
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
        -- Телепорт на новый сервер
        ts:Teleport(game.PlaceId, lp)
    end

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Slapple Farm",
        Text = "Started",
        Duration = 3
    })

    farmOnce()
end
