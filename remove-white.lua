-- REMOVE WHITE SCREEN + UI HACK (DELAY 3.5s)

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- DELAY
task.wait(3.5)

-- RESET LIGHTING
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

-- CHECK FULL WHITE SCREEN
local function IsFullWhiteScreen(v)
    if not v:IsA("Frame") then return false end
    if v.BackgroundTransparency > 0.15 then return false end
    if v.BackgroundColor3 ~= Color3.fromRGB(255,255,255) then return false end

    local s = v.AbsoluteSize
    local c = Camera.ViewportSize
    return s.X >= c.X - 5 and s.Y >= c.Y - 5
end

-- REMOVE WHITE SCREEN
local function RemoveWhite(parent)
    for _,v in pairs(parent:GetDescendants()) do
        if IsFullWhiteScreen(v) then
            v:Destroy()
        end
    end
end

RemoveWhite(CoreGui)
RemoveWhite(Player:WaitForChild("PlayerGui"))

-- REMOVE ALL UI HACK (ScreenGui)
for _,v in pairs(CoreGui:GetChildren()) do
    if v:IsA("ScreenGui") then
        -- tránh đụng Roblox UI gốc
        if not v.Name:lower():find("roblox") then
            v:Destroy()
        end
    end
end

-- ANTI SPAWN LẠI
CoreGui.ChildAdded:Connect(function(v)
    task.wait()
    if v:IsA("ScreenGui") and not v.Name:lower():find("roblox") then
        v:Destroy()
    end
end)

CoreGui.DescendantAdded:Connect(function(v)
    task.wait()
    if IsFullWhiteScreen(v) then
        v:Destroy()
    end
end)
