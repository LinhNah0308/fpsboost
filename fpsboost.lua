-- FPS BOOST EXTREME - INVISIBLE + NO SOUND + MINIMAL MAP

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")

-- ===== DELETE ALL LIGHTING =====
Lighting.GlobalShadows = false
Lighting.Brightness = 0
Lighting.ClockTime = 0
Lighting.FogEnd = 9e9
Lighting.OutdoorAmbient = Color3.new(0,0,0)
Lighting.Ambient = Color3.new(0,0,0)

for _,v in pairs(Lighting:GetChildren()) do
    if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then
        v:Destroy()
    end
end

-- ===== BLACK SKY =====
local Sky = Instance.new("Sky", Lighting)
Sky.SkyboxBk = "rbxassetid://0"
Sky.SkyboxDn = "rbxassetid://0"
Sky.SkyboxFt = "rbxassetid://0"
Sky.SkyboxLf = "rbxassetid://0"
Sky.SkyboxRt = "rbxassetid://0"
Sky.SkyboxUp = "rbxassetid://0"
Sky.StarCount = 0

-- ===== DELETE ALL SOUND =====
SoundService.Volume = 0
for _,v in pairs(Workspace:GetDescendants()) do
    if v:IsA("Sound") then
        v:Destroy()
    end
end

-- ===== DELETE ALL EFFECTS + LIGHTS =====
for _,v in pairs(Workspace:GetDescendants()) do
    if v:IsA("ParticleEmitter")
    or v:IsA("Trail")
    or v:IsA("Beam")
    or v:IsA("Fire")
    or v:IsA("Smoke")
    or v:IsA("Sparkles")
    or v:IsA("Explosion")
    or v:IsA("PointLight")
    or v:IsA("SpotLight")
    or v:IsA("SurfaceLight") then
        v:Destroy()
    end
end

-- ===== MINIMAL MAP (NOT 100% DELETE) =====
for _,v in pairs(Workspace:GetDescendants()) do
    if v:IsA("BasePart") then
        v.Material = Enum.Material.SmoothPlastic
        v.Reflectance = 0
        v.CastShadow = false

        -- Giữ part bắt buộc, xoá phần phụ
        if not v.Anchored then
            v:Destroy()
        end
    elseif v:IsA("Decal") or v:IsA("Texture") then
        v:Destroy()
    end
end

-- ===== INVISIBLE PLAYER =====
local function InvisibleChar(char)
    for _,v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = 1
            v.CastShadow = false
        elseif v:IsA("Decal") then
            v:Destroy()
        end
    end
end

local player = Players.LocalPlayer
if player.Character then
    InvisibleChar(player.Character)
end
player.CharacterAdded:Connect(InvisibleChar)
