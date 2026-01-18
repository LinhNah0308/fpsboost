-- REMOVE FULL WHITE SCREEN ONLY (SAFE UI)

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- RESET LIGHTING (white screen thường do Lighting)
pcall(function()
    Lighting.Brightness = 2
    Lighting.ExposureCompensation = 0
    Lighting.FogStart = 0
    Lighting.FogEnd = 100000
    Lighting.Ambient = Color3.fromRGB(128,128,128)
    Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)

    for _,v in pairs(Lighting:GetChildren()) do
        if v:IsA("ColorCorrectionEffect")
        or v:IsA("BloomEffect")
        or v:IsA("BlurEffect")
        or v:IsA("SunRaysEffect") then
            v:Destroy()
        end
    end
end)

-- CHECK FRAME FULL SCREEN
local function IsFullScreenFrame(gui)
    if not gui:IsA("Frame") then return false end
    if gui.BackgroundTransparency > 0.15 then return false end
    if gui.BackgroundColor3 ~= Color3.fromRGB(255,255,255) then return false end

    local size = gui.AbsoluteSize
    local camSize = Camera.ViewportSize

    return size.X >= camSize.X - 5 and size.Y >= camSize.Y - 5
end

-- REMOVE ONLY FULL WHITE SCREEN
local function RemoveWhiteScreen(parent)
    for _,v in pairs(parent:GetDescendants()) do
        if IsFullScreenFrame(v) then
            v:Destroy()
        end
    end
end

pcall(function()
    RemoveWhiteScreen(CoreGui)
    RemoveWhiteScreen(Player:WaitForChild("PlayerGui"))
end)

-- ANTI WHITE SCREEN BẬT LẠI
CoreGui.DescendantAdded:Connect(function(v)
    task.wait()
    if IsFullScreenFrame(v) then
        v:Destroy()
    end
end)

-- NOTIFICATION
pcall(function()
    StarterGui:SetCore("SendNotification",{
        Title = "-Notification-",
        Text = "Removed ✅",
        Duration = 3
    })
end)
