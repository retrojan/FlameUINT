return function(Window, Rayfield)

local Other = Window:CreateTab("Other","compass")
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

Other:CreateButton({
    Name = "Dex Explorer",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/MassiveHubs/loadstring/refs/heads/main/DexXenoAndRezware'))()
    end
})
Other:CreateButton({
    Name = "Add in Autoexec",
    Callback = function()
        local teleportFunc = queueonteleport or queue_on_teleport
        if teleportFunc then
            teleportFunc([[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/retrojan/FlameUINT/main/main.lua"))()
            ]])

            Rayfield:Notify({
                Title = "FlameUINT",
                Content = "Code added to queueonteleport!",
                Duration = 3
            })
        else
            warn("queueonteleport not found!")
        end
    end
})


    
    
local AntiLagButton = Other:CreateButton({
    Name = "Anti Lag",
    Callback = function()

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
        end)
        
        if success then
            Rayfield:Notify({
                Title = "FlameUINT",
                Content = "Anti-Lag activated successfully!",
                Duration = 5,
                Image = 4483362458
            })
        else
            Rayfield:Notify({
                Title = "FlameUINT",
                Content = "Failed to load FPS Booster: " .. tostring(error),
                Duration = 5,
                Image = 4483362458
            })
        end
    end
})

local function kill(...)
    local tables = {...}
    for _, t in pairs(tables) do
        if type(t) == "table" then
            for _, obj in pairs(t) do
                if obj and obj.Parent then
                    obj:Destroy()
                end
            end
            for k in pairs(t) do
                t[k] = nil
            end
        end
    end
end

AntiVoidPlatforms = AntiVoidPlatforms or {}
SafeZones = SafeZones or {}

Other:CreateSection("Destroy GUI")
Other:CreateButton({
    Name = "Destroy GUI",
    Callback = function()

        kill(AntiVoidPlatforms, SafeZones)
        AntiVoidPlatforms = {}
        SafeZones = {}
        Rayfield:Destroy()
    end
})

end
