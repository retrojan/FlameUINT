return function(RayField, Window)
    
    -- Основные функции
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

    -- Секция Destroy
    local DestroyS = Other:CreateSection("Destroy GUI")

    local DestroyButton = Other:CreateButton({
        Name = "Destroy GUI",
        Callback = function()
            RayField:Destroy()
            RayField:Notify({
                Title = "GUI Destroyed",
                Content = "Interface has been successfully destroyed",
                Duration = 2
            })
        end
    })
    
    return Other
end
