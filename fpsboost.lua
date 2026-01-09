-- FPS BOOST EXTREME FULL (STREAM SAFE + HARD MUTE)

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local Player = Players.LocalPlayer

-- ===== REMOVE CLOUDS =====
for _,v in pairs(Workspace:GetDescendants()) do
    if v:IsA("Clouds") then v:Destroy() end
end

-- ===== LIGHTING OFF =====
pcall(function()
    Lighting.GlobalShadows = false
    Lighting.Brightness = 0
    Lighting.ClockTime = 0
    Lighting.FogEnd = 1e10
    Lighting.Ambient = Color3.new(0,0,0)
    Lighting.OutdoorAmbient = Color3.new(0,0,0)
end)

for _,v in pairs(Lighting:GetChildren()) do
    if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then
        v:Destroy()
    end
end

-- ===== BLACK SKY =====
local sky = Instance.new("Sky", Lighting)
sky.SkyboxBk,sky.SkyboxDn,sky.SkyboxFt = "rbxassetid://0","rbxassetid://0","rbxassetid://0"
sky.SkyboxLf,sky.SkyboxRt,sky.SkyboxUp = "rbxassetid://0","rbxassetid://0","rbxassetid://0"
sky.StarCount = 0

-- ===== HARD SOUND KILL (NO 0.1s) =====
SoundService.Volume = 0
for _,v in pairs(game:GetDescendants()) do
    if v:IsA("Sound") then
        v.Volume = 0
        v:Stop()
        v:Destroy()
    end
end
game.DescendantAdded:Connect(function(v)
    if v:IsA("Sound") then
        v.Volume = 0
        v.Playing = false
        v:Destroy()
    end
end)

-- ===== APPLY GRAY BLOCK / SEA (INITIAL) =====
local function applyGray(v)
    if v:IsA("Terrain") then
        v.WaterWaveSize = 0
        v.WaterWaveSpeed = 0
        v.WaterReflectance = 0
        v.WaterTransparency = 1
        v.WaterColor = Color3.fromRGB(120,120,120)
    elseif v:IsA("BasePart") then
        v.CastShadow = false
        v.Material = Enum.Material.Plastic
        v.Reflectance = 0
        v.Color = Color3.fromRGB(140,140,140)
    elseif v:IsA("Decal") or v:IsA("Texture") then
        v:Destroy()
    elseif v:IsA("ParticleEmitter")
        or v:IsA("Trail")
        or v:IsA("Beam")
        or v:IsA("Fire")
        or v:IsA("Smoke")
        or v:IsA("Sparkles")
        or v:IsA("PointLight")
        or v:IsA("SpotLight")
        or v:IsA("SurfaceLight") then
        v:Destroy()
    end
end

for _,v in pairs(Workspace:GetDescendants()) do
    applyGray(v)
end

-- ===== STREAMING FIX: MAP LOAD TỚI ĐÂU XÁM TỚI ĐÓ =====
Workspace.DescendantAdded:Connect(function(v)
    task.wait()
    pcall(function() applyGray(v) end)
end)

-- ===== INVISIBLE CHARACTER (ALL PLAYERS) =====
local function invisibleChar(char)
    for _,v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = 1
            v.CastShadow = false
        elseif v:IsA("Decal") then
            v:Destroy()
        end
    end
end

for _,plr in pairs(Players:GetPlayers()) do
    if plr.Character then invisibleChar(plr.Character) end
end
Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(invisibleChar)
end)

-- ===== LOWEST RENDER =====
pcall(function()
    settings().Rendering.QualityLevel = 1
end)

-- ===== FPS COUNTER (RAINBOW - ALWAYS ON) =====
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = Player:WaitForChild("PlayerGui")

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0,160,0,30)
label.Position = UDim2.new(0,10,0,10)
label.BackgroundTransparency = 1
label.TextScaled = true
label.Font = Enum.Font.SourceSansBold
label.Text = "FPS : 0"
label.Parent = gui

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
