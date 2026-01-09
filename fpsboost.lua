-- ABSOLUTE FPS BOOST (KEEP SOUND)
-- DELETE EVERYTHING POSSIBLE EXCEPT AUDIO

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- ===== LIGHTING NUKED =====
pcall(function()
    for _,v in pairs(Lighting:GetChildren()) do
        v:Destroy()
    end
    Lighting.GlobalShadows = false
    Lighting.Brightness = 0
    Lighting.FogEnd = 1e10
end)

-- ===== DESTROY / HIDE EVERYTHING (EXCEPT SOUND) =====
for _,v in pairs(Workspace:GetDescendants()) do
    if v:IsA("Sound") then
        -- KEEP SOUND
    elseif v:IsA("BasePart") then
        v.Transparency = 1
        v.CastShadow = false
        v.Material = Enum.Material.Plastic
        v.Reflectance = 0
        v.Anchored = true
    elseif v:IsA("Decal")
        or v:IsA("Texture")
        or v:IsA("SurfaceAppearance") then
        v:Destroy()
    elseif v:IsA("ParticleEmitter")
        or v:IsA("Trail")
        or v:IsA("Beam")
        or v:IsA("Fire")
        or v:IsA("Smoke")
        or v:IsA("Sparkles")
        or v:IsA("Explosion") then
        v.Enabled = false
    elseif v:IsA("Model") then
        pcall(function() v:Destroy() end)
    end
end

-- ===== CHARACTER DELETE (VISUAL ONLY) =====
local function nukeChar(char)
    for _,v in pairs(char:GetDescendants()) do
        if v:IsA("Sound") then
            -- KEEP SOUND
        elseif v:IsA("BasePart") then
            v.Transparency = 1
            v.CastShadow = false
        else
            pcall(function() v:Destroy() end)
        end
    end
end

for _,p in pairs(Players:GetPlayers()) do
    if p.Character then
        nukeChar(p.Character)
    end
end

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(nukeChar)
end)

-- ===== AUTO DELETE NEW OBJECTS (EXCEPT SOUND) =====
Workspace.DescendantAdded:Connect(function(v)
    if v:IsA("Sound") then
        return
    end
    pcall(function()
        if v:IsA("BasePart") then
            v.Transparency = 1
            v.CastShadow = false
            v.Anchored = true
        else
            v:Destroy()
        end
    end)
end)

-- ===== DELETE OTHER GUI (KEEP OWN GUI) =====
for _,v in pairs(LocalPlayer.PlayerGui:GetChildren()) do
    if not v:IsA("ScreenGui") then
        v:Destroy()
    end
end

-- ===== LOWEST RENDER =====
pcall(function()
    settings().Rendering.QualityLevel = 1
end)

-- ===== FPS COUNTER (RAINBOW) =====
local gui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
gui.ResetOnSpawn = false

local label = Instance.new("TextLabel", gui)
label.Size = UDim2.new(0,160,0,30)
label.Position = UDim2.new(0,10,0,10)
label.BackgroundTransparency = 1
label.TextScaled = true
label.Font = Enum.Font.SourceSansBold
label.Text = "FPS : 0"

local frames, last, hue = 0, tick(), 0

RunService.RenderStepped:Connect(function()
    frames += 1
    if tick() - last >= 1 then
        label.Text = "FPS : "..frames
        frames = 0
        last = tick()
    end
    hue = (hue + 0.01) % 1
    label.TextColor3 = Color3.fromHSV(hue,1,1)
end)
